import 'package:chat_getx/pages/auth/controller/auth_controller.dart';
import 'package:chat_getx/pages/auth/repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SignUpPage extends GetView<AuthController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();
    final fullName = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up now"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
                hintStyle: TextStyle(fontSize: 10),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: fullName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your full name',
                hintStyle: TextStyle(fontSize: 10),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: password,
              maxLines: 1,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
                hintStyle: TextStyle(fontSize: 10),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     controller.sourceChat = ChatModel(
            //       name: "Box chat",
            //       icon: "",
            //       isGroup: false,
            //       time: DateTime.now().toString(),
            //       currentMessage: "currentMessage",
            //       status: "",
            //       id: 1,
            //     );
            //     Get.to(ChatPage(
            //       chatModel: controller.sourceChat,
            //       sourceChat: controller.sourceChat,
            //       sender: email.text,
            //     ));
            //   },
            //   child: const Text('Go to chat'),
            // ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: (){
                AuthenticationRepository.instance.createUserWithEmailAndPassword(email.text, password.text, fullName.text);
              },
              child: const Text('Sign Up'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You already have an account?',
                  style: TextStyle(fontSize: 10),
                ),
                GestureDetector(
                  onTap: (){
                    Get.off(() => const LoginPage());
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
