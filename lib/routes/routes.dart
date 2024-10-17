part of 'pages.dart';

abstract class Routes{
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const CHAT = _Paths.CHAT;
}

abstract class _Paths{
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const CHAT = '/chat';
}