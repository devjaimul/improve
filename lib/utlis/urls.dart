class Urls {
  // Base URL
  static const String _baseUrl = 'https://apparatus--mold-cia.trycloudflare.com';

  // Auth Endpoints
  static const String registration = '$_baseUrl/auth/register';
  static const String login = '$_baseUrl/auth/login';
  static const String forgetPass = '$_baseUrl/auth/forgot';
  static const String otpVerify = '$_baseUrl/otp/verify';
  static String otpResend(String userId) => '$_baseUrl/otp/resend?userId=$userId';
  static String updateUser(String userId) => '$_baseUrl/users/$userId';
  static String resetPass(String userId) => '$_baseUrl/users/$userId';

  // Home Endpoints
  static const String planImages = '$_baseUrl/plan-images';

  // Image Base URL
  static const String imageBaseUrl = '$_baseUrl';

  //notifications
  static const String notifications = '$_baseUrl/notifications';

  //profile
  static const String profileInfo = '$_baseUrl/users/me';
}
