import '../models/models.dart';

class WholesellerModel {
  String? shopName;
  String? ownerName;
  String? ownerMobile;
  Location? location;
  List<dynamic>? goodsSold;
  List<dynamic>? paymentOptions;
  String? mpesaTillNumber;
  String? mpesaPaybillNumber;
  String? mpesaPaybillAccountNumber;
  String? equityTillNumber;
  String? kcbTillNumber;
  String? otherPaymentInfo;
  bool? isHappyForProduct;
  bool? doesDeliver;
  String? minPurchaseAmountForDelivery;
  String? otherDeliveryInfo;

  WholesellerModel({
    this.shopName,
    this.ownerName,
    this.ownerMobile,
    this.location,
    this.goodsSold,
    this.paymentOptions,
    this.mpesaTillNumber,
    this.mpesaPaybillNumber,
    this.mpesaPaybillAccountNumber,
    this.equityTillNumber,
    this.kcbTillNumber,
    this.otherPaymentInfo,
    this.isHappyForProduct,
    this.doesDeliver,
    this.minPurchaseAmountForDelivery,
    this.otherDeliveryInfo,
  });

  Map<String, dynamic> toMap() => {
        'shopName': shopName,
        'ownerName': ownerName,
        'ownerMobile': ownerMobile,
        'location': location != null ? location!.toMap() : null,
        'goodsSold': goodsSold,
        'paymentOptions': paymentOptions,
        'mpesaTillNumber': mpesaTillNumber,
        'mpesaPaybillNumber': mpesaPaybillNumber,
        'mpesaPaybillAccountNumber': mpesaPaybillAccountNumber,
        'equityTillNumber': equityTillNumber,
        'kcbTillNumber': kcbTillNumber,
        'otherPaymentInfo': otherPaymentInfo,
        'isHappyForProduct': isHappyForProduct,
        'doesDeliver': doesDeliver,
        'minPurchaseAmountForDelivery': minPurchaseAmountForDelivery,
        'otherDeliveryInfo': otherDeliveryInfo,
      };
}
