class ApiEndpoints {
  ApiEndpoints._();

  // ====================== LOCALHOSTS ======================
  static const String home="192.168.1.11";
  static const String lr2="172.26.1.54";


  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://$lr2:8080/api/v1/";
  // For iPhone
  //static const String baseUrl = "http://localhost:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String register = "auth/register";
  static const String login = "auth/login";
  // static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  // static const String uploadImage = "auth/uploadImage";

    // ====================== Movie Routes ======================
  static const String getShowingMovies = "movie/status/showing";
  static const String getUpcomingMovies = "movie/status/upcoming";


  // ====================== <> Routes ======================

}
