import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../auth/authService.dart';
import '../model/postModel.dart';
import '../model/userModel.dart';

class UserProfileViewModel extends ChangeNotifier {
  final AuthService authService;
  final String userId;

  UserProfileViewModel({required this.authService, required this.userId});

  Stream<UserModel> getUser() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => UserModel.fromFirestore(snapshot));
  }

  Stream<List<Post>> getUserPosts() {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList());
  }
}
