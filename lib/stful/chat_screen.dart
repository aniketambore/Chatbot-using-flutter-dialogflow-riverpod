import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageInsert = TextEditingController();
  List<Map> messsages = [];
  late DialogFlowtter dialogflow;

  @override
  void initState() {
    super.initState();
    _initDialogflow();
  }

  void _initDialogflow() {
    DialogAuthCredentials.fromFile(
            "assets/config/freecodecamp-chatbot-proj-9jre-6928640b895b.json")
        .then((credentials) {
      dialogflow = DialogFlowtter(credentials: credentials);
      response("Hello");
    });
  }

  void response(query) async {
    DetectIntentResponse aiResponse = await dialogflow.detectIntent(
        queryInput: QueryInput(text: TextInput(text: query)));

    setState(() {
      messsages.insert(0, {"data": 0, "message": aiResponse.text});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9E7FC),
      appBar: AppBar(
        title: Text("ChatBot"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Bubble(
                    alignment: Alignment.topCenter,
                    color: Color.fromRGBO(212, 234, 244, 1.0),
                    child: const Text('TODAY',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11.0)),
                  ),
                ),
                Flexible(
                    child: ListView.builder(
                        reverse: true,
                        itemCount: messsages.length,
                        itemBuilder: (context, index) => chat(
                            messsages[index]["message"].toString(),
                            messsages[index]["data"]))),
                const SizedBox(
                  height: 20,
                ),
                Container(
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
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.face), onPressed: () {}),
                              Expanded(
                                child: TextField(
                                  controller: messageInsert,
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
                            if (messageInsert.text.isEmpty) {
                              print("empty message");
                            } else {
                              setState(() {
                                messsages.insert(0,
                                    {"data": 1, "message": messageInsert.text});
                              });

                              response(messageInsert.text);
                              messageInsert.clear();
                              print("Message list is $messsages");
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Bubble(
                stick: true,
                nip: data == 0 ? BubbleNip.leftTop : BubbleNip.rightTop,
                color: data == 0 ? Color(0xFF00C6AE) : Color(0xFFFFD465),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 170),
                    child: Text(
                      message,
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
