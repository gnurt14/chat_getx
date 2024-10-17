import 'package:chat_getx/models/chat.dart';
import 'package:chat_getx/pages/chat/chat_page.dart';
import 'package:chat_getx/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key, this.chatModels, this.sourceChat});

  final List<ChatModel>? chatModels;
  final ChatModel? sourceChat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatModels?.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Get.to(
              ChatPage(
                chatModel: chatModels?[index],
                sourceChat: sourceChat,
              ),
            );
          },
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 20,
                ),
                title: Text(
                  chatModels![index].name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  children: [
                    const Icon(Icons.done_all),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      chatModels![index].currentMessage,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  chatModels![index].time,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
