import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_mall_vendor/data/model/response/top_delivery_man.dart';
import 'package:wave_mall_vendor/provider/delivery_man_provider.dart';
import 'package:wave_mall_vendor/utill/dimensions.dart';
import 'package:wave_mall_vendor/view/base/no_data_screen.dart';
import 'package:wave_mall_vendor/view/screens/delivery/widget/delivery_man_card.dart';
import 'package:wave_mall_vendor/view/screens/pos/widget/pos_product_shimmer.dart';



class DeliveryManListView extends StatelessWidget {
  const DeliveryManListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliveryManProvider>(
      builder: (context, prodProvider, child) {
        List<DeliveryMan>? listOfDeliveryMan = [];
        listOfDeliveryMan = prodProvider.listOfDeliveryMan;


        return Column(mainAxisSize: MainAxisSize.min, children: [
          listOfDeliveryMan != null?  listOfDeliveryMan.isNotEmpty ?
          Padding(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall),
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listOfDeliveryMan.length,
              itemBuilder: (context, index) {
                return DeliveryManCardWidget(deliveryMan: listOfDeliveryMan![index]);
              },
            ),
          ): Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/5),
            child: const NoDataScreen(),
          ) : const PosProductShimmer(),

          prodProvider.isLoading ? Center(child: Padding(
            padding: const EdgeInsets.all(Dimensions.iconSizeExtraSmall),
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
          )) : const SizedBox.shrink(),

        ]);
      },
    );
  }
}
