
import 'package:flutter/material.dart';

import '../auth/authService.dart';
import '../views/login_Screen.dart';


class HomeViewModel extends ChangeNotifier {
  final AuthService authService;

  HomeViewModel({required this.authService});

  int _selectedIndex = 0;
  TextEditingController _postController = TextEditingController();

  int get selectedIndex => _selectedIndex;
  TextEditingController get postController => _postController;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void signOut(BuildContext context) async {
    try {
      await authService.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print('Sign out error: $e');
    }
  }

  Future<void> savePostToFirebase(
      String postContent, BuildContext context) async {
    try {
      await authService.savePost(postContent);
    } catch (e) {
      print('Error saving post: $e');
    }
  }
}
