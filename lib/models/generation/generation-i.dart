import 'generation_colors.dart';

class GenerationI {
  RedBlue? redBlue;
  RedBlue? yellow;

  GenerationI({this.redBlue, this.yellow});

  GenerationI.fromJson(Map<String, dynamic> json) {
    redBlue = json['red-blue'] != null
        ? RedBlue.fromJson(json['red-blue'])
        : null;
    yellow =
    json['yellow'] != null ? RedBlue.fromJson(json['yellow']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.redBlue != null) {
      data['red-blue'] = this.redBlue!.toJson();
    }
    if (this.yellow != null) {
      data['yellow'] = this.yellow!.toJson();
    }
    return data;
  }
}


