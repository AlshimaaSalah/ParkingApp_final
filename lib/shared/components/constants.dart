String uId = '';
String token = '';

// class ApiConstant {
// //https://accept.paymob.com/api/auth/tokens
//   static const String baseUrl = 'https://accept.paymob.com/api';
//   static const String getAuthToken = '/auth/tokens';
//   static const String paymentApiKey =
//       'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TnpJME5qVTVMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuRXo0VDdPU0VQd0xOM3RfTXdsUXJfZnRSUEdza1JPLU5rZU9wX3lpWl9IanFuRnRnVFJPNXJJZHREdE9vSi0td0thTk1DaW1KRW9NSnkxQWltSHRhRXc=';
//   static const String getOrderId = '/ecommerce/orders';
//   static const String getPaymentId = '/acceptance/payment_keys';//getPaymentRequest
//   static const String getRefCode = '/acceptance/payments/pay';
//   static String paymentFirstToken = '';
//   static String paymentOrderId = '';
//   static String finalToken = '';
//   static String refCode = '';
//   static String integrationIdKiosk = '3753396';
//   static String integrationIdCard = '3678966';
// }
class ApiContest {
  static const String baseUrl = 'https://accept.paymob.com/api';
  static const String paymentApiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TnpJME5qVTVMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuRXo0VDdPU0VQd0xOM3RfTXdsUXJfZnRSUEdza1JPLU5rZU9wX3lpWl9IanFuRnRnVFJPNXJJZHREdE9vSi0td0thTk1DaW1KRW9NSnkxQWltSHRhRXc=';
  static const String getAuthToken = '/auth/tokens';
  static const getOrderId = '/ecommerce/orders';
  static const getPaymentRequest = '/acceptance/payment_keys';
  static const getRefCode = '/acceptance/payments/pay';
  static String visaUrl =
      '$baseUrl/acceptance/iframes/744331?payment_token=$finalToken';
  static String paymentFirstToken = '';

  static String paymentOrderId = '';

  static String finalToken = '';

  static const String integrationIdCard = '3678966';
  static const String integrationIdKiosk = '3753396';

  static String refCode = '';
}

class AppImages {
  static const String refCodeImage =
      "https://cdn-icons-png.flaticon.com/128/4090/4090458.png";
  static const String visaImage =
      "https://cdn-icons-png.flaticon.com/128/349/349221.png";
}
