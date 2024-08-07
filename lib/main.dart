import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/main_binding.dart';
import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await GetStorage.init();
    
    var appService = await Get.putAsync(() => AppService().init(), permanent: true);
    await appService.getHotlineStorageData();
    await appService.queryLanguageTrans();

    runApp(
      ChangeNotifierProvider(
        create: (_) => AppTheme(),
        child: const MyApp(),
      ),
    );
  }, (Object obj, StackTrace stack) {
    if (kDebugMode) {
      print(obj);
      print(stack);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(540, 960),
      fontSizeResolver: FontSizeResolvers.width,
      builder: (context, child) {
        return GetMaterialApp(
          builder: EasyLoading.init(),
          title: 'Hamster Kombat',
          debugShowCheckedModeBanner: false,
          // initialRoute: grabCreatePath,
          initialRoute: '/splash',
          getPages: routes,
          theme: AppTheme.lightTheme, // Use light theme
          darkTheme: AppTheme.darkTheme, // Use dark them
          themeMode: ThemeMode.system,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          initialBinding: MainBindings(),
        );
      },
    );
  }
}

