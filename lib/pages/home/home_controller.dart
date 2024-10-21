import 'package:chat_getx/models/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../models/user.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser();
  }

  Stream<List<UserModel>> getDrawerUser() {
    return _fireStore.collection('users').snapshots().map((snapshot) {
      try {
        return snapshot.docs
            .map((doc) => UserModel.fromMap(doc.data()))
            .toList();
      } catch (e) {
        print('Error: $e');
        return [];
      }
    });
  }

  Stream<List<ChatModel>> getStreamUser() {
    return _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('chats')
        .snapshots()
        .map((event) {
      try {
        List<ChatModel> listChat = [];

        for (var doc in event.docs) {
          var chatModel = ChatModel.fromMap(doc.data());
          listChat.add(chatModel);
        }

        print('Fetched ${listChat.length} chat contacts');
        listChat.sort((a,b) => b.timeSent.compareTo(a.timeSent));
        return listChat;
      } catch (e) {
        print('Error fetching chats: $e');
        return [];
      }
    });
  }


  Future<void> fetchCurrentUser() async {
    try {
      User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _fireStore.collection('users').doc(firebaseUser.uid).get();

        if (userDoc.exists && userDoc.data() != null) {
          currentUser.value = UserModel.fromMap(userDoc.data()!);
        }
      }
    } catch (e) {
      print('Error fetching current user: $e');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    if (currentUser.value == null) {
      await fetchCurrentUser();
    }
    return currentUser.value;
  }
}
