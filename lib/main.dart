import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/injection/permission.dart';
import 'package:shiva_poly_pack/data/injection/routes.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

void main() {
  runApp(DevicePreview(
    enabled: !kReleaseMode, // Enable only in debug mode
    builder: (context) => const MyApp(),
  ));
  WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((c) {
    requestPermissions();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shiva Poly Packs',
      initialBinding: RootBinding(),
      initialRoute: Routes.upload_picture,
      debugShowCheckedModeBanner: false,
      getPages: AppRouter.pages,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
