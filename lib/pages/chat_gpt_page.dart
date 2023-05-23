import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'chat_gpt/chat_message.dart';
import 'chat_gpt/three_dots.dart';



class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  late OpenAI? chatGPT;
  bool _isImageSearch = false;

  bool _isTyping = false;

  @override
  void initState() {
    chatGPT = OpenAI.instance.build(
        token: "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",
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60000)));
    super.initState();
  }

  @override
  void dispose() {
    
   
    super.dispose();
  }

  // Link for api - https://beta.openai.com/account/api-keys

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    ChatMessage message = ChatMessage(
      text: _controller.text,
      sender: "Me",
      isImage: false,
    );

    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    _controller.clear();

    if (_isImageSearch) {
      final request = GenerateImage(message.text, 1, size: ImageSize.size256);

      final response = await chatGPT!.generateImage(request);
      Vx.log(response!.data!.last!.url!);
      insertNewData(response.data!.last!.url!, isImage: true);
    } else {
      

       final request = CompleteText(prompt: message.text, model: Model.textDavinci3);

      final response = await chatGPT!.onCompletion(request: request);
      Vx.log(response!.choices[0].text);
      insertNewData(response.choices[0].text, isImage: false);
    }
  }

  void insertNewData(String response, {bool isImage = false}) {
    ChatMessage botMessage = ChatMessage(
      text: response,
      sender: "Bot",
      isImage: isImage,
    );

    setState(() {
      _isTyping = false;
      _messages.insert(0, botMessage);
    });
  }

  Widget _buildTextComposer() {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
       
        children: [
          Container(
            width: width * 0.75,
            height: 43,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17), color: Colors.white),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              controller: _controller,
              onSubmitted: (value) => _sendMessage(),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                      border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.pink,
                  
                  hintText: "Question",
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            ),
          ),
          SizedBox(width: width * 0.01),
          ButtonBar(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(255, 255, 0, 85),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _isImageSearch = false;
                    _sendMessage();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.87, top: 6),
                child: Row(
                  children: [
                    IconButton(
                      color: Colors.black,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Who am I ?'),
                            content: const Text(
                                'I am a ChatGPT based bot. I can answer any of your questions.'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Ok'))
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.help_outline_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                  child: ListView.builder(
                reverse: true,
                padding: Vx.m8,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              )),
              if (_isTyping) const ThreeDots(),
              const Divider(
                height: 1.0,
              ),
              _buildTextComposer()
            ],
          ),
        ));
  }
}