import 'package:flutter/material.dart';
import 'package:wave_mall_vendor/localization/language_constrants.dart';
import 'package:wave_mall_vendor/utill/dimensions.dart';
import 'package:wave_mall_vendor/utill/images.dart';
import 'package:wave_mall_vendor/view/base/custom_button.dart';



class ConfirmPurchaseDialog extends StatelessWidget {
  final Function? onYesPressed;
  const ConfirmPurchaseDialog({Key? key, required this.onYesPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(surfaceTintColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
        child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
        height: 240,
          child: Column(children: [
            SizedBox(width: 70,height: 70,
            child: Image.asset(Images.confirmPurchase),),
            Text(getTranslated('confirm_purchase', context)!),
            Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: SizedBox(height: 40,
                child: Row(children: [
                  Expanded(child: CustomButton(btnTxt: getTranslated('cancel', context),
                      backgroundColor: Theme.of(context).hintColor,
                      onTap: ()=>Navigator.pop(context))), const SizedBox(width: Dimensions.paddingSizeDefault),
                  Expanded(child: CustomButton(btnTxt: getTranslated('yes', context),
                    onTap: (){
                    onYesPressed!();
                    Navigator.pop(context);
                    },)),
                ],),
              ),
            )
          ],),
        ));
  }
}
