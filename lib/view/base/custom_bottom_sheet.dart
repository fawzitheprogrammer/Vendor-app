import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_mall_vendor/provider/localization_provider.dart';
import 'package:wave_mall_vendor/provider/theme_provider.dart';
import 'package:wave_mall_vendor/utill/color_resources.dart';
import 'package:wave_mall_vendor/utill/dimensions.dart';
import 'package:wave_mall_vendor/utill/styles.dart';
import 'package:wave_mall_vendor/view/base/custom_image.dart';

class CustomBottomSheet extends StatelessWidget {
  final String image;
  final String? title;
  final bool isProfile;
  final Function? onTap;
  const CustomBottomSheet({Key? key,  required this.image, required this.title, this.isProfile = false, this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorResources.getBottomSheetColor(context),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!,
              spreadRadius: 0.5, blurRadius: 0.3)],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SizedBox(width: MediaQuery.of(context).size.width/14,
              height: MediaQuery.of(context).size.width/14,
              child: isProfile?
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                      child: CustomImage(image: image)):
              Image.asset(image),),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

              Center(child: Text(title!,
                textAlign: TextAlign.center,
                maxLines: Provider.of<LocalizationProvider>(context,listen: false).isLtr? 1 : 1,
                  overflow: TextOverflow.ellipsis,
                style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)
              ),),]),
      ),
    );
  }
}
