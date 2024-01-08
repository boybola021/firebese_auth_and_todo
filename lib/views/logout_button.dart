
import 'dart:io';

import 'package:firebase_auth_and_todo/pages/sign_in_page.dart';
import 'package:firebase_auth_and_todo/services/icons.dart';
import 'package:firebase_auth_and_todo/views/scaffold_messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/strings.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  Future<void> logout(context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          if (Platform.isAndroid) {
            /// addroid uchun
            return AlertDialog(
              title: const Text("Attention"),
              content: const Text("Do you really want to sign out"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () async {
                    final signOut = await AuthService.signOut();
                    if (signOut) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) =>  SignInPage(),
                          ),
                              (route) => false);
                    } else {
                      KTScaffoldMessage.scaffoldMessage(
                          context, I18N.somethingError);
                    }
                  },
                  child: const Text("Yes"),
                ),
              ],
            );
          } else {
            /// iPone uchuun dialog
            return CupertinoAlertDialog(
              title: const Text("Attention"),
              content: const Text("Do you really want to sign out"),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
                CupertinoDialogAction(
                  onPressed: () async {
                    final signOut = await AuthService.signOut();
                    if (signOut) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) =>  SignInPage(),
                          ),
                              (route) => false);
                    } else {
                      KTScaffoldMessage.scaffoldMessage(
                          context, I18N.somethingError);
                    }
                  },
                  child: const Text("Yes"),
                ),
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        //border: Border.all(color: Colors.grey),
      ),
      child: IconButton(
        onPressed: () => logout(context),
        icon:  const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Log out",
              style: TextStyle(fontSize: 20),
            ),
            KTIcons.logout
          ],
        ),
      ),
    );
  }
}
