part of 'pages.dart';

abstract class Routes{
  static const LOGIN = _Paths.LOGIN;
  static const CHAT = _Paths.CHAT;
  static const SIGNUP = _Paths.SIGNUP;
}

abstract class _Paths{
  static const LOGIN = '/login';
  static const CHAT = '/chat';
  static const SIGNUP = '/signup';
}