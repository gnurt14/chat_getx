import 'package:chat_getx/models/chat.dart';
import 'package:chat_getx/pages/chat/chat_page.dart';
import 'package:chat_getx/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
          ),
          ElevatedButton(
            onPressed: () {
              controller.sourceChat = ChatModel(
                name: "Box chat",
                icon: "",
                isGroup: false,
                time: DateTime.now().toString(),
                currentMessage: "currentMessage",
                status: "",
                id: 1,
              );
              Get.to(ChatPage(
                chatModel: controller.sourceChat,
                sourceChat: controller.sourceChat,
                sender: textEditingController.text,
              ));
            },
            child: const Text('Go to chat'),
          ),
        ],
      ),
    );
  }
}
