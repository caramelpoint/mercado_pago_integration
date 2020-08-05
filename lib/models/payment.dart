import '../utils/date_utils.dart';

class Payment {
  Payment({
    this.collectorId,
    this.couponAmount,
    this.currencyId,
    this.dateCreated,
    this.id,
    this.operationType,
    this.paymentMethodId,
    this.paymentTypeId,
    this.status,
    this.statusDetail,
    this.transactionAmount,
    this.transactionAmountRefunded,
    this.dateApproved,
  });

  final int id;
  final double collectorId;
  final double couponAmount;
  final double transactionAmount;
  final double transactionAmountRefunded;
  final String currencyId;
  final String operationType;
  final String paymentMethodId;
  final String paymentTypeId;
  final String statusDetail;
  final String status;
  final DateTime dateApproved;
  final DateTime dateCreated;

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: (json['id'] as num)?.toInt(),
      collectorId: json['collectorId'] == null
          ? null
          : (json['collectorId'] as num)?.toDouble(),
      couponAmount: json['couponAmount'] == null
          ? null
          : (json['couponAmount'] as num)?.toDouble(),
      transactionAmount: json['transactionAmount'] == null
          ? null
          : (json['transactionAmount'] as num)?.toDouble(),
      transactionAmountRefunded: json['transactionAmountRefunded'] == null
          ? null
          : (json['transactionAmountRefunded'] as num)?.toDouble(),
      currencyId:
          json['currencyId'] == null ? null : json['currencyId'] as String,
      operationType: json['operationType'] == null
          ? null
          : json['operationType'] as String,
      paymentMethodId: json['paymentMethodId'] == null
          ? null
          : json['paymentMethodId'] as String,
      paymentTypeId: json['paymentTypeId'] == null
          ? null
          : json['paymentTypeId'] as String,
      statusDetail:
          json['statusDetail'] == null ? null : json['statusDetail'] as String,
      status: json['status'] == null ? null : json['status'] as String,
      dateCreated: json['dateCreated'] == null
          ? null
          : DateUtils.parseDate(json['dateCreated'] as String),
      dateApproved: json['dateApproved'] == null
          ? null
          : DateUtils.parseDate(json['dateApproved'] as String),
    );
  }

  Map<String, dynamic> toJson() => paymentToJson(this);

  Map<String, dynamic> paymentToJson(Payment instance) {
    final val = <String, dynamic>{
      'id': instance.id,
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('collectorId', instance.collectorId);
    writeNotNull('couponAmount', instance.couponAmount);
    writeNotNull('transactionAmount', instance.transactionAmount);
    writeNotNull(
        'transactionAmountRefunded', instance.transactionAmountRefunded);
    writeNotNull('currencyId', instance.currencyId);
    writeNotNull('operationType', instance.operationType);
    writeNotNull('paymentMethodId', instance.paymentMethodId);
    writeNotNull('paymentTypeId', instance.paymentTypeId);
    writeNotNull('statusDetail', instance.statusDetail);
    writeNotNull('status', instance.status);
    writeNotNull('dateCreated', instance.dateCreated?.toIso8601String());
    writeNotNull('dateApproved', instance.dateApproved?.toIso8601String());

    return val;
  }
}
