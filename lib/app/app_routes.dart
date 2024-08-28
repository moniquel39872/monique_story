import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/pages/guide/guide_view.dart';
import 'package:kombat_flutter/pages/main_home.dart';
import 'package:kombat_flutter/pages/splash/splash_view.dart';

const guidePath = '/guide';
const splashPath = '/splash';
const homePath = '/home';
const lotteryPath = '/lottery';
const minePath = '/mine';
const friendsPath = '/friends';
const earnPath = '/earn';
const exchangePath = '/exchange';
const settingsPath = '/settins';
const balancePath = '/balacne';
const selectLangPath = '/language';
const profilePath = '/profile';
const earnMorePath = '/earnMore';

final List<GetPage> routes = [
  GetPage(
    name: guidePath,
    page: () => GuideView(),
  ),
  GetPage(
    name: splashPath,
    page: () => const SplashView(),
  ),
  GetPage(
    name: homePath,
    page: () => MainHome(),
  ),  
];
