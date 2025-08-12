class ApiServices {
  static const int isPaymentLive = 0;
  static const String googleMapApiKey = 'AIzaSyBqG8oCDY59Pwe68Y0AUiUeis-jWlsmtN8';
  static const String googleMapApiKey2 = 'AIzaSyCILYd8F2M7g95NQErBTZsXLmTD7baDBIw';
  static const String appStoreUrl = '';//'https://apps.apple.com/in/app/mediq-healthcare/id6738270406';
  static const double imageLimitInMB = 5;


///Live
//   static const String baseURL = 'http://bhagyalaxmidairy.beespotbrands.com/api/v1/Authenticate/';
//   static const String imageURL = 'http://bhagyalaxmidairy.beespotbrands.com/images/';


///staging url
  static const String baseURL = 'http://192.168.1.53:8000/api/v1/Authenticate/';
  static const String imageURL = 'http://192.168.1.53:8000/images/';



  static const String login = '${baseURL}login';
  static const String homeApi = '${baseURL}get-home';
  static const String addMilkType = '${baseURL}add-milk-type';
  static const String addSchedule = '${baseURL}add-schedule';
  static const String getMilkType = '${baseURL}get-milk-type';
  static const String deleteMilkType = '${baseURL}delete-milk-type';
  static const String loginUser = '${baseURL}login-user';
  static const String addUser = '${baseURL}add-user';
  static const String getUser = '${baseURL}get-user';
  static const String deleteUser = '${baseURL}delete-user';
  static const String updateUserStatus = '${baseURL}update-user-status';
  static const String addRoute = '${baseURL}add-route';
  static const String getRoute = '${baseURL}get-route';
  static const String deleteRoute = '${baseURL}delete-route';
  static const String addVendorPurchase = '${baseURL}add-vendor-purchase';
  static const String getVendorPurchase = '${baseURL}get-vendor-purchase';
  static const String getSchedule = '${baseURL}get-schedule';
  static const String deliverMilk = '${baseURL}deliver-milk';
  static const String assignUser = '${baseURL}assign-user';
  static const String addCashTransaction = '${baseURL}add-cash-transaction';
  static const String getCashTransaction = '${baseURL}get-cash-transaction';
  static const String deleteCashTransaction = '${baseURL}delete-cash-transaction';
  static const String ledgerExport = '${baseURL}ledger-export';
  static const String deliverExtraMilk = '${baseURL}deliver-extra-milk';

}
