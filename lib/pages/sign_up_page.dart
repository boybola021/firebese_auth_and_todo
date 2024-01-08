import 'package:firebase_auth_and_todo/cubit/auth/auth_cubit.dart';
import 'package:firebase_auth_and_todo/pages/sign_in_page.dart';
import 'package:firebase_auth_and_todo/services/strings.dart';
import 'package:firebase_auth_and_todo/views/scaffold_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../services/auth_service.dart';
import '../services/icons.dart';
import '../services/util.dart';
import '../views/custom_text_fild.dart';
import 'loading_page.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({Key? key}) : super(key: key);

   final nameController = TextEditingController();
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final prePasswordController = TextEditingController();
  static bool isLoading = true;

   void signUp(context) async {
     String name = nameController.text.trim();
     String email = emailController.text.trim();
     String password = passwordController.text.trim();
     String prePassword = prePasswordController.text.trim();

     if(email.isEmpty || password.isEmpty || name.isEmpty || prePassword.isEmpty) {
       KTScaffoldMessage.scaffoldMessage(context, "Field empty,check field");
       return;
     }

     isLoading = true;
     showDialog(
         context: context,
         builder: (context){
           return const LoadingPage();
         });
     final success = await BlocProvider.of<AuthCubit>(context).signUp(username: name, email: email, password: password, prePassword: prePassword);
     if(success && context.mounted) {
       isLoading = false;
       Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(193,53,132,1),
                  Color.fromRGBO(131,58,188,1),
                ],
              )
          ),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(I18N.signup, style: Theme.of(context).textTheme.headlineLarge,),
                SizedBox(height: 15.h,),
                CustomTextField(
                  onSubmitted: (String text) {
                    if (!Util.regexName(text)) {
                      KTScaffoldMessage.scaffoldMessage(
                          context, I18N.nameMessage);
                      nameController.text = "";
                    }
                  },
                  hintText: I18N.username,
                  controller: nameController,
                ),
                SizedBox(height: 15.h,),
                CustomTextField(
                  onSubmitted: (String text) {
                    if (!Util.regexEmail(text)) {
                      KTScaffoldMessage.scaffoldMessage(
                          context, I18N.emailMessage);
                      emailController.text = "";
                    }
                  },
                  hintText: I18N.email,
                  controller: emailController,
                ),
                SizedBox(height: 15.h,),

                CustomTextField(
                  onSubmitted: (String text) {
                    if (!Util.regexPassword(text)) {
                      KTScaffoldMessage.scaffoldMessage(
                          context, I18N.passwordMessage);
                      passwordController.text = "";
                    }
                  },
                    controller: passwordController,
                    hintText: I18N.password,
                ),
                SizedBox(height: 15.h,),
                CustomTextField(
                  onSubmitted: (String text) {
                    if (passwordController.text != prePasswordController.text) {
                      KTScaffoldMessage.scaffoldMessage(
                          context, I18N.invalidValuePrePass);
                      prePasswordController.text = "";
                    }
                  },
                    controller: prePasswordController,
                    hintText: I18N.prePassword,
                ),
                SizedBox(height: 15.h,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.white.withOpacity(0.2),
                        highlightColor: Colors.white.withOpacity(.3),
                        child: ElevatedButton(
                          clipBehavior: Clip.antiAlias,
                          onPressed: () => signUp(context),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              MediaQuery.sizeOf(context).width,
                              45.h,
                            ),
                            backgroundColor: Colors.purple,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                            alignment: Alignment.center,
                            elevation: 0,
                          ),
                          child: const Text(""),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          I18N.signup,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20.sp,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                Row(
                  children: [
                    Text("${I18N.alreadyHaveAccount} ",style: TextStyle(fontSize: 18.sp,color: Colors.white54),),
                    TextButton(onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  const SignInPage()));
                    },
                        child:  Text(I18N.signin,style: TextStyle(fontSize: 18.sp,color: Colors.red),)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

