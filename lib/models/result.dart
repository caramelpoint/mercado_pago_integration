import '../utils/json_utils.dart';
import 'payment.dart';

class Result {
  Result({
    this.resultCode,
    this.payment,
    this.error,
  });

  final String resultCode;
  final Payment payment;
  final String error;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      resultCode: json['resultCode'] as String,
      payment: json['payment'] == null
          ? null
          : Payment.fromJson(JsonUtils.parseJson(json['payment'])),
      error: json['error'] == null ? null : json['error'] as String,
    );
  }

  Map<String, dynamic> toJson() => resultToJson(this);

  Map<String, dynamic> resultToJson(Result instance) {
    final val = <String, dynamic>{
      'resultCode': instance.resultCode,
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    val['payment'] = instance.payment?.toJson();
    writeNotNull('error', instance.error);

    return val;
  }
}
