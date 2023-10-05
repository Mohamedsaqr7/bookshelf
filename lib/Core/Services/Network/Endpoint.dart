class Endpoint {
  static String baseurl = 'https://codingarabic.online/api/';
  //auth
  static String register = 'register';
  static String login = 'login';
  static const String logout = 'logout';
  static const String verify = 'verify-email';
  static const String forgetpass = 'forget-password';
  static const String resend = 'resend-verify-code';
  static const String sendForget = 'forget-password';
//home ends
  static String categories = 'categories';
  static const String slider = 'sliders';
  static String bestseller = 'products-bestseller';
  static String newarrival = 'products-new-arrivals';
//books
  static String products = 'products';
  static String search = 'products-search';
//fav
  static const String addfav = 'add-to-wishlist';
  static const String favou = 'wishlist';
  static const String removefav = 'remove-from-wishlist';
  //cart
  static const String addcart = 'add-to-cart';
  static const String cart = 'cart';
  static const String updatecart = 'update-cart';
  static const String removecart = 'remove-from-cart';
  static const String city = 'governorates';
  static const String placeorder = 'place-order';
  static const String orderhistory = 'order-history';
  //profile
  static const String profile = 'profile';
  static const String updateprofile = 'update-profile';
}
