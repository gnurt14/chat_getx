import 'package:get/get.dart';

import '../../../models/chat.dart';

class AuthController extends GetxController{
  late ChatModel sourceChat;
  List<ChatModel> chatModels = [];
  static AuthController get instance => Get.find();

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

  void registerUser(String email, String password){

  }
}