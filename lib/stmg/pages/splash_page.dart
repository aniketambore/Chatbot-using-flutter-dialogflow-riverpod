import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:freecodecamp_chatbot/stmg/models/app_config.dart';
import 'package:freecodecamp_chatbot/stmg/services/chatbot_service.dart';
import 'package:freecodecamp_chatbot/stmg/services/dialogflow_service.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key, required this.onInitializationComplete})
      : super(key: key);

  final VoidCallback onInitializationComplete;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then(
        (_) => _setup(context).then((_) => widget.onInitializationComplete()));
  }

  Future<void> _setup(BuildContext context) async {
    DialogAuthCredentials credentials = await DialogAuthCredentials.fromFile(
        "assets/config/freecodecamp-chatbot-proj-9jre-6928640b895b.json");

    final getIt = GetIt.instance;

    getIt.registerSingleton<AppConfig>(AppConfig(
        dialogflowInstance: DialogFlowtter(credentials: credentials)));
    getIt.registerSingleton<DialogflowService>(DialogflowService());
    getIt.registerSingleton<ChatbotService>(ChatbotService());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FreeCodeCamp Chatbot",
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    "assets/images/robot.png",
                  ))),
        ),
      ),
    );
  }
}
