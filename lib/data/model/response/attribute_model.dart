import 'package:flutter/material.dart';
import 'package:wave_mall_vendor/data/model/response/attr.dart';

class AttributeModel {
  Attr attribute;
  bool active;
  TextEditingController controller;
  List<String?> variants;


  AttributeModel({required this.attribute, required this.active, required this.controller, required this.variants});
}