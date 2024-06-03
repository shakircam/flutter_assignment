import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'app/core/provider/provider.dart';
import 'app/core/services/service_locator.dart';
import 'app/my_app.dart';
import 'app/utils/constants.dart';
import 'flavors/build_config.dart';
import 'flavors/env_config.dart';
import 'flavors/environment.dart';

void main() async {
  EnvConfig devConfig = EnvConfig(
    appName: "Flutter Prod",
    baseUrl: "https://apptest.dokandemo.com/wp-json/",
    shouldCollectCrashLog: true,
  );

  BuildConfig.instantiate(
    envType: Environment.PRODUCTION,
    envConfig: devConfig,
  );

  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init(databaseName);
  await ScreenUtil.ensureScreenSize();
  await ServiceLocator.setUpServiceLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(providers: ProviderPath.providersList, child: MyApp()));
}
