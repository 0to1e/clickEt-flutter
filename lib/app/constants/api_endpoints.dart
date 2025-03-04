class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://192.168.1.11:8080/api/v1/";
  // For iPhone
  //static const String baseUrl = "http://localhost:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String uploadProfile = "auth/user/upload";
  // static const String uploadImage = "auth/uploadImage";

    // ====================== Movie Routes ======================
  static const String getShowingMovies = "movie/status/showing";
  static const String getUpcomingMovies = "movie/status/upcoming";


  // ====================== <> Routes ======================

}
