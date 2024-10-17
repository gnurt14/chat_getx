import 'package:chat_getx/pages/auth/repository/authentication_repository.dart';
import 'package:chat_getx/routes/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
      (value) => Get.put(AuthenticationRepository())
  );
  runApp(
    GetMaterialApp(
      title: "App",
      initialRoute: AppPages.INITAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
