
import 'package:firebase_auth_and_todo/src/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/app.dart';
import 'firebase_options/firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  /// #firebase initail
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// #ScreenUnitil for reponsive
  await ScreenUtil.ensureScreenSize();

  /// #local control
  await serviceLocatorLocal();


  runApp(const App());
}




/*
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    if(email.isEmpty || password.isEmpty) {
      return;
    }

    final user = await AuthService.signIn(email, password);
    print("USER: $user");
    if(user != null && context.mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Sign In", style: Theme.of(context).textTheme.headlineLarge,),
              const SizedBox(height: 20,),
              TextField(controller: emailController, decoration: const InputDecoration(hintText: "Email"),),
              const SizedBox(height: 20,),
              TextField(controller: passwordController, decoration: const InputDecoration(hintText: "Password"),),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: signIn, child: const Text("Sign In")),
              const SizedBox(height: 20,),
              TextButton(onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignUpPage()));
              }, child:const  Text("Don't have an account? SignUp")),
            ],
          ),
        ),
      ),
    );
  }
}


/// sign up



class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUp() async {
    String email = emailController.text;
    String password = passwordController.text;

    if(email.isEmpty || password.isEmpty) {
      return;
    }

    final success = await AuthService.signUp(email, password,"Boy");
    if(success && context.mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Sign Up", style: Theme.of(context).textTheme.headlineLarge,),
              const SizedBox(height: 20,),
              TextField(controller: emailController, decoration: const InputDecoration(hintText: "Email"),),
              const SizedBox(height: 20,),
              TextField(controller: passwordController, decoration: const InputDecoration(hintText: "Password"),),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: signUp, child: const Text("Sign Up")),
              const SizedBox(height: 20,),
              TextButton(onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignInPage()));
              }, child: const Text("Already have an account? SignIn")),
            ],
          ),
        ),
      ),
    );
  }

}
*/

