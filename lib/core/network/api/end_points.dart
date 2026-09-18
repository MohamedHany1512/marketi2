class EndPoint {
  static const String baseUrl = "https://supermarket-dan1.onrender.com/api/v1";

  static const String signIn = "/auth/signIn";

  static const String signUp = "/auth/signUp";
  static const String homeProducts = "/home/products";
  static String getUserDataEndPoint(dynamic id) {
    return "/.user/get-user/$id";
  }

  static String getCategoryProducts(String categoryName) =>
      '/home/products/category/$categoryName';

  static String getBrandProducts(String brandName) =>
      '/home/products/brand/$brandName';

  // Cart
  static const String getCart = '/user/getCart';
  static const String addToCart = '/user/addToCart';
  static String removeFromCart(String productId) =>
      '/user/deleteFromCart/$productId';

  // Wishlist
  static const String getFavorite = '/user/getFavorite';
  static const String addFavorite = '/user/addFavorite';
  static const String deleteFavorite = '/user/deleteFavorite';

  static const String productsFilter = '/home/productsFilter';
  static const String profile = '/portfolio/userData';
  static const String paymobBaseUrl = 'https://accept.paymob.com/api';
  static const String paymobAuthToken = '$paymobBaseUrl/auth/tokens';
  static const String paymobOrderRegistration = '$paymobBaseUrl/ecommerce/orders';
  static const String paymobPaymentKey = '$paymobBaseUrl/acceptance/payment_keys';
  static const String paymobIframeUrl = 'https://accept.paymob.com/api/acceptance/iframes';
}

class ApiKey {
  static const String status = "status";
  static const String errorMessage = "ErrorMessage";

  static const String email = "email";
  static const String password = "password";

  static const String token = "token";
  static const String message = "message";

  static const String id = "id";
  static const String name = "name";
  static const String phone = "phone";

  static const String confirmPassword = "confirmPassword";

  static const String location = "location";
  static const String profilePic = "profilePic";

  static const String user = "user";
  static const String role = "role";
  static const String image = "image";
  // Wishlist
  static const String favorite = '/favorite';
  static const String getFavorite = '/user/getFavorite';
  static const String addFavorite = '/user/addFavorite';
  static const String deleteFavorite = '/user/deleteFavorite';
}
