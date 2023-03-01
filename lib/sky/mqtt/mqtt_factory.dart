import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:typed_data/typed_buffers.dart';

typedef ReceiveMessageCallback = void Function(String topic, String message);

/// 对 mqtt5 的封装
class MQTTManager {
  late final MqttServerClient _client;

  static MQTTManager? _instance;

  late final String _clientId;

  bool _connected = false;

  Set<String> _subscribeTopics = Set();

  bool isConnected() => _connected;

  MQTTManager._(String server, int port, String clientId) {
    this._clientId = clientId;
    _client = MqttServerClient.withPort(server, clientId, port)
      ..onConnected = _onConnected
      ..onSubscribed = _onSubscribed
      ..onSubscribeFail = _onSubscribeFail
      ..onUnsubscribed = _onUnSubscribed
      ..pongCallback = _onPong
      ..logging(on: false)
      ..secure = true
      ..onBadCertificate = (dynamic a) => true;
  }

  static MQTTManager getInstance(String server, int port, String clientId) {
    if (_instance == null) {
      _instance = MQTTManager._(server, port, clientId);
    }
    return _instance!;
  }

  static MQTTManager? tryGetInstance() => _instance;

  _onConnected() {
    _log("onConnected");
    _connected = true;
  }

  _onSubscribed(MqttSubscription subscription) {
    _log("onSubscribed, topic:${subscription.topic}");
    var topic = subscription.topic.rawTopic;
    if (topic != null) {
      _subscribeTopics.add(topic);
    }
  }

  _onUnSubscribed(MqttSubscription subscription) {
    _log("onUnSubscribed,topic:${subscription.topic}");
    var topic = subscription.topic.rawTopic;
    if (topic != null) {
      _subscribeTopics.remove(topic);
    }
  }

  _onSubscribeFail(MqttSubscription subscription) {
    _log("onSubscribeFail,topic:${subscription.topic}");
  }

  void _onPong() {
    print('onPong');
  }

  void _log(String message) {
    // todo 判断是否为 debug 模式
    print("口======[]=====================>: $message");
  }

  /// 断开连接
  void disconnect() {
    _log("Disconnect manually");
    _subscribeTopics.forEach((element) {
      unsubscribeMessage(element);
    });
    _client.disconnect();
    _connected = false;
  }

  /// 发送信息
  /// message 只支持英文和数字
  int publishMessage(String topic, String message) {
    _log("publishMessage: topic: $topic, message: $message");
    Uint8Buffer buffer = Uint8Buffer();
    var codeUnit = message.codeUnits;
    buffer.addAll(codeUnit);
    return _client.publishMessage(topic, MqttQos.atLeastOnce, buffer);
  }

  Future<MqttConnectionStatus?> connect(String username, String password) {
    final connectMessage = MqttConnectMessage()
        .withClientIdentifier(_clientId)
        .keepAliveFor(90)
        .withWillTopic("will_topic")
        .withWillQos(MqttQos.atLeastOnce)
        .startClean();

    _client.connectionMessage = connectMessage;
    _log("Start connect!");
    return _client.connect(username, password);
  }

  /// 对某个 topic 进行订阅
  subscribeMessage(String topic, ReceiveMessageCallback? callback) {
    var subscription = _client.subscribe(topic, MqttQos.atLeastOnce);
    _client.updates.listen((event) {
      final MqttMessage message = event[0].payload;
      if (message is MqttPublishMessage) {
        final msg = MqttUtilities.bytesToStringAsString(
            message.payload.message ?? Uint8Buffer());
        final theTopic = event[0].topic;
        _log("Received message: [$msg],topic: [$theTopic]");
        if (callback != null) {
          callback(theTopic ?? topic, msg);
        }
      }
    });
  }

  /// 取消订阅
  void unsubscribeMessage(String topic) {
    _client.unsubscribeStringTopic(topic);
  }
}

void main() async {
  var manager = MQTTManager.getInstance(
      "k666eccb.ala.cn-hangzhou.emqxsl.cn", 8883, "Dyson");
  var status = await manager.connect("Breathe", "helloworld");
  if (status?.reasonCode == MqttConnectReasonCode.success) {
    // manager.publishMessage("hello", "helloworld123456");
    manager.subscribeMessage("world", (topic, message) => {});
  }
  // manager.disconnect();
}
