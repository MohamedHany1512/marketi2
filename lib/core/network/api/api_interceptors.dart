import 'package:dio/dio.dart';
import 'package:marketi/core/helper/cache_helper.dart';

class ApiInterceptor extends Interceptor {
  CacheHelper cacheHelper = CacheHelper();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.path.contains('accept.paymob.com')) {
      options.headers['Authorization'] =
          'Bearer ${cacheHelper.getData(key: 'token')}';
    }
    super.onRequest(options, handler);
  }
}
