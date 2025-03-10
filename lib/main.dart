import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intern/core/app_export.dart';
import 'package:provider/provider.dart';

import 'presentation/home_page_screen/bloc/homepage_bloc.dart'; // Add this import

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]).then((value) {
    PrefUtils().init();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HomePageBloc>(create: (_) => HomePageBloc()), // Add your provider here
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return BlocProvider(
            create: (context) => ThemeBloc(
              ThemeState(
                themeType: PrefUtils().getThemeData(),
              ),
            ),
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return MaterialApp(
                  theme: theme,
                  title: 'chotot',
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaler: TextScaler.linear(1.0),
                      ),
                      child: child!,
                    );
                  },
                  navigatorKey: NavigatorService.navigatorKey,
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: [
                    AppLocalizationDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],
                  locale: Locale('en', ''),
                  supportedLocales: [Locale('en', '')],
                  initialRoute: AppRoutes.initialRoute,
                  routes: AppRoutes.routes,
                );
              },
            ),
          );
        },
      ),
    );
  }
}