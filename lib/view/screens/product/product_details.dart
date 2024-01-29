import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_mall_vendor/data/model/response/product_model.dart';
import 'package:wave_mall_vendor/localization/language_constrants.dart';
import 'package:wave_mall_vendor/provider/auth_provider.dart';
import 'package:wave_mall_vendor/provider/product_provider.dart';
import 'package:wave_mall_vendor/provider/shop_provider.dart';
import 'package:wave_mall_vendor/utill/dimensions.dart';
import 'package:wave_mall_vendor/utill/styles.dart';
import 'package:wave_mall_vendor/view/base/custom_app_bar.dart';
import 'package:wave_mall_vendor/view/screens/product/product_details_review_screen.dart';
import 'package:wave_mall_vendor/view/screens/product/widget/product_details_widget.dart';



class ProductDetailsScreen extends StatefulWidget {
  final Product? productModel;
  const ProductDetailsScreen({Key? key, this.productModel}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  int selectedIndex = 0;

  void load(BuildContext context){
    Provider.of<ProductProvider>(context, listen: false).getProductWiseReviewList(context, 1, widget.productModel!.id);
    Provider.of<ProductProvider>(context, listen: false).getProductDetails(widget.productModel!.id);
    Provider.of<SellerProvider>(context,listen: false).getCategoryList(context,null, 'en');
  }
  @override
  void initState() {
    super.initState();
    load(context);
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);

    _tabController?.addListener((){

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: getTranslated('product_details', context),isBackButtonExist: true,
          isSwitch: widget.productModel!.requestStatus == 1? true: false,
          isAction: true,
        productSwitch: true,
        switchAction: (value){
         if(value){
           Provider.of<ProductProvider>(context, listen: false).productStatusOnOff(context, widget.productModel!.id, 1);
         }else{
           Provider.of<ProductProvider>(context, listen: false).productStatusOnOff(context, widget.productModel!.id, 0);
         }

        },),
        body: RefreshIndicator(
          onRefresh: () async{
            load(context);
          },
          child: Consumer<AuthProvider>(
              builder: (authContext,authProvider, _) {
                return Column( children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).cardColor,
                      child: TabBar(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                        controller: _tabController,
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Theme.of(context).hintColor,
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorWeight: 1,
                        isScrollable: true,
                        unselectedLabelStyle: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400,
                        ),
                        labelStyle: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w700,
                        ),
                        tabs: [
                          Tab(text: getTranslated("product_details", context)),
                          Tab(text: getTranslated("reviews", context)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: Dimensions.paddingSizeSmall,),
                  Expanded(child: TabBarView(
                    controller: _tabController,
                    children: [
                      ProductDetailsWidget(productModel: widget.productModel),
                      ProductReviewScreen(productModel: widget.productModel),
                    ],
                  )),
                ]);
              }
          ),
        )
    );
  }
}
