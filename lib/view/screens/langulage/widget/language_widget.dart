import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_mall_vendor/data/model/response/language_model.dart';
import 'package:wave_mall_vendor/provider/localization_provider.dart';
import 'package:wave_mall_vendor/provider/theme_provider.dart';
import 'package:wave_mall_vendor/utill/app_constants.dart';
import 'package:wave_mall_vendor/utill/dimensions.dart';
import 'package:wave_mall_vendor/utill/styles.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationProvider localizationController;
  final int index;
  const LanguageWidget({Key? key, required this.languageModel, required this.localizationController, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        boxShadow: [BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(0):
        Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!, blurRadius: 5, spreadRadius: 1)],
      ),
      child: GestureDetector(
        onTap: (){
          localizationController.setLanguage(Locale(
            AppConstants.languages[index].languageCode!,
            AppConstants.languages[index].countryCode,
          ), index);

        },

        child: Stack(children: [

          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(height: 65, width: 65,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                  border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!, width: 1)),
                alignment: Alignment.center,
                child: Image.asset(languageModel.imageUrl!, width: 36, height: 36)),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              Text(languageModel.languageName!, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
            ]),
          ),

          localizationController.languageIndex == index ?
          Positioned(top: 10, right: 10,
            child: Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 25),
          ) : const SizedBox(),

        ]),
      ),
    );
  }
}
