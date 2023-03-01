class LCD1602Message {
  String message;

  LCD1602Message(this.message);

  Map toJson() {
    Map map = new Map();
    map["message"] = this.message;
    return map;
  }
}
