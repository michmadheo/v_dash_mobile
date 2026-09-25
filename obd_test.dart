import 'dart:async';
import 'dart:io';

// Before running this test install ELM327 emulator with python by running "python3 -m pip install ELM327-emulator"
// Then run on terminal with python3 by running "-m elm -s car -n 35000"
// More info: https://github.com/ircama/ELM327-emulator

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