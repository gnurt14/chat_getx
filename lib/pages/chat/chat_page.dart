import 'package:chat_getx/models/chat.dart';
import 'package:chat_getx/pages/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';


class ChatPage extends GetView<ChatController> {
  ChatPage({super.key, this.chatModel, this.sourceChat, required this.sender});

  final ChatModel? chatModel;
  final ChatModel? sourceChat;
  final String sender;

  ChatController chatController = Get.put(ChatController());
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(sourceChat!.id);
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
          title: Text(chatModel!.name, style: const TextStyle(fontSize: 14),),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: Obx(
                      () =>
                      ListView.separated(
                        shrinkWrap: true,
                        controller: controller.scrollController,
                        itemCount: controller.message.length,
                        itemBuilder: (context, index) {
                          return (controller.message[index].sender == sender) ?
                          ChatBubble(
                            clipper: ChatBubbleClipper1(
                              type: BubbleType.receiverBubble,
                            ),
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                            backGroundColor: Colors.yellow[100],
                            child: Container(
                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${controller.message[index].sender}(you)", style: const TextStyle(fontSize: 10, color: Colors.grey),),
                                  Text(controller.message[index].message),
                                  Text(controller.message[index].time, style: const TextStyle(fontSize: 10, color: Colors.grey),),
                                ],
                              ),
                            ),
                          ) : ChatBubble(
                            clipper: ChatBubbleClipper1(
                                type: BubbleType.sendBubble),
                            alignment: Alignment.topRight,
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                            backGroundColor: Colors.grey[100],
                            child: Container(
                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.message[index].sender, style: const TextStyle(fontSize: 10, color: Colors.grey),),
                                  Text(controller.message[index].message),
                                  Text(controller.message[index].time, style: const TextStyle(fontSize: 10, color: Colors.grey),),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context,
                            int index) => const SizedBox(height: 5,),
                      ),
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
                          style: const TextStyle(fontSize: 10),
                          maxLines: null,
                          controller: messageController,
                          decoration: const InputDecoration(
                              hintText: 'Type a message...',
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(fontSize: 10)
                          ),
                          onSubmitted: (value) {
                            controller.setMessage(
                                'source', messageController.text, sender);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            if (messageController.text
                                .trim()
                                .isNotEmpty) {
                              controller.setMessage(
                                  'source', messageController.text, sender);
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
    );
  }
}
