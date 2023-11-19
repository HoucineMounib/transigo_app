import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:transigo_app/Auth/validator/validator.dart';
import 'package:transigo_app/Components/Buttons.dart';
import 'package:transigo_app/Components/Snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _signUpGlobalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool passwordSee = true;

  bool isLoadign = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoadign,
      color: Theme.of(context).primaryColor,
      opacity: 0.1,
      progressIndicator: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/Logo.png',
            scale: 4,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
            size: 32,
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Center(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  child: Form(
                      key: _signUpGlobalKey,
                      child: Column(
                        children: [
                          ///////////////////////// Informations Entering
                          //////////////////
                          ///
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Welcome to ',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'TransiGo ',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' 👋',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          MyFeild(
                              controller: nameController,
                              validation: AuthValidator.isNameValid,
                              passwordStat: false,
                              icon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                              bordercolor: Theme.of(context).primaryColor,
                              title: 'Name',
                              titlecolor: Theme.of(context).primaryColorDark),
                          MyFeild(
                              controller: emailController,
                              validation: AuthValidator.isEmailValid,
                              passwordStat: false,
                              icon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              ),
                              bordercolor: Theme.of(context).primaryColor,
                              title: 'Email',
                              titlecolor: Theme.of(context).primaryColorDark),
                          PhoneFormFeild(
                              controller: phoneController,
                              bordercolor: Theme.of(context).primaryColor,
                              title: 'Phone Number',
                              titlecolor: Theme.of(context).primaryColorDark),
                          MyFeild(
                            controller: passwordController,
                            validation: AuthValidator.isPasswordValid,
                            passwordStat: passwordSee,
                            icon: Icon(
                              Icons.lock,
                              color: Theme.of(context).primaryColor,
                            ),
                            bordercolor: Theme.of(context).primaryColor,
                            title: 'Password',
                            titlecolor: Theme.of(context).primaryColorDark,
                            passwordView: GestureDetector(
                              onTap: () {
                                passwordSee = !passwordSee;
                                setState(() {});
                              },
                              child: Icon(
                                passwordSee == true
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              MyButtonTwo(
                                  text: "Sign Up",
                                  onPressed: () async {
                                    if (_signUpGlobalKey.currentState!
                                        .validate()) {
                                      isLoadign = true;
                                      setState(() {});
                                      try {
                                        await RegisterUser(context);
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          ErrorMessage(context,
                                              'The password provided is too weak');
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          ErrorMessage(context,
                                              'The account already exists for that email');
                                        }
                                      } catch (e) {
                                        ErrorMessage(context, e.toString());
                                      }

                                      isLoadign = false;
                                      setState(() {});
                                    }
                                  }),
                              const SizedBox(height: 24),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'By clicking on “Sign up” you are agreeing to our \n',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'terms of use ',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                              const MyButtonOne(
                                iconUrl: 'assets/ic_google.png',
                                text: "Sign Up with Google",
                              ),
                              const SizedBox(height: 50),
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Already have an account ? ',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.25,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Sign In',
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
                )
              ],
            ),
          ),
        ))),
      ),
    );
  }

  Future<void> RegisterUser(BuildContext context) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    Navigator.of(context).pushReplacementNamed('home');

    SucssesMessage(context, 'Account has been Created Sucssesfuly!');
  }
}

Widget MyFeild(
    {required TextEditingController controller,
    required validation,
    required Color bordercolor,
    required String title,
    Icon? icon,
    Widget? passwordView,
    required bool passwordStat,
    required Color titlecolor}) {
  return Column(
    children: [
      Container(
          margin: EdgeInsets.only(bottom: 8),
          alignment: Alignment.centerLeft,
          child: Text(title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: titlecolor))),
      TextFormField(
        controller: controller,
        obscureText: passwordStat,
        validator: validation,
        decoration: InputDecoration(
          prefixIcon: icon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: bordercolor, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: bordercolor, width: 5),
          ),
          hintText: "Enter Your $title",
          suffixIcon: passwordView,
        ),
      ),
      const SizedBox(height: 30),
    ],
  );
}

Widget PhoneFormFeild(
    {required TextEditingController controller,
    required Color bordercolor,
    required String title,
    required Color titlecolor}) {
  return Column(
    children: [
      Container(
          margin: EdgeInsets.only(bottom: 8),
          alignment: Alignment.centerLeft,
          child: Text(title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: titlecolor))),
      IntlPhoneField(
        controller: controller,
        initialCountryCode: 'CH',
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIconColor: bordercolor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: bordercolor, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: bordercolor, width: 5),
          ),
          hintText: "Enter Your Phone Nember ",
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}
