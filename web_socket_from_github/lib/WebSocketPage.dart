import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketPage extends StatefulWidget {
  @override
  _WebSocketPageState createState() => _WebSocketPageState();
}

class _WebSocketPageState extends State<WebSocketPage> {
  var _channel = IOWebSocketChannel.connect('Your Web Socket Url');
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _setupWebSocketListeners();
  }

  void _setupWebSocketListeners() {
    _channel.stream.listen((message) {
      // WebSocket mesajlarını burada işlenir...
      print('Received: $message');
    }, onDone: () {
      // Bağlantı kesildiğinde çalışacak kısım...
      setState(() {
        _isConnected = false;
      });

      // 10 saniye sonra tekrar bağlanmayı dener.
      Future.delayed(Duration(seconds: 10), () {
        _reconnectWebSocket();
        _reconnectWebSocket();
        _reconnectWebSocket();
      });
    }, onError: (error) {
      // Hata durumunda çalışacak kısım...
      setState(() {
        _isConnected = false;
      });
    });
  }

  void _reconnectWebSocket() {
    setState(() {
      _isConnected = true;
      _channel.sink.close();
      _channel.sink.add('Reconnecting...');
      _channel.sink.done.then((_) {
        _channel = IOWebSocketChannel.connect('ws://your_websocket_url');
        _setupWebSocketListeners();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket App'),
      ),
      body: Center(
        child: _isConnected
            ? Text('WebSocket Connected')
            : Text('WebSocket Disconnected'),
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
