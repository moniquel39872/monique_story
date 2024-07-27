import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/pages/main_home.dart';
import 'package:kombat_flutter/pages/splash/splash_view.dart';

const splashPath = '/splash';
const homePath = '/home';
const exchangePath = '/exchange';
const friendsPath = '/friends';
const earnPath = '/earn';
const airDropPath = '/airDrop';
const settingsPath = '/settins';

final List<GetPage> routes = [
  GetPage(
    name: splashPath,
    page: () => SplashView(),
  ),
  GetPage(
    name: homePath,
    page: () => MainHome(),
  ),
  // GetPage(
  //   name: friendsPath,
  //   page: () => FriendsView(),
  // ),
  // GetPage(
  //   name: airDropPath,
  //   page: () => AirDropView(),
  // ),
  // GetPage(
  //   name: settingsPath,
  //   page: () => SettingsView(),
  // ),
];