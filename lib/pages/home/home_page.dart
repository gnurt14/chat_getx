import 'package:chat_getx/models/chat.dart';
import 'package:chat_getx/models/user.dart';
import 'package:chat_getx/pages/auth/repository/authentication_repository.dart';
import 'package:chat_getx/pages/home/home_controller.dart';
import 'package:chat_getx/widgets/chat_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../chat/chat_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      drawer: StreamBuilder<List<UserModel>>(
        stream: controller.getDrawerUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Drawer(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Drawer(
              child: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            var listUser = snapshot.data ?? [];
            final currentUser = controller.currentUser.value;
            return Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(radius: 30),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentUser!.name.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              currentUser.email.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listUser.length,
                      itemBuilder: (context, index) {
                        final user = listUser[index];
                        if(user.uid == currentUser.uid){
                          return Container();
                        }
                        return ListTile(
                          title: Text(user.name.toString()),
                          onTap: () => Get.to(() => ChatPage(
                                receiver: ChatModel(
                                  name: user.name.toString(),
                                  receiverUid: user.uid.toString(),
                                  timeSent: DateTime.now(),
                                  lastMessage: '',
                                ),
                                sender: controller.currentUser.value,
                              )),
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Log out'),
                    leading: const Icon(Icons.logout),
                    onTap: () {
                      AuthenticationRepository.instance.logOut();
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<List<ChatModel>>(
          stream: controller.getStreamUser(),
          builder: (context, snapshot) {
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
              if (userList.isEmpty) {
                return const Center(
                  child: Text('No chats found.'),
                );
              }
              return Obx(() {
                final sender = controller.currentUser.value;
                if (sender == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final user = userList[index];
                    if (user.receiverUid == sender.uid) {
                      return Container();
                    }
                    print(
                        '${user.name} - ${user.timeSent} - ${user.lastMessage} - ${user.receiverUid}');
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => ChatPage(receiver: user, sender: sender),
                        );
                      },
                      child: ChatBox(
                        userName: user.name,
                        lastMessage: user.lastMessage,
                        timeSent: user.timeSent.toString().substring(10, 16),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: userList.length,
                );
              });
            }
          },
        ),
      ),
    );
  }
}
