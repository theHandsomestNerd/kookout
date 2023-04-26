import 'package:cookowt/config/default_config.dart';
import 'package:cookowt/models/controllers/analytics_controller.dart';
import 'package:cookowt/shared_components/menus/login_menu.dart';
import 'package:cookowt/wrappers/app_scaffold_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/controllers/auth_controller.dart';
import '../models/controllers/auth_inherited.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late String appName;
  late String packageName;
  late String version;
  late String buildNumber;
  late AuthController authController;
  late AnalyticsController analyticsControllerController;
  late String sanityDB;
  late String apiVersion;
  late String sanityApiDB;

  @override
  void initState() {
    super.initState();
  }

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    AuthController? theAuthController =
        AuthInherited.of(context)?.authController;
    if (theAuthController != null) {
      authController = theAuthController;
    }
    AnalyticsController? theAnalyticsController =
        AuthInherited.of(context)?.analyticsController;

    if (theAnalyticsController != null) {
      analyticsControllerController = theAnalyticsController;
    }
    theAnalyticsController?.logScreenView('Login');
    apiVersion = DefaultConfig.apiVersion;
    sanityApiDB = DefaultConfig.apiSanityDB;
    setState(() {});
    if (kDebugMode) {
      print("dependencies changed splash page");
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return AppScaffoldWrapper(
      floatingActionMenu: const LoginMenu(),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            child: Center(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/221.jpg',
                      repeat: ImageRepeat.repeat,
                    ),
                  ),
                  Center(
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 8,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  height: 150,
                                  width: 300,
                                  child: Image.asset('assets/logo-w.png'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              Text(DefaultConfig.appName),
                              Text(
                                  "ui v${DefaultConfig.version}.${DefaultConfig.buildNumber} - ${DefaultConfig.sanityDB}"),
                              Text("api - ${DefaultConfig.apiStatus}"),
                              Text("v$apiVersion -$sanityApiDB"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
