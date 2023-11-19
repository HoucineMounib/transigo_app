import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transigo_app/Auth/LogIn_Screen.dart';
import 'package:transigo_app/Screens/Onboarding_screens.dart';
import 'package:transigo_app/Auth/SignUp_Screen.dart';
import 'package:transigo_app/Screens/Splash_Screen.dart';
import 'package:transigo_app/Screens/chat_screen.dart';
import 'package:transigo_app/Screens/home_screen.dart';
import 'package:transigo_app/Components/app_theme.dart';

int? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('===========================User is currently signed out!');
      } else {
        print('===================================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      'onboarding': (context) => const OnboardignScreen(),
      'splash': (context) => const SplashScreen(),
      'login': (context) => LogInScreen(),
      'signup': (context) => SignUpScreen(),
      'home': (context) => HomeScreen(),
      // 'chat': (context) => ChatScreen(),
    }, theme: theme(), debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
