import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

///<------------------------- Socket Class ---------------->
class SocketApi {
  // late IO.Socket socket;
  // Factory constructor to return the same static instance every time you create an object.
  factory SocketApi() {
    return _socketApi;
  }

  // An internal private constructor to access it only once for the static instance of the class.
  SocketApi._internal();

  ///<------------------------- Socket Client ---------------->

  static IO.Socket socket = IO.io(
    ApiUrlContainer.socketUrl,
    IO.OptionBuilder().setTransports(['websocket'])
        //   .disableAutoConnect()
        //    .enableForceNewConnection()
        //    .setTimeout(5000)
        //    .setReconnectionDelay(10000)
        //    .enableReconnection()
        // .setQuery(<dynamic, dynamic>{'token': Environment.token})
        .build(),
  );

  ///<------------------------- Socket Initialization ---------------->
  static void init() {
    debugPrint(
        '=============> Socket initialization, connected: ${socket.connected}');
    if (!socket.connected) {
      // socket.connect();
      socket.onConnect((_) {
        debugPrint('===============> Socket Connected');
      });

      //<----------------------Listen for new message--------------->

      socket.on('unauthorized', (dynamic data) {
        print('Unauthorized');
      });
      socket.onError((dynamic error) {
        print('Socket error: $error');
      });
      socket.onDisconnect((dynamic data) {
        print('Socket instance disconnected');
      });
    } else {
      debugPrint('Socket instance already connected');
    }
  }

  static final SocketApi _socketApi = SocketApi._internal();

  ///<------------------------- Send Message and Response ---------------->

  static Future<dynamic> emitWithAck(String event, dynamic body) async {
    Completer<dynamic> completer = Completer<dynamic>();

    socket.emitWithAck(event, body, ack: (data) {
      if (data != null) {
        debugPrint('===========> Emit With Ack $data');
        completer.complete(data);
      } else {
        debugPrint('===========> Null');
        completer.complete(1); // You can specify the default value when null
      }
    });
    return completer.future;
  }

  ///<------------------------- Send Message ---------------->

  static sendMessage(String event, dynamic body) {
    if (body != null) {
      socket.emit(event, body);
      debugPrint('===========> Emit');
    }
  }

  //<----------------------Listen for new message--------------->

  // static Future<dynamic> newMsg({required String chatId, required}) async {
  //   socket.on("new-message::$chatId", (dynamic data) {
  //     debugPrint("=============New message=========$data");

  //     return data;
  //   });
  // }
}
