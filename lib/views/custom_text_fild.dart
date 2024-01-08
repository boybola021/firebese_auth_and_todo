

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? prefix;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? errorText;
  final  void Function(String)?onSubmitted;
  const CustomTextField({Key? key,this.prefix,required this.controller,this.suffixIcon,this.obscureText = false, this.onSubmitted,this.errorText, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onSubmitted: onSubmitted,
        style: const TextStyle(color: Colors.white),
        decoration:  InputDecoration(
          hintText: hintText,
          prefix: prefix,
          errorText: errorText,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          hintStyle: const TextStyle(fontSize: 17,color: Colors.white54),
        ),),
    );
  }
}


