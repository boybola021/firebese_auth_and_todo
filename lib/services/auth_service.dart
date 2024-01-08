



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

/// # auth
sealed class AuthService {
  static final auth = FirebaseAuth.instance;

  static Future<bool> signUp(String email, String password, String username) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
        debugPrint(credential.user.toString());
      if(credential.user != null) {
        await credential.user!.updateDisplayName(username);
      }
      return credential.user != null;
    } catch (e) {
      debugPrint("Auth ERROR: $e");
      return false;
    }
  }

  static Future<bool> signIn(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user != null;
    } catch(e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }

  static Future<bool> signOut() async {
    try {
      await auth.signOut();
      return true;
    } catch (e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }

  static Future<bool> deleteAccount() async {
    try {
      if(auth.currentUser != null) {
        await auth.currentUser!.delete();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }

  static User get user => auth.currentUser!;

}


