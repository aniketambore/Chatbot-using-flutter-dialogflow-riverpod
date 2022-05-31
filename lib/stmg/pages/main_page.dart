import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freecodecamp_chatbot/stmg/controllers/main_page_data_controller.dart';
import 'package:freecodecamp_chatbot/stmg/models/bot_model.dart';
import 'package:freecodecamp_chatbot/stmg/models/main_page_data.dart';
import 'package:freecodecamp_chatbot/stmg/widgets/chat_item.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, MainPageData>((ref) {
  return MainPageDataController();
});

class MainPage extends ConsumerWidget {
  MainPage({Key? key}) : super(key: key);

  final _messageTextFieldController = TextEditingController();
  late MainPageDataController _mainPageDataController;
  late MainPageData _mainPageData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _mainPageDataController =
        ref.watch(mainPageDataControllerProvider.notifier);
    _mainPageData = ref.watch(mainPageDataControllerProvider);
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E7FC),
      appBar: AppBar(
        title: const Text("FreeCodeCamp Chatbot"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Column(
              children: <Widget>[
                _topBubbleWidget(),
                _chatMessagesContainer(),
                const SizedBox(
                  height: 20,
                ),
                _textInputFieldWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBubbleWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Bubble(
        alignment: Alignment.topCenter,
        color: const Color.fromRGBO(212, 234, 244, 1.0),
        child: const Text('TODAY',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0)),
      ),
    );
  }

  Widget _chatMessagesContainer() {
    /* Dummy for loop to hold dummy messages.
    final List<BotModel> _botMessages = [];
    for (var i = 0; i < 20; i++) {
      _botMessages.add(
        BotModel(message: "Hello Sir !", data: 0),
      );
      _botMessages.add(
        BotModel(message: "What's up bot", data: 1),
      );
    }
    */

    final List<BotModel> _botMessages = _mainPageData.botModel!;
    return Flexible(
      // child: Container(),
      child: ListView.builder(
          reverse: true,
          itemCount: _botMessages.length,
          itemBuilder: (context, index) => ChatItem(
                botModel: _botMessages[index],
              )),
    );
  }

  Widget _textInputFieldWidget() {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 61,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.face), onPressed: () {}),
                  Expanded(
                    child: TextField(
                      controller: _messageTextFieldController,
                      decoration: const InputDecoration(
                          hintText: "Type Something...",
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
                color: Colors.indigoAccent, shape: BoxShape.circle),
            child: InkWell(
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
              ),
              onTap: () {
                if (_messageTextFieldController.text.isEmpty) {
                  print("[!] Empty Message Bro :(");
                } else {
                  _mainPageDataController
                      .userQuestion(_messageTextFieldController.text);
                  _messageTextFieldController.clear();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
