import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/pages/main_home.dart';
import 'package:kombat_flutter/pages/splash/splash_view.dart';

const splashPath = '/splash';
const homePath = '/home';
const lotteryPath = '/lottery';
const exchangePath = '/exchange';
const friendsPath = '/friends';
const earnPath = '/earn';
const airDropPath = '/airDrop';
const settingsPath = '/settins';
const balancePath = '/balacne';
const selectLangPath = '/language';
const profilePath = '/profile';

final List<GetPage> routes = [
  GetPage(
    name: splashPath,
    page: () => SplashView(),
  ),
  GetPage(
    name: homePath,
    page: () => MainHome(),
  ),  
];
