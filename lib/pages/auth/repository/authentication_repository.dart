import 'package:chat_getx/entities/user_entity.dart';
import 'package:chat_getx/models/user.dart';
import 'package:chat_getx/pages/auth/login_page.dart';
import 'package:chat_getx/pages/home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../home/home_controller.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?> (_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.lazyPut<HomeController>(() => HomeController());
      Get.offAll(() => const HomePage());
    }
  }

  Future<String?> createUserWithEmailAndPassword(String email, String password, String fullName) async {
    try {
      var data = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      await _fireStore.collection('users').doc(data.user?.uid).set({
        'name': fullName,
        'email': data.user?.email,
        'uid': _auth.currentUser?.uid,
      });

      return null;
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'Password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      } else {
        message = 'An unexpected error occurred: ${e.message}';
      }
      return message;
    } catch (e) {
      return 'An unknown error occurred: ${e.toString()}';
    }
  }


  Future<String?> loginWithEmailAndPassword(String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Get.offAll(() => const HomePage());
    } on FirebaseAuthException catch (e){
      String message = '';
      if(e.code == 'invalid-email'){
        message = 'Not user found for this email.';
      }else if(e.code == 'invalid-credential'){
        message = 'Wrong password.';
      }
      return message;
    } catch (_) { }
    return null;
  }

  Future<void> logOut() => _auth.signOut();

  Future<UserEntity?> getUser() async{
    try{
      var user = await _fireStore.collection('users').doc(_auth.currentUser?.uid).get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      UserEntity userEntity = userModel.toEntity();
      return userEntity;
    } catch (e){

    }
    return null;
  }
}