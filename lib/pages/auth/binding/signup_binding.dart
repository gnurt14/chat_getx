import 'package:chat_getx/pages/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
        () => AuthController(),
    );
  }

}