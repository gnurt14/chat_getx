import 'package:chat_getx/pages/auth/repository/authentication_repository.dart';
import 'package:chat_getx/pages/auth/signup_page.dart';
import 'package:chat_getx/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatApp Socket"),
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
            ElevatedButton(
              onPressed: () {
                AuthenticationRepository.instance.loginWithEmailAndPassword(email.text, password.text);
                if(context.mounted){
                  Get.offAll(() => const HomePage());
                }
              },
              child: const Text('Login'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You don\'t have an account?',
                  style: TextStyle(fontSize: 10),
                ),
                GestureDetector(
                  onTap: (){
                    Get.off(() => const SignUpPage());
                  },
                  child: const Text(
                    'Sign Up',
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
