import 'dart:io';
import 'dart:async';
import 'dart:typed_data';

void main() async {
  try {
    // Cria e inicia o servidor na porta 4567
    ServerSocket server = await ServerSocket.bind('localhost', 4567);
    print('Servidor iniciado e escutando em localhost:4567');

    // Aguarda conexões assincronamente
    await for (Socket socket in server) {
      handleConnection(socket);
    }
  } catch (e) {
    print('Erro ao iniciar o servidor: $e');
  }
}

// Função para lidar com cada conexão
void handleConnection(Socket socket) {
  print('Nova conexão de ${socket.remoteAddress}:${socket.remotePort}');

  // Escuta por dados na conexão de forma assíncrona
  socket.listen((Uint8List data) {
    String message = String.fromCharCodes(data).trim(); // Converte bytes para string e remove espaços extras
    if (message.isNotEmpty) {
      print('Temperatura recebida: $message graus');
    }
  });

  // Opcional: Lida com o fechamento da conexão
  socket.done.then((_) {
    print('Conexão fechada por ${socket.remoteAddress}:${socket.remotePort}');
    socket.close(); // Fecha o socket quando a conexão é finalizada
  });
}