import 'package:chat_getx/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/user.dart';

class ChatController extends GetxController {
  final show = false.obs;
  FocusNode focusNode = FocusNode();
  final sendButton = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxList<MessageModel> message = RxList<MessageModel>();
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        show.value = false;
        update();
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setMessage(String type, msg, String sender) {


    update();
  }

  void sendMessage(String message, String receiverId, String senderId) async{
    String timeSent = DateTime.now().toString();

    UserModel receiverData;
    var userDataMap = await _firestore.collection('users').doc(receiverId).get();
    receiverData = UserModel.fromMap(userDataMap.data()!);
    update();
  }
}
