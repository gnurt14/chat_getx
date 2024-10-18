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


  Future<List<UserModel>> fetchUser() async {
    List<UserModel> list = [];
    await _fireStore.collection('users').get().then((event){
      for(var doc in event.docs){
        list.add(UserModel.fromMap(doc.data()));
        print('add ${doc.data()} to list');
      }
    });
    return list;
  }

  User? getCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    return user;
  }

}