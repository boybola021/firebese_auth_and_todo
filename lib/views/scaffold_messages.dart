


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

sealed class KTScaffoldMessage{
  static ScaffoldFeatureController scaffoldMessage(context,String message,{Color color = Colors.red}) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message,style: TextStyle(fontSize: 16.sp,color: Colors.white),),backgroundColor: color,));
}