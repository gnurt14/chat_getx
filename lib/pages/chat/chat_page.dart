import 'package:chat_getx/models/chat.dart';
import 'package:chat_getx/models/user.dart';
import 'package:chat_getx/pages/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';

class ChatPage extends GetView<ChatController> {
  final ChatModel? receiver;
  final UserModel? sender;

  ChatPage({super.key,  this.receiver,  this.sender});

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
              const SizedBox(width: 10),
              const CircleAvatar(radius: 16),
            ],
          ),
          title: Text(
            receiver!.name.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[100],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Expanded( // Wrap the ListView in Expanded
                  child: StreamBuilder(
                    stream: controller.getChatStream(receiver!.receiverUid.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError || !snapshot.hasData) {
                        return const Center(
                          child: Text("An error occurred, please try again"),
                        );
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            var message = snapshot.data![index];
                            bool isSender = message.senderId == sender?.uid;
                            if(isSender) {
                              return ChatBubble(
                                clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top:10),
                                backGroundColor: Colors.blue,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(message.message),
                                      Text(message.timeSent.toString().substring(10,16), style: const TextStyle(fontSize: 10),),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return ChatBubble(
                              clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                              alignment: Alignment.topRight,
                              margin: const EdgeInsets.only(top:10),
                              backGroundColor: Colors.white,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(message.message),
                                    Text(message.timeSent.toString().substring(10,16), style: const TextStyle(fontSize: 10),),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.length,
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                            style: const TextStyle(fontSize: 14),
                            maxLines: null,
                            controller: messageController,
                            focusNode: controller.focusNode,
                            decoration: const InputDecoration(
                                hintText: 'Type a message...',
                                border: OutlineInputBorder(),
                                hintStyle: TextStyle(fontSize: 10)),
                            onSubmitted: (value) {
                              if (messageController.text.trim().isNotEmpty) {
                                controller.sendMessage(
                                    message: messageController.text,
                                    receiverData: receiver!,
                                    senderData: sender!);
                              }
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              if (messageController.text.trim().isNotEmpty) {
                                controller.sendMessage(
                                    message: messageController.text,
                                    receiverData: receiver!,
                                    senderData: sender!);
                              }
                              messageController.clear();
                            },
                            icon: const Icon(
                              Icons.send,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
