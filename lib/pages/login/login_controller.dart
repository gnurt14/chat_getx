import 'package:get/get.dart';

import '../../models/chat.dart';

class LoginController extends GetxController{
  late ChatModel sourceChat;
  List<ChatModel> chatModels = [];

  @override
  void onInit() {
    super.onInit();
    print('init chatController');
    addUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addUser() {
    chatModels.add(
      ChatModel(
        name: "Gnurt",
        icon: 'icon',
        isGroup: false,
        time: '10:10',
        currentMessage: "Hi everyone",
        status: "online",
        id: 1,
      ),
    );
    chatModels.add(
      ChatModel(
        name: "Not Gnurt",
        icon: 'icon',
        isGroup: false,
        time: '10:10',
        currentMessage: "Hi everyone",
        status: "online",
        id: 2,
      ),
    );

    update();
  }
}