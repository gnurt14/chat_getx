import 'package:chat_getx/pages/auth/signup_page.dart';
import 'package:chat_getx/pages/chat/chat_binding.dart';
import 'package:chat_getx/pages/chat/chat_page.dart';
import 'package:chat_getx/pages/home/home_binding.dart';
import 'package:chat_getx/pages/home/home_page.dart';
import 'package:get/get.dart';

import '../pages/auth/binding/login_binding.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/binding/signup_binding.dart';

part 'routes.dart';

class AppPages {
  static const INITAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
        name: _Paths.HOME,
        page: () => const HomePage(),
        binding: HomeBinding()),
  ];
}
