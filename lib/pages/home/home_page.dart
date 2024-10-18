import 'package:chat_getx/models/user.dart';
import 'package:chat_getx/pages/auth/repository/authentication_repository.dart';
import 'package:chat_getx/pages/home/home_controller.dart';
import 'package:chat_getx/widgets/user_box.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../chat/chat_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? sender;
    controller.getCurrentUser().then((value) {
      sender = value;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${sender?.name}",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text('Log out'),
                leading: const Icon(Icons.logout),
                onTap: () {
                  AuthenticationRepository.instance.logOut();
                },
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<UserModel>>(
            future: controller.fetchUser(),
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final userList = snapshot.data ?? [];
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final user = userList[index];
                    if (user.uid == sender?.uid) {
                      return Container();
                    }
                    return GestureDetector(
                      onTap: () {

                        Get.to(
                          () => ChatPage(receiver: user, sender: sender,),
                        );
                      },
                      child: UserBox(
                          userName: user.name.toString(),
                          email: user.email.toString()),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: userList.length,
                );
              }
            }),
      ),
    );
  }
}
