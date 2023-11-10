import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunch_app/home/home_page.dart';
import 'package:lunch_app/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LunchApp extends StatefulWidget {
  const LunchApp({super.key});

  @override
  State<LunchApp> createState() => _LunchAppState();
}

class _LunchAppState extends State<LunchApp> {
  late Stream<User?> authStateChanges;

  @override
  void initState() {
    super.initState();

    authStateChanges = FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MealMaven',
      // ignore: deprecated_member_use
      theme:
      //  ThemeData(),

   
    ThemeData(useMaterial3: true),

      home: StreamBuilder<User?>(
        stream: authStateChanges,
        builder: (
          BuildContext context,
          AsyncSnapshot<User?> snapshot,
        ) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  !snapshot.hasError) {
                return HomePage();
              } else {
                return LoginPage();
              }
            default:
              return LoginPage();
          }
        },
      ),
    );
  }
}
