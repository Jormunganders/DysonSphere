import 'package:mqtt_client/mqtt_client.dart';

class MQTTFactory {
  final MqttClient _client = MqttClient.withPort(
      "", "DysonSphere", 1883);

  MQTTFactory._() {
    _client
      ..logging(on: true)
      ..onConnected = onConnected
      ..onDisconnected = onDisconnected
      ..onUnsubscribed = onUnsubscribed
      ..onSubscribed = onSubscribed
      ..onSubscribeFail = onSubscribeFail
      ..pongCallback = pong;
  }

  static MQTTFactory? _instance;

  static MQTTFactory getInstance() {
    if (_instance == null) {
      _instance = MQTTFactory._();
    }
    return _instance!;
  }

  Future<MqttClient> connect() async {
    final connMessage = MqttConnectMessage()
        .authenticateAs('', '')
        .keepAliveFor(60)
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    _client.connectionMessage = connMessage;
    try {
      await _client.connect();
    } catch (e) {
      print('Exception: $e');
      _client.disconnect();
    }

    _client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttMessage message = c[0].payload;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      print('Received message:$payload from topic: ${c[0].topic}>');
    });

    return _client;
  }

  // 连接成功
  void onConnected() {
    print('Connected');
  }

  // 连接断开
  void onDisconnected() {
    print('Disconnected');
  }

  // 订阅主题成功
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  // 订阅主题失败
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  // 成功取消订阅
  void onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
  }

  // 收到 PING 响应
  void pong() {
    print('Ping response client callback invoked');
  }
}
