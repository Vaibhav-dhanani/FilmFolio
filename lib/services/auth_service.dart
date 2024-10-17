import 'package:filmfolio/controllers/user_controller.dart';
import 'package:filmfolio/models/user.dart';
import 'package:filmfolio/services/nottification_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final UserController _userController = UserController();
  final NotificationService _notificationService = NotificationService();

  Future<firebase_auth.UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      firebase_auth.UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Handle user authentication and subscribe to notifications
      await _handleUserAuthentication(email);

      return userCredential;
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw Exception(error.message ?? 'An error occurred during sign in');
    }
  }

  Future<firebase_auth.UserCredential> signUpWithEmailPassword(String email, String password) async {
    try {
      firebase_auth.UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Handle user authentication and subscribe to notifications
      await _handleUserAuthentication(email);

      return userCredential;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'An error occurred during sign up');
    }
  }

  Future<void> signOut() async {
    try {
      String? email = await _getUserEmail();
      if (email != null) {
        User? user = await _userController.getUser(email);

        // Unsubscribe from admin notifications if the user is an admin
        if (user?.isAdmin ?? false) {
          await _notificationService.unsubscribeFromAdminTopic();
        }
      }

      // Clear stored user data and sign out from Firebase Auth
      await _clearUserData();
      await _auth.signOut();
    } catch (e) {
      print('Error during sign out: $e');
      throw Exception('Failed to sign out');
    }
  }

  Future<bool> isUserAdmin() async {
    try {
      String? email = await _getUserEmail();
      if (email != null) {
        User? user = await _userController.getUser(email);
        return user?.isAdmin ?? false;
      }
      return false;
    } catch (e) {
      print('Error checking admin status: $e');
      return false;
    }
  }

  // Update user role and notification preferences
  Future<void> updateUserRole(String email, bool isAdmin) async {
    try {
      // Update user notification subscriptions based on their new role
      await _notificationService.updateUserSubscriptions(isAdmin);
    } catch (e) {
      print('Error updating user role notifications: $e');
      throw Exception('Failed to update notification preferences');
    }
  }

  // Private method to handle authentication and notifications
  Future<void> _handleUserAuthentication(String email) async {
    User? user = await _userController.getUser(email);

    if (user != null) {
      // Store user data locally
      await _storeUserData(user);

      // Subscribe to notification topics based on user's admin status
      await _notificationService.subscribeUserToTopics(user.isAdmin ?? false);
    }
  }

  // Store user data in SharedPreferences
  Future<void> _storeUserData(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', user.id);
    await prefs.setString('user_name', user.name);
    await prefs.setString('user_email', user.email);
    await prefs.setString('user_profile', user.profileUrl);
  }

  // Clear stored user data from SharedPreferences
  Future<void> _clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Get user email from SharedPreferences
  Future<String?> _getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }
}
