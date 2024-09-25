import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/user.dart';
import '../../controllers/user_controller.dart';
import 'package:path/path.dart' as path;

class UserFullProfile extends StatefulWidget {
  @override
  _UserFullProfileState createState() => _UserFullProfileState();
}

class _UserFullProfileState extends State<UserFullProfile> {
  String userName = "";
  String userEmail = "";
  String profileImageUrl = "";
  File? _profileImage;

  final UserController _userController = UserController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  User? user;
  bool _isResetPasswordVisible = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  fetchUser() async {
    user = await _userController.loadUserFromLocalStorage();
    setState(() {
      userName = user!.name;
      userEmail = user!.email;
      profileImageUrl = user!.profileUrl;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      try {
        String fileName = path.basename(pickedFile.path);
        Reference ref = FirebaseStorage.instance.ref().child('filmfolio/$userName/$fileName');
        UploadTask uploadTask = ref.putFile(_profileImage!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String url = await taskSnapshot.ref.getDownloadURL();
        _userController.updateUser(userName, userEmail, url);
        _userController.saveUserToLocalStorage(user!.id, user!.name, user!.email, url);
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildProfileInfo(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isResetPasswordVisible = !_isResetPasswordVisible;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(_isResetPasswordVisible ? 'Hide Reset' : 'Password Reset'),
            ),
            const SizedBox(height: 20),
            if (_isResetPasswordVisible) _buildResetPasswordForm(),
          ],
        ),
      ),
    );
  }


  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: profileImageUrl != null
              ? NetworkImage(profileImageUrl)
              : AssetImage("assets/images/user.png") as ImageProvider,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _pickImage,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
          ),
          child: Text('Change Profile Picture'),
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.person, color: Colors.amber),
          title: Text('Name', style: TextStyle(color: Colors.white)),
          subtitle: Text(userName, style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: Icon(Icons.email, color: Colors.amber),
          title: Text('Email', style: TextStyle(color: Colors.white)),
          subtitle: Text(userEmail, style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildResetPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          TextFormField(
            controller: _oldPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              labelText: 'Old Password',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your old password';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _newPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'New Password',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitPasswordReset,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.amber,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Reset Password'),
          ),
        ],
      ),
    );
  }

  void _submitPasswordReset() async {
    if (_formKey.currentState!.validate()) {
      try {
        firebase_auth.User? currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
        firebase_auth.AuthCredential credential = firebase_auth.EmailAuthProvider.credential(
          email: currentUser!.email!,
          password: _oldPasswordController.text,
        );

        await currentUser.reauthenticateWithCredential(credential);
        await currentUser.updatePassword(_newPasswordController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successful')),
        );
        _oldPasswordController.clear();
        _newPasswordController.clear();
      } on firebase_auth.FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    }
  }
}
