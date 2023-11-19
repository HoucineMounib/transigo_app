import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:transigo_app/Auth/validator/validator.dart';
import 'package:transigo_app/Components/Buttons.dart';
import 'package:transigo_app/Components/Snack_bar.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _signInGlobalKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool passwordSee = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: Theme.of(context).primaryColor,
      opacity: 0.1,
      progressIndicator: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          margin: const EdgeInsets.only(
            top: 50,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                // color: Theme.of(context).primaryColorLight,
                child: GestureDetector(
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/Login_image.png',
                          scale: 4,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Let’s ',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 32,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: 'Get Started!',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 32,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Form(
                            key: _signInGlobalKey,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  alignment: Alignment.centerLeft,
                                  child: Text('Email',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                          color: Theme.of(context)
                                              .primaryColorDark)),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  validator: AuthValidator.isEmailValid,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 5),
                                      ),
                                      hintText: "Email address"),
                                ),
                                const SizedBox(height: 30),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  alignment: Alignment.centerLeft,
                                  child: Text('Password',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                          color: Theme.of(context)
                                              .primaryColorDark)),
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: passwordSee,
                                  validator: AuthValidator.isPasswordValid,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 2),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 5),
                                    ),
                                    hintText: "Password",
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        passwordSee = !passwordSee;
                                        setState(() {});
                                      },
                                      child: Icon(
                                        passwordSee
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Column(
                          children: [
                            MyButtonTwo(
                                text: "Sign In",
                                onPressed: () async {
                                  if (_signInGlobalKey.currentState!
                                      .validate()) {
                                    isLoading = true;

                                    setState(() {});
                                    try {
                                      final credential = await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                      Navigator.of(context)
                                          .pushReplacementNamed('home');
                                      SucssesMessage(context, 'Welcom Back!');
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code ==
                                          'INVALID_LOGIN_CREDENTIALS') {
                                        print(
                                            '========No user found for that email.');
                                        ErrorMessage(context,
                                            "No User Found, Try Agian!");
                                      } else if (e.code == 'wrong-password') {
                                        print(
                                            'Wrong password provided for that user.');
                                        ErrorMessage(context,
                                            "'Wrong password provided for that user.");
                                      }
                                    }
                                    isLoading = false;

                                    setState(() {});
                                  }
                                }),
                            const SizedBox(height: 24),
                            Text(
                              "Or",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 24),
                            MyButtonOne(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed("routeName");
                              },
                              iconUrl: 'assets/ic_google.png',
                              text: "Sign  in with Google",
                            ),
                            const SizedBox(height: 32),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).pushNamed("signup"),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Don’t have an account ? ',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.25,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Sign Up',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
