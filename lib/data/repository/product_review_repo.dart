import 'package:wave_mall_vendor/data/datasource/remote/dio/dio_client.dart';
import 'package:wave_mall_vendor/data/datasource/remote/exception/api_error_handler.dart';
import 'package:wave_mall_vendor/data/model/response/base/api_response.dart';
import 'package:wave_mall_vendor/utill/app_constants.dart';

class ProductReviewRepo {
  final DioClient? dioClient;
  ProductReviewRepo({required this.dioClient});

  Future<ApiResponse> productReviewList() async {
    try {
      final response = await dioClient!.get(AppConstants.productReviewUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> filterProductReviewList(int? productId, int? customerId, int status, String? from, String? to) async {
    try {
      final response = await dioClient!.get('${AppConstants.productReviewUri}?product_id=$productId&customer_id=$customerId&status&from=$from&to=$to',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> searchProductReviewList(String search) async {
    try {
      final response = await dioClient!.get('${AppConstants.productReviewUri}?search=$search',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> reviewStatusOnOff(int? reviewId, int status) async {
    try {
      final response = await dioClient!.get('${AppConstants.productReviewStatusOnOff}?id=$reviewId&status=$status',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}