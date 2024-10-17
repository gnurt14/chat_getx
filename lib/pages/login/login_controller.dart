import 'package:get/get.dart';

import '../../models/chat.dart';

class LoginController extends GetxController{
  late ChatModel sourceChat;
  List<ChatModel> chatModels = [];

  @override
  void onInit() {
    super.onInit();
    print('init chatController');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}