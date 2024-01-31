import 'package:flutter/material.dart';
import 'package:wave_mall_vendor/localization/app_localization.dart';

String? getTranslated(String? key, BuildContext context) {
  return AppLocalization.of(context)!.translate(key);
}