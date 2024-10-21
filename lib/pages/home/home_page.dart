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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      drawer: FutureBuilder<UserModel?>(
        future: controller.getCurrentUser(),
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
            final sender = snapshot.data;
            return Drawer(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                sender?.name ?? 'No name',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                sender?.email ?? 'No email',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
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
            );
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<List<UserModel>>(
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
              return FutureBuilder<UserModel?>(
                future: controller.getCurrentUser(),
                builder: (context, senderSnapshot) {
                  if (senderSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final sender = senderSnapshot.data;
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final user = userList[index];
                        if (user.uid == sender?.uid) {
                          return Container(); // Không hiển thị người dùng hiện tại
                        }
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                                  () => ChatPage(receiver: user, sender: sender),
                            );
                          },
                          child: UserBox(
                            userName: user.name.toString(),
                            email: user.email.toString(),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                      itemCount: userList.length,
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
