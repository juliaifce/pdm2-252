import 'dart:io';
import 'dart:async';
import 'dart:math'; // Para gerar números aleatórios

void main() async {
  try {
    // Conecta ao servidor
    Socket socket = await Socket.connect('localhost', 4567);
    print('Dispositivo IoT conectado ao servidor em localhost:4567');

    // Timer para enviar leituras de temperatura a cada 10 segundos
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      // Simula a leitura de um sensor de temperatura (valor aleatório entre 20 e 30)
      double temperature = 20 + Random().nextDouble() * 10; // 20 a 30 graus
      String message = '${temperature.toStringAsFixed(2)}\n'; // Formata e adiciona newline para delimitar

      // Envia a mensagem pelo socket
      socket.write(message);
      print('Enviado: Temperatura = $temperature graus');
    });

    // O programa permanece em execução devido ao Timer; não é necessário um loop explícito
  } catch (e) {
    print('Erro ao conectar ao servidor: $e');
  }
}