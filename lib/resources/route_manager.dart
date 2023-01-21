import 'package:application/ui/screens/dashboard/dashboard.dart';
import 'package:application/ui/screens/dashboard/home_page/language_screen.dart';
import 'package:application/ui/screens/dashboard/home_page/home_page.dart';
import 'package:application/ui/screens/dashboard/product_page/product_card.dart';
import 'package:application/ui/screens/dashboard/product_page/products_list.dart';
import 'package:application/ui/screens/dashboard/wishlist_page/wishlist_page.dart';
import 'package:application/ui/screens/login_page/login_page.dart';
import 'package:application/ui/screens/resetpass_page/resetpass_page.dart';
import 'package:application/ui/screens/signup_page/signup_page.dart';
import 'package:application/ui/screens/splash/splash_screeen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.id: (context) => const SplashScreen(),
  SignupPage.id: (context) => const SignupPage(),
  LoginPage.id: (context) => const LoginPage(),
  ResetPassScreen.id: (context) => const ResetPassScreen(),
  Dashboard.id: (context) => const Dashboard(),
  DrawerPage.id: (context) => const DrawerPage(),
  MyLists.id: (context) => const MyLists(),
  //ProductCard.id: (context) => ProductCard(),
  //ProductList.id: (context) => ProductList(),
  ChangeLanguage.id:(context) => ChangeLanguage(),
};

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
