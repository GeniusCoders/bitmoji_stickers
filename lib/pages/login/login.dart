import 'package:BitmojiStickers/bloc/auth_bloc/auth_bloc.dart';
import 'package:BitmojiStickers/bloc/login_bloc/login_bloc.dart';
import 'package:BitmojiStickers/pages/Dashboard/dashboard_page.dart';
import 'package:BitmojiStickers/pages/loading/loading.dart';
import 'package:BitmojiStickers/styles/colors.dart';
import 'package:BitmojiStickers/util/ads/ads_data/ads_data.dart';
import 'package:BitmojiStickers/util/ads/baner_adview.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../injection.dart';
import 'login_widgets/login_bitmoji.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  BannerAd _bannerAd;
  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: BannerAdView.adUnitId);
    _bannerAd = BannerAdView.createBannerAd(getIt<AdsData>().bannerAd1)
      ..load()
      ..show();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }

  _onPress() {
    BlocProvider.of<LoginBloc>(context).add(LoginButtonEvent(
        email: 'nilkadam085@gmail.com', password: 'nilesh@bitmoji'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginSuccess) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => DashboardPage()),
            (Route<dynamic> route) => false);
      }
    }, builder: (context, state) {
      return SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LoginBitmoji(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey.withOpacity(.4), width: .6),
                        borderRadius: BorderRadius.circular(10.w)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                size: 22,
                              ),
                              hintText: 'Email',
                              border: InputBorder.none),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Divider(
                          color: Colors.black87,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 22,
                              ),
                              hintText: 'Password',
                              border: InputBorder.none),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        InkWell(
                          onTap: _onPress,
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10.w))),
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(child: state is LoginLoading ? Loading() : null)
          ],
        ),
      );
    });
  }
}
