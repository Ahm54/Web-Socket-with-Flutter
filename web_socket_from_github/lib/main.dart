// import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
import 'WebSocketPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // const String _webSocketUrl = String.fromEnvironment('WSS_URL',
    //     defaultValue: 'wss://www.hopino.com:12346/Api');

    return MaterialApp(
      title: 'Flutter Websocket Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebSocketPage(
          
    ));
  }
}




