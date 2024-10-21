import 'package:chat_getx/models/chat.dart';
import 'package:chat_getx/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

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
    textController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Stream<List<MessageModel>> getChatStream(String receiverId) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .asyncMap((event) async {
          List<MessageModel> messageList = [];
          try{
            for(var document in event.docs){
              messageList.add(MessageModel.fromMap(document.data()));
            }
            return messageList;
          } catch (e){
            print('Error get chat stream $e');
            return [];
          }
    });
  }

  void sendMessage({
    required String message,
    required UserModel receiverData,
    required UserModel senderData,
  }) async {
    try {
      var timeSent = DateTime.now();

      var userDataMap =
          await _firestore.collection('users').doc(receiverData.uid).get();
      receiverData = UserModel.fromMap(userDataMap.data()!);

      _saveDataToContactSubCollection(
        senderData: senderData,
        receiverData: receiverData,
        message: message,
        timeSent: timeSent,
      );

      var messageId = const Uuid().v4();

      _saveMessageToSubMessageCollection(
        receiverId: receiverData.uid.toString(),
        message: message,
        timeSent: timeSent,
        messageId: messageId,
        userName: senderData.name.toString(),
        receiverUserName: receiverData.name.toString(),
      );
      print('send message');
      textController.clear();
      sendButton.value = false;
      update();
    } catch (e) {}
  }

  void _saveDataToContactSubCollection({
    required UserModel senderData,
    required UserModel receiverData,
    required String message,
    required DateTime timeSent,
  }) async {
    var receiverChatContact = ChatModel(
      name: senderData.name.toString(),
      receiverUid: senderData.uid.toString(),
      timeSent: timeSent,
      lastMessage: message,
    );

    await _firestore
        .collection('users')
        .doc(receiverData.uid)
        .collection('chats')
        .doc(_auth.currentUser!.uid)
        .set(receiverChatContact.toMap());

    var senderChatContact = ChatModel(
      name: receiverData.name.toString(),
      receiverUid: receiverData.uid.toString(),
      timeSent: timeSent,
      lastMessage: message,
    );

    await _firestore
        .collection('users')
        .doc(senderData.uid)
        .collection('chats')
        .doc(receiverData.uid)
        .set(senderChatContact.toMap());
  }

  void _saveMessageToSubMessageCollection({
    required String receiverId,
    required String message,
    required DateTime timeSent,
    required String messageId,
    required String userName,
    required String receiverUserName,
  }) async {
    final messageM = MessageModel(
      senderId: _auth.currentUser!.uid,
      receiverId: receiverId,
      message: message,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );

    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(messageId)
        .set(
          messageM.toMap(),
        );

    await _firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(_auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(
          messageM.toMap(),
        );
  }
}
