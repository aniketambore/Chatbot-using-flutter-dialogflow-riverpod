import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freecodecamp_chatbot/stmg/models/bot_model.dart';
import 'package:freecodecamp_chatbot/stmg/models/main_page_data.dart';
import 'package:freecodecamp_chatbot/stmg/services/chatbot_service.dart';
import 'package:get_it/get_it.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData? state])
      : super(state ?? MainPageData.initial()) {
    getResponse();
  }

  final ChatbotService _chatbotService = GetIt.instance.get<ChatbotService>();

  Future<void> getResponse() async {
    try {
      List<BotModel> _botModel = [];

      _botModel =
          await _chatbotService.getBotResponse(userQuery: state.userQuery);
      state = state.copyWith(
          // Updating the state with copyWith function, Combining the current Bot Model [..._botModel] with the already existing Bot Model state [...state.botModel!]
          botModel: [..._botModel, ...state.botModel!], userQuery: "");
    } catch (e) {
      print(
          "[!] Something is wrong with [getResponse] method of [main_page_data_controller.dart]");
      print("[!] Error is $e");
    }
  }

  void userQuestion(String _userQuery) {
    List<BotModel> _botModel = [BotModel(data: 1, message: _userQuery)];
    state = state.copyWith(
        botModel: [..._botModel, ...state.botModel!], userQuery: _userQuery);
    getResponse();
  }
}
