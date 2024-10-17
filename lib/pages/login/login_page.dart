import 'package:chat_getx/pages/home/home_page.dart';
import 'package:chat_getx/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: ListView.builder(
        itemCount: controller.chatModels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            controller.sourceChat = controller.chatModels.removeAt(index);
            Get.to(HomePage(chatModels: controller.chatModels, sourceChat: controller.sourceChat));
          },
          child: ListTile(
            leading: const CircleAvatar(
              radius: 23,
              backgroundColor: Color(0xFF25D366),
              child: Icon(
                Icons.person,
                size: 26,
                color: Colors.white,
              ),
            ),
            title: Text(
              controller.chatModels[index].name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
