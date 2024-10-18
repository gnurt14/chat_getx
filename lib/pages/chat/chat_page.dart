import 'package:chat_getx/models/user.dart';
import 'package:chat_getx/pages/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ChatPage extends GetView<ChatController> {
  final UserModel? receiver;
  final UserModel? sender;
  ChatPage({super.key,this.receiver, this.sender});


  ChatController chatController = Get.put(ChatController());
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(36),
        child: AppBar(
          leadingWidth: 80,
          leading: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.chevron_left),
              ),
              const SizedBox(
                width: 10,
              ),
              const CircleAvatar(
                radius: 16,
              ),
            ],
          ),
          title: Text(receiver!.name.toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[100],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Expanded(child: Text('')),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                            style: const TextStyle(fontSize: 10),
                            maxLines: null,
                            controller: messageController,
                            decoration: const InputDecoration(
                                hintText: 'Type a message...',
                                border: OutlineInputBorder(),
                                hintStyle: TextStyle(fontSize: 10)
                            ),
                            onSubmitted: (value) {

                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              if(messageController.text.trim().isNotEmpty){
                                controller.sendMessage(message: messageController.text, receiverData: receiver!, senderData: sender!);
                              }
                            },
                            icon: const Icon(Icons.send, size: 16,),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
