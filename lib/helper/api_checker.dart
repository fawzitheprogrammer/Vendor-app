import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_mall_vendor/data/model/response/base/api_response.dart';
import 'package:wave_mall_vendor/main.dart';
import 'package:wave_mall_vendor/provider/auth_provider.dart';
import 'package:wave_mall_vendor/view/base/custom_snackbar.dart';
import 'package:wave_mall_vendor/view/screens/auth/auth_screen.dart';

class ApiChecker {
  static void checkApi(ApiResponse apiResponse) {
    if(apiResponse.error.toString() == 'Failed to load data - status code: 401') {
      Provider.of<AuthProvider>(Get.context!,listen: false).clearSharedData();
      Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthScreen()), (route) => false);
    }else {
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      if (kDebugMode) {
        print(errorMessage);
      }
      showCustomSnackBar(errorMessage, Get.context!);
    }
  }
}