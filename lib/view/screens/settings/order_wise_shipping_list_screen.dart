import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_mall_vendor/localization/language_constrants.dart';
import 'package:wave_mall_vendor/provider/auth_provider.dart';
import 'package:wave_mall_vendor/provider/business_provider.dart';
import 'package:wave_mall_vendor/provider/localization_provider.dart';
import 'package:wave_mall_vendor/provider/shipping_provider.dart';
import 'package:wave_mall_vendor/utill/color_resources.dart';
import 'package:wave_mall_vendor/utill/dimensions.dart';
import 'package:wave_mall_vendor/utill/images.dart';
import 'package:wave_mall_vendor/utill/styles.dart';
import 'package:wave_mall_vendor/view/base/custom_app_bar.dart';
import 'package:wave_mall_vendor/view/base/custom_dialog.dart';
import 'package:wave_mall_vendor/view/base/no_data_screen.dart';
import 'package:wave_mall_vendor/view/screens/settings/order_wise_shipping_add_screen.dart';
import 'package:wave_mall_vendor/view/screens/settings/widget/order_wise_shipping_card.dart';
import 'package:wave_mall_vendor/view/screens/shipping/widget/drop_down_for_shipping_type.dart';
import 'package:wave_mall_vendor/view/screens/shop/widget/animated_floating_button.dart';

class OrderWiseShippingScreen extends StatefulWidget {
  const OrderWiseShippingScreen({Key? key}) : super(key: key);

  @override
  State<OrderWiseShippingScreen> createState() => OrderWiseShippingScreenState();
}

class OrderWiseShippingScreenState extends State<OrderWiseShippingScreen> {

  @override
  void initState() {
    Provider.of<ShippingProvider>(context, listen: false).iniType('order_wise');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<BusinessProvider>(context, listen: false).getBusinessList(context);
    Provider.of<ShippingProvider>(context, listen: false).getShippingList(Provider.of<AuthProvider>(context,listen: false).getUserToken());
    ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      appBar: CustomAppBar(title: getTranslated('business_settings', context), isBackButtonExist: true),
      body:
      Stack(
        children: [
          Column(
            children: [
              const DropDownForShippingTypeWidget(),
              Padding(
                padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault,Dimensions.paddingSizeExtraSmall),
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeMedium),
                  decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(.125),
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('#    ${getTranslated('details', context)}', style: robotoMedium,),
                    Text(getTranslated('action', context)!, style: robotoMedium,)
                  ],),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Consumer<ShippingProvider>(
                      builder: (context, shipProv, child) {
                        return  shipProv.shippingList !=null ? shipProv.shippingList!.isNotEmpty ?
                        Padding(
                          padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: 70),
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                              itemCount: shipProv.shippingList!.length,
                              itemBuilder: (context, index){
                                return OrderWiseShippingCard(shipProv: shipProv,shippingModel: shipProv.shippingList![index], index: index,);
                              }
                          ),
                        ) : const NoDataScreen()
                            : Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor));
                      }
                  ),
                ),
              ),

            ],
          ),

          Positioned(
            child: Align(
              alignment: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Alignment.bottomRight: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeMedium),
                child: ScrollingFabAnimated(
                  width: 150,
                  color: Theme.of(context).cardColor,
                  icon: SizedBox(width: Dimensions.iconSizeExtraLarge,child: Image.asset(Images.addIcon)),
                  text: Text(getTranslated('add_new', context)!, style: robotoRegular.copyWith(),),
                  onPress: () => showAnimatedDialog(context, const OrderWiseShippingAddScreen()),
                  animateIcon: true,
                  inverted: false,
                  scrollController: scrollController,
                  radius: 100.0,
                ),
              ),
            ),
          )
        ],
      ),


    );
  }
}
