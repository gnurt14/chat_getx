import 'package:chat_getx/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  final show = false.obs;
  FocusNode focusNode = FocusNode();
  final sendButton = false.obs;

  RxList<MessageModel> message = RxList<MessageModel>();
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  late IO.Socket socket;

  @override
  void onInit() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        show.value = false;
        update();
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void connect(int sourceChatId) {
    socket = IO.io("http://localhost:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connected;
    socket.emit("signin", sourceChatId);
    socket.onConnect((data) {
      print("connected");
      socket.on('message', (msg) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInSine,
        );
      });
    });
    update();
    print(" isconnect " + socket.connected.toString());
  }

  void setMessage(String type, msg, String sender) {
    MessageModel messageModel = MessageModel(
      type: type,
      message: msg,
      time: DateTime.now().toString().substring(10, 16),
      sender: sender,
    );
    message.add(messageModel);

    update();
  }

  void sendMessage(String message, int sourceId, int targetId, String sender) {
    setMessage('source', message, sender);
    socket.emit('message', {
      'message': message,
      'sourceId': sourceId,
      'targetId': targetId,
    });
    update();
  }
}
