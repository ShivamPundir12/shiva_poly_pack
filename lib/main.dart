import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/injection/routes.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

void main() async {
  runApp(
    const MyApp(),
  );
  GetStorage.init();
  // LocalStorageManager.clearAllData();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shiva Poly Packs',
      initialBinding: RootBinding(),
      initialRoute: Routes.splash,
      debugShowCheckedModeBanner: false,
      getPages: AppRouter.pages,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorPallets.themeColor2),
        useMaterial3: true,
      ),
    );
  }
}
