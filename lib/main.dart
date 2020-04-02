import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/login.dart';
import 'package:prototype_app_pang/main_menu/home.dart';
import 'package:prototype_app_pang/main_menu/arrest/arrest_screen_1.dart';
import 'package:prototype_app_pang/test.dart';
import 'package:prototype_app_pang/text/text.dart';
import 'package:prototype_app_pang/color/text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ระบบผู้กระทำผิดกฏหมายสรรพสามิต',
      theme: ThemeData(
        primaryColor: Color(0xff2e76bc),
        /*textTheme: TextTheme(
          title: TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily),
        ),*/
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        //intent เกี่ยวข้อง
        '/Home': (BuildContext context) => new HomeScreen(),
        '/ArrstMain': (BuildContext context) => new ArrestMainScreenFragment(),
        '/Login': (BuildContext context) => new LoginScreen(),
        '/Test': (BuildContext context) => new TestPage(),
      },
      locale: Locale('th', 'TH'),
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('th', 'TH'),
      ],
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  //set Font
  FontStyles _fontStyles = FontStyles();

  Animation animation;
  AnimationController animationController;
  int factcounter = 0;
  int colorcounter = 0;

  SetText _text = new SetText();
  TextColors _textColor = new TextColors();

  void navigationPage() async {
    //intent
    Navigator.of(context).pushReplacementNamed('/Login');
    //Navigator.of(context).pushReplacementNamed('/Test');
    //Navigator.of(context).pushReplacementNamed('/Version');
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);
    animation.addListener(() {
      this.setState(() {});
    });
    animationController.forward();

    startTime();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void showfacts() {
    setState(() {
      /* dispfact = facts[factcounter];
      dispcolor = bgcolors[colorcounter];
      factcounter = factcounter < facts.length - 1 ? factcounter + 1 : 0;
      colorcounter = colorcounter < bgcolors.length - 1 ? colorcounter + 1 : 0;*/

      animationController.reset();
      animationController.forward();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xffffffff),
      body: new Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
        child: new Center(
          child: new Opacity(
            opacity: animation.value * 1,
            child: new Transform(
              transform: new Matrix4.translationValues(0.0, animation.value * -50.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 160.0,
                    width: 160.0,
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: new AssetImage('assets/images/logo.jpg'),
                        fit: BoxFit.contain,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  new Transform(
                    transform: new Matrix4.translationValues(0.0, animation.value * -50.0, 0.0),
                    child: Padding(
                      padding: EdgeInsets.only(top: 80.0),
                      child: Text(
                        _text.text_splash,
                        style: TextStyle(fontSize: 18.0, color: _textColor.text_splash_color, fontFamily: _fontStyles.FontFamily),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
