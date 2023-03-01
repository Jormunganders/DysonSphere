import 'Resource.dart';

class Machine {
  String? mName; // 机器名称
}

class Producer extends Machine {}

class Consumer extends Machine {}

class Converter extends Machine {}

/// 公式
abstract class Formula<M extends Machine> {
  List<ResourceBundle>? mInputResources;
  List<ResourceBundle>? mOutputResources;
  int? time;
  M? mMachine;
}

/// 生产公式
class ProduceFormula extends Formula<Producer> {}

/// 消费公式
class ConsumeFormula extends Formula<Consumer> {}

/// 转化公式
class ConvertFormula extends Formula<Converter> {}
