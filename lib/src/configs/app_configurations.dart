class Config{

  static  int connectionTimeOut = 100000;
  static  int readTimeOut = 20000;
  static  String baseUrl () => "http://api.themoviedb.org/3";
  static String get discoverMovie => "${baseUrl()}/discover/movie$aPIKey";
  static String get aPIKey => "?api_key=f33521953035af3fc3162fe1ac22e60c";
  static  String baseImageUrl = "https://image.tmdb.org/t/p/w500";
}