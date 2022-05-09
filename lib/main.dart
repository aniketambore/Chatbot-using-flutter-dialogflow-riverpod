import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freecodecamp_chatbot/stful/chat_screen.dart';
import 'package:freecodecamp_chatbot/stmg/pages/main_page.dart';
import 'package:freecodecamp_chatbot/stmg/pages/splash_page.dart';

void main() {
  runApp(SplashPage(
    onInitializationComplete: () => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreeCodeCamp Chatbot',
      initialRoute: "home",
      // routes: {"home": (BuildContext _context) => ChatScreen()},
      routes: {"home": (BuildContext _context) => MainPage()},
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}
