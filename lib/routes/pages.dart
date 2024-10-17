import 'package:chat_getx/pages/chat/chat_binding.dart';
import 'package:chat_getx/pages/chat/chat_page.dart';
import 'package:chat_getx/pages/home/home_page.dart';
import 'package:get/get.dart';

import '../pages/home/home_binding.dart';
import '../pages/login/login_binding.dart';
import '../pages/login/login_page.dart';

part 'routes.dart';

class AppPages {
  static const INITAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatPage(),
      binding: ChatBinding(),
    ),
  ];
}
