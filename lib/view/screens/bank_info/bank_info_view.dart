
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_mall_vendor/localization/language_constrants.dart';
import 'package:wave_mall_vendor/provider/bank_info_provider.dart';
import 'package:wave_mall_vendor/provider/theme_provider.dart';
import 'package:wave_mall_vendor/utill/dimensions.dart';
import 'package:wave_mall_vendor/utill/styles.dart';
import 'package:wave_mall_vendor/view/base/custom_app_bar.dart';
import 'package:wave_mall_vendor/view/screens/bank_info/bank_editing_screen.dart';
import 'package:wave_mall_vendor/view/screens/bank_info/widget/bank_info_widget.dart';

class BankInfoView extends StatelessWidget {
  const BankInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:getTranslated('bank_info', context), isBackButtonExist: true,),
        body: Consumer<BankInfoProvider>(
          builder: (context, bankProvider, child) {
            String name = bankProvider.bankInfo!.holderName?? '';
            String bank = bankProvider.bankInfo!.bankName?? '';
            String branch = bankProvider.bankInfo!.branch?? '';
            String accountNo = bankProvider.bankInfo!.accountNo?? '';
            return Column(
              children: [
                GestureDetector(
                  onTap: ()=>Navigator.push(context,
                      MaterialPageRoute(builder: (_) => BankEditingScreen(sellerModel: bankProvider.bankInfo))),
                  child: Padding(
                    padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Text(getTranslated('edit_info', context)!, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge,
                          color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?
                          Theme.of(context).hintColor: Theme.of(context).primaryColor)),
                      Icon(Icons.edit, color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?
                      Theme.of(context).hintColor: Theme.of(context).primaryColor)
                    ],),
                  ),
                ),
                BankInfoWidget(name: name,bank: bank,branch: branch,accountNo: accountNo,),

              ],
            );
          }
        ));
  }
}


