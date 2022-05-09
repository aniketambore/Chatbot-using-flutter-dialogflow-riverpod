import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:freecodecamp_chatbot/stmg/models/bot_model.dart';
import 'package:freecodecamp_chatbot/stmg/services/dialogflow_service.dart';
import 'package:get_it/get_it.dart';

class ChatbotService {
  final GetIt getIt = GetIt.instance;
  DialogflowService? _dialogflowService;

  ChatbotService() {
    _dialogflowService = getIt.get<DialogflowService>();
  }

  Future<List<BotModel>> getBotResponse({required String userQuery}) async {
    DetectIntentResponse? _aiResponse =
        await _dialogflowService!.getResponse(userQuery: userQuery);
    List<BotModel> _botModel = [BotModel(data: 0, message: _aiResponse?.text)];
    return _botModel;
  }
}
