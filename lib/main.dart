import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wave_mall_vendor/localization/app_localization.dart';
import 'package:wave_mall_vendor/provider/auth_provider.dart';
import 'package:wave_mall_vendor/provider/business_provider.dart';
import 'package:wave_mall_vendor/provider/cart_provider.dart';
import 'package:wave_mall_vendor/provider/chat_provider.dart';
import 'package:wave_mall_vendor/provider/coupon_provider.dart';
import 'package:wave_mall_vendor/provider/delivery_man_provider.dart';
import 'package:wave_mall_vendor/provider/emergency_contact_provider.dart';
import 'package:wave_mall_vendor/provider/language_provider.dart';
import 'package:wave_mall_vendor/provider/localization_provider.dart';
import 'package:wave_mall_vendor/provider/bottom_menu_provider.dart';
import 'package:wave_mall_vendor/provider/location_provider.dart';
import 'package:wave_mall_vendor/provider/order_provider.dart';
import 'package:wave_mall_vendor/provider/product_provider.dart';
import 'package:wave_mall_vendor/provider/product_review_provider.dart';
import 'package:wave_mall_vendor/provider/profile_provider.dart';
import 'package:wave_mall_vendor/provider/refund_provider.dart';
import 'package:wave_mall_vendor/provider/shop_provider.dart';
import 'package:wave_mall_vendor/provider/shipping_provider.dart';
import 'package:wave_mall_vendor/provider/shop_info_provider.dart';
import 'package:wave_mall_vendor/provider/splash_provider.dart';
import 'package:wave_mall_vendor/provider/theme_provider.dart';
import 'package:wave_mall_vendor/provider/bank_info_provider.dart';
import 'package:wave_mall_vendor/provider/transaction_provider.dart';
import 'package:wave_mall_vendor/theme/dark_theme.dart';
import 'package:wave_mall_vendor/theme/light_theme.dart';
import 'package:wave_mall_vendor/utill/app_constants.dart';
import 'package:wave_mall_vendor/view/screens/splash/splash_screen.dart';

import 'di_container.dart' as di;
import 'notification/my_notification.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  int? orderID;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    orderID = (notificationAppLaunchDetails!.payload != null && notificationAppLaunchDetails.payload!.isNotEmpty)
        ? int.parse(notificationAppLaunchDetails.payload!) : null;
  }
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  FlutterNativeSplash.remove();
  await MyNotification.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ShopProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BankInfoProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BusinessProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<TransactionProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SellerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductReviewProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ShippingProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<DeliveryManProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<RefundProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BottomMenuController>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<EmergencyContactProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CouponProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocationProvider>()),
    ],
    child: MyApp(orderId: orderID),
  ));
}

class MyApp extends StatelessWidget {
  final int? orderId;


  const MyApp({Key? key, this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in AppConstants.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      builder:(context,child){
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling), child: child!);
      },
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: locals,
      home: SplashScreen(orderId: orderId),
    );
  }
}
class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}