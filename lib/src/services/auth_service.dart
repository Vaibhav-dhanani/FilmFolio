import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;

  Future<UserCredential> signInWithEmailPassword(String email,String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (error) {
      throw Exception(error.code);
    }
  }

  Future<UserCredential> signUpWithEmailPassword (String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }on FirebaseException catch (e) {
        throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await auth.signOut();
  }

}