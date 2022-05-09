import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:freecodecamp_chatbot/stmg/models/bot_model.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key, this.botModel}) : super(key: key);
  final BotModel? botModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: botModel!.data == 1
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Bubble(
                stick: true,
                nip: botModel!.data == 0
                    ? BubbleNip.leftTop
                    : BubbleNip.rightTop,
                color:
                    botModel!.data == 0 ? Color(0xFF00C6AE) : Color(0xFFFFD465),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 170),
                    child: Text(
                      botModel!.message ?? "",
                      style: const TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
