import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/user.dart';

class HomeController extends GetxController{
  static HomeController get instance => Get.find();
  final _fireStore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
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
}