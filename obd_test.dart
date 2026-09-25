import 'dart:async';
import 'dart:io';

Future<void> main() async {
  final socket = await Socket.connect(
    '127.0.0.1',
    35000,
  );

  print('CONNECTED');

  socket.listen(
    (data) {
      final response = String.fromCharCodes(data).trim();

      print('📥 $response');
    },
    onDone: () {
      print('DISCONNECTED');
    },
  );

  // Request speed setiap 500ms
  Timer.periodic(
    const Duration(milliseconds: 500),
    (_) {
      socket.write('010D\r');
    },
  );
}