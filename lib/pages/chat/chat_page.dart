import 'package:chat_getx/models/chat.dart';
import 'package:chat_getx/pages/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/reply_card.dart';

class ChatPage extends GetView<ChatController> {
  ChatPage({super.key, this.chatModel, this.sourceChat});

  final ChatModel? chatModel;
  final ChatModel? sourceChat;

  ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    print(sourceChat!.id);
    chatController.connect(sourceChat!.id);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(36),
        child: AppBar(
          leadingWidth: 120,
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
              const SizedBox(
                width: 5,
              ),
              Text(chatModel!.name),
            ],
          ),
          // actions: [
          //   Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       IconButton(
          //         onPressed: () {},
          //         icon: const Icon(
          //           Icons.phone,
          //           size: 16,
          //         ),
          //       ),
          //       IconButton(
          //         onPressed: () {},
          //         icon: const Icon(
          //           Icons.videocam_sharp,
          //           size: 16,
          //         ),
          //       ),
          //       PopupMenuButton<String>(
          //         padding: const EdgeInsets.all(0),
          //         onSelected: (value) {},
          //         itemBuilder: (BuildContext context) {
          //           return [
          //             const PopupMenuItem(
          //               value: "Option 1",
          //               child: Text("Option 1"),
          //             ),
          //             const PopupMenuItem(
          //               value: "Option 2",
          //               child: Text("Option 2"),
          //             ),
          //             const PopupMenuItem(
          //               value: "Option 3",
          //               child: Text("Option 3"),
          //             ),
          //             const PopupMenuItem(
          //               value: "Option 4",
          //               child: Text("Option 4"),
          //             ),
          //             const PopupMenuItem(
          //               value: "Option 5",
          //               child: Text("Option 5"),
          //             ),
          //           ];
          //         },
          //       )
          //     ],
          //   )
          // ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PopScope(
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    controller: controller.scrollController,
                    itemCount: controller.message.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.message.length) {
                        return Container(
                          height: 70,
                        );
                      }
                      if (controller.message[index].type == 'source') {
                        return ReplyCard(message: controller.message[index].message, time: controller.message[index].time,);
                      } else {
                        return ReplyCard(message: controller.message[index].message, time: controller.message[index].time,);
                      }
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
              )
            ],
          ),
        ),
      ),
    );
  }

}
