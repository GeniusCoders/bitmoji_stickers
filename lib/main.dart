import 'package:BitmojiStickers/bloc/login_bloc/login_bloc.dart';
import 'package:BitmojiStickers/pages/Dashboard/dashboard_page.dart';
import 'package:BitmojiStickers/pages/login/login_page.dart';
import 'package:BitmojiStickers/pages/splash/splash.dart';
import 'package:BitmojiStickers/styles/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/auth_bloc/auth_bloc.dart';
import 'injection.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  configure('env');
  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(BlocProvider(
    create: (_) => getIt<AuthBloc>()..add(AppStarted()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BitSticker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF39ca8e, getSwatch(primaryColor)),
        fontFamily: 'SF UI Display',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Builder(
        builder: (context) {
          ScreenUtil.init(
            context,
            designSize: Size(360.0, 780.0),
          );

          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AppAuth) {
                return BlocProvider(
                  create: (context) => getIt<LoginBloc>(),
                  child: DashboardPage(),
                );
              } else if (state is AppUnAuth) {
                return LoginPage();
              }
              return Splash();
            },
          );
        },
      ),
    );
  }
}
