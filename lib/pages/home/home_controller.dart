import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../models/user.dart';

class HomeController extends GetxController{
  static HomeController get instance => Get.find();
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }


  Stream<List<UserModel>> getStreamUser() {
    return _fireStore.collection('users').snapshots().map((snapshot) {
      List<UserModel> list = [];
      try {
        for (var doc in snapshot.docs) {
          list.add(UserModel.fromMap(doc.data()));
          print('add ${doc.data()} to list');
        }
        return list;
      } catch (e) {
        print('Error: $e');
        return [];
      }
    });
  }


  Future<UserModel?> getCurrentUser() async{
    User? firebaseUser = _auth.currentUser;

    if(firebaseUser != null){
      DocumentSnapshot<Map<String, dynamic>> userDoc = await _fireStore.collection('users').doc(firebaseUser.uid).get();

      if(userDoc.exists && userDoc.data() != null){
        return UserModel.fromMap(userDoc.data()!);
      }
    }

    return null;
  }

}