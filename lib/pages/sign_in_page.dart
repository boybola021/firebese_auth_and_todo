
import 'package:firebase_auth_and_todo/cubit/auth/auth_cubit.dart';
import 'package:firebase_auth_and_todo/pages/loading_page.dart';
import 'package:firebase_auth_and_todo/pages/sign_up_page.dart';
import 'package:firebase_auth_and_todo/src/service_locator.dart';
import 'package:firebase_auth_and_todo/src/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';
import '../services/auth_service.dart';
import '../services/strings.dart';
import '../services/util.dart';
import '../views/custom_text_fild.dart';
import '../views/scaffold_messages.dart';
import 'home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  void signIn(BuildContext context) async {

    String email = emailController.text;
    String password = passwordController.text;

    if(email.isEmpty || password.isEmpty) {
      KTScaffoldMessage.scaffoldMessage(context, "Field empty,check field");
      return;
    }
    showDialog(
        context: context,
        builder: (context){
          return const LoadingPage();
        });
    isLoading = true;
    final response = await BlocProvider.of<AuthCubit>(context).signIn(email: email, password: password);
    if(response && context.mounted) {
      localRepository.storeUser(
        UserSRC(
            id: const Uuid().v4(),
            name: AuthService.user.displayName ?? "No name",
            email: email,
            password: password
        ),
      );
      isLoading = false;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(193,53,132,1),
                Color.fromRGBO(131,58,188,1),
              ],
            ),
        ),
        padding: const EdgeInsets.all(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(I18N.signin, style: Theme.of(context).textTheme.headlineLarge,),
                const SizedBox(height: 20,),
                CustomTextField(
                  onSubmitted: (String text) {
                    if (!Util.regexEmail(text)) {
                      KTScaffoldMessage.scaffoldMessage(
                          context, I18N.emailMessage);
                      emailController.text = "";
                    }
                  },
                    controller: emailController,
                    hintText: I18N.email,
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                    onSubmitted: (String text) {
                      if (!Util.regexPassword(text)) {
                        KTScaffoldMessage.scaffoldMessage(
                            context, I18N.passwordMessage);
                        passwordController.text = "";
                      }
                    },
                    controller: passwordController, hintText: I18N.password),
                const SizedBox(height: 20,),
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
                          onPressed:() => signIn(context),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              MediaQuery.sizeOf(context).width,
                              55,
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
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          I18N.signin,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20.0,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const Text(I18N.dontHaveAccount,style: TextStyle(fontSize: 18,color: Colors.white54),),
                    TextButton(onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  SignUpPage()));
                    },
                        child: const Text(I18N.signup,style: TextStyle(fontSize: 18,color: Colors.red),)),
                  ],
                ),
              ],
            ),
            if(isLoading) const LoadingPage(),
          ],
        ),
      ),
    );
  }
}



