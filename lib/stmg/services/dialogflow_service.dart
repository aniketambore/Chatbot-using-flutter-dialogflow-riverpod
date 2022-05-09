import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:freecodecamp_chatbot/stmg/models/app_config.dart';
import 'package:get_it/get_it.dart';

class DialogflowService {
  late DialogFlowtter dialogflow;
  final GetIt getIt = GetIt.instance;

  DialogflowService() {
    AppConfig _config = getIt.get<AppConfig>();
    dialogflow = _config.dialogflowInstance;
    print("[+] Initialized Dialogflowtter from a JSON file.");
  }

  Future<DetectIntentResponse?> getResponse({required String userQuery}) async {
    try {
      DetectIntentResponse aiResponse = await dialogflow.detectIntent(
          queryInput: QueryInput(text: TextInput(text: userQuery)));
      return aiResponse;
    } catch (e) {
      print(
          "[!] Something is wrong with [getResponse] method of [dialogflowtter_service.dart]");
      print("[!] Error is $e");
    }
  }
}
