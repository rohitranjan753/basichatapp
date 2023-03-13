import 'package:chatproject/auth_screen.dart';
import 'package:chatproject/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          backgroundColor: Colors.pink[200],
          accentColor: Colors.deepPurpleAccent,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)))),

      //auth state chnages when we login, sign out,sign up etc.
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return SplashScreen();
          // }
          if (snapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();

        },
      ),
    );
  }
}
