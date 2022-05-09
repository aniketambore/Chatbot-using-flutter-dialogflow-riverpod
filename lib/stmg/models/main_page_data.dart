import 'package:freecodecamp_chatbot/stmg/models/bot_model.dart';

class MainPageData {
  final List<BotModel>? botModel;
  final String userQuery;

  MainPageData({this.botModel, required this.userQuery});

  MainPageData.initial()
      : botModel = [],
        userQuery = "Hello";

  MainPageData copyWith({List<BotModel>? botModel, String? userQuery}) {
    return MainPageData(
        botModel: botModel ?? this.botModel,
        userQuery: userQuery ?? this.userQuery);
  }
}
