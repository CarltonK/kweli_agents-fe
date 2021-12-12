import '../models/models.dart';

class KioskModel {
  String? kioskName;
  String? kioskOwnerName;
  String? kioskOwnerMobile;
  String? kioskOwnerGender;
  List<dynamic>? kioskGoods;
  List<dynamic>? kioskWholesellerPaymentOptions;
  bool? doesAcceptMpesa;
  bool? isOwned;
  String? howLongInBusiness;
  String? howLongInLocation;
  bool? isInterestedInProduct;
  String? favWholeseller;
  List<dynamic>? howDoCustomersPayYou;
  String? mpesaTillNumber;
  String? mpesaPaybillNumber;
  String? mpesaPaybillAccountNumber;
  String? equityTillNumber;
  String? kcbTillNumber;
  bool? isOwnerRunningKiosk;
  String? personRunningKioskName;
  String? personRunningKioskMobile;
  bool? doesSellOnCredit;
  String? howLongTillPeoplePayYouBack;
  bool? hasOtherOutlets;
  String? otherOutletLocation;
  List<dynamic>? otherServices;
  bool? isMpesaAgent;
  List<dynamic>? mpesaAgentNumbers;
  bool? needsCreditForFloat;
  bool? wouldUseProductToRecord;
  bool? wouldLikePurchasesDelivered;
  bool? doesKeepComputerizedRecords;
  String? systemInUse;
  String? improvementsToCurrentSystemNeeded;
  String? generalFeedback;
  Location? location;

  KioskModel({
    this.kioskName,
    this.kioskOwnerName,
    this.kioskOwnerMobile,
    this.kioskOwnerGender,
    this.kioskGoods,
    this.kioskWholesellerPaymentOptions,
    this.doesAcceptMpesa,
    this.isOwned,
    this.howLongInBusiness,
    this.howLongInLocation,
    this.isInterestedInProduct,
    this.favWholeseller,
    this.howDoCustomersPayYou,
    this.mpesaTillNumber,
    this.mpesaPaybillNumber,
    this.mpesaPaybillAccountNumber,
    this.equityTillNumber,
    this.kcbTillNumber,
    this.isOwnerRunningKiosk,
    this.personRunningKioskName,
    this.personRunningKioskMobile,
    this.doesSellOnCredit,
    this.howLongTillPeoplePayYouBack,
    this.hasOtherOutlets,
    this.otherOutletLocation,
    this.otherServices,
    this.isMpesaAgent,
    this.mpesaAgentNumbers,
    this.needsCreditForFloat,
    this.wouldUseProductToRecord,
    this.wouldLikePurchasesDelivered,
    this.doesKeepComputerizedRecords,
    this.systemInUse,
    this.improvementsToCurrentSystemNeeded,
    this.generalFeedback,
    this.location,
  });

  Map<String, dynamic> toMap() => {
        'kioskName': kioskName,
        'kioskOwnerName': kioskOwnerName,
        'kioskOwnerMobile': kioskOwnerMobile,
        'kioskOwnerGender': kioskOwnerGender,
        'kioskGoods': kioskGoods,
        'kioskWholesellerPaymentOptions': kioskWholesellerPaymentOptions,
        'doesAcceptMpesa': doesAcceptMpesa,
        'isOwned': isOwned,
        'howLongInBusiness': howLongInBusiness,
        'howLongInLocation': howLongInLocation,
        'isInterestedInProduct': isInterestedInProduct,
        'favWholeseller': favWholeseller,
        'howDoCustomersPayYou': howDoCustomersPayYou,
        'mpesaTillNumber': mpesaTillNumber,
        'mpesaPaybillNumber': mpesaPaybillNumber,
        'mpesaPaybillAccountNumber': mpesaPaybillAccountNumber,
        'equityTillNumber': equityTillNumber,
        'kcbTillNumber': kcbTillNumber,
        'isOwnerRunningKiosk': isOwnerRunningKiosk,
        'personRunningKioskName': personRunningKioskName,
        'personRunningKioskMobile': personRunningKioskMobile,
        'doesSellOnCredit': doesSellOnCredit,
        'howLongTillPeoplePayYouBack': howLongTillPeoplePayYouBack,
        'hasOtherOutlets': hasOtherOutlets,
        'otherOutletLocation': otherOutletLocation,
        'otherServices': otherServices,
        'isMpesaAgent': isMpesaAgent,
        'mpesaAgentNumbers': mpesaAgentNumbers,
        'needsCreditForFloat': needsCreditForFloat,
        'wouldUseProductToRecord': wouldUseProductToRecord,
        'wouldLikePurchasesDelivered': wouldLikePurchasesDelivered,
        'doesKeepComputerizedRecords': doesKeepComputerizedRecords,
        'systemInUse': systemInUse,
        'improvementsToCurrentSystemNeeded': improvementsToCurrentSystemNeeded,
        'generalFeedback': generalFeedback,
        'location': location != null ? location!.toMap() : null,
      };
}
