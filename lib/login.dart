import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/future_production/login_future_production.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/future_main/login_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_office.dart';
import 'package:prototype_app_pang/main_menu/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsEOfficeInfor.dart';
import 'package:prototype_app_pang/model/ItemsLogin.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGLoginResponse.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaffResponse.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:prototype_app_pang/server/server.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main_menu/arrest/model/master/item_product_size.dart';
import 'main_menu/future/item_version.dart';
import 'main_menu/future/transection_future.dart';
import 'model/ItemsLoginResponse.dart';

class LoginScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<LoginScreen> {
  // ============================ Styles =============================
  FontStyles _fontStyles = FontStyles();
  Color _color_button = Color(0xff81b4d5);
  Color _color_bg = Color(0xff0069aa);

  //dialog
  TextStyle TitleStyle = TextStyle(fontSize: 16, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: FontStyles().FontSizeData, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: FontStyles().FontSizeData, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  // =================================================================
  // ============================ Value ==============================
  final FocusNode myFocusNodeUsername = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();
  TextEditingController editUsername = new TextEditingController();
  TextEditingController editPassword = new TextEditingController();
  bool _obscureText = true;

  ItemsMasterTitleResponse itemsTitle;
  ItemsArrestResponseGetOffice itemsOffice;
  ItemsMasProductSizeResponse itemsMasProductSize = new ItemsMasProductSizeResponse(SUCCESS: true, RESPONSE_DATA: [
    new ItemsListProductSize(
      SIZE_ID: 1,
      SIZE_NAME_TH: "มิลลิลิตร",
      SIZE_NAME_EN: "ml",
      SIZE_SHORT_NAME: "ม.ล.",
      IS_ACTIVE: 1,
    )
  ]);
  ItemsMasProductUnitResponse itemsMasProductUnit;
  ItemsMasWarehouseResponse itemsMasWarehouse;

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ItemsOAGMasStaff _information;

  // String _version = "1.0.8+6";
  String _version = "1.0.0";
  bool IsNetWorkError = false;

  bool checkValue = false;
  SharedPreferences sharedPreferences;
  // =================================================================

  @override
  void initState() {
    super.initState();

    // ScreenUtil.init(context);
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    getCredential();
    // editUsername.text = "3792";
    // editPassword.text = "1234";
    // editUsername.text = "wannapa_j";
    // editPassword.text = "wannapa69";
    // editUsername.text = "";
    // editPassword.text = "";
    // versionCheck(context);
  }

  CupertinoAlertDialog _createCupertinoUpdateVersionDialog(title, desc) {
    return new CupertinoAlertDialog(
        title: new Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Text(
            title,
            style: TitleStyle,
          ),
        ),
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            desc,
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text('ภายหลัง', style: ButtonCancelStyle)),
          new CupertinoButton(onPressed: () => _launchURL(), child: new Text('อัพเดทตอนนี้', style: ButtonAcceptStyle)),
        ]);
  }

  _launchURL() async {
    String url = new Server().IPAddress + '/DownloadNewVersion.html/' + itemsListVersion.VERSION_ID.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showUpdateVersionAlertDialog(title, desc) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoUpdateVersionDialog(title, desc);
      },
    );
  }

  versionCheck(context) async {
    Map map = {'VERSION_TYPE': 0};
    await onLoadActionVersionCheck(map);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    print("appName : " + appName);
    print("packageName : " + packageName);
    print("version : " + version);
    print("buildNumber : " + buildNumber);

    _version = (version.trim() + "+" + buildNumber.trim()).trim();

    if (itemsListVersion != null) {
      if (itemsListVersion.VERSION_NAME.trim() != (version.trim() + "+" + buildNumber.trim()).trim()) {
        print("Version ไม่ตรง");
        IsNewVersion = true;
        _showUpdateVersionAlertDialog("อัพเดท", "ต้องการอัพเดทเป็นเวอร์ชั่น " + itemsListVersion.VERSION_NAME);
      }
    }
  }

  ItemsListVersion itemsListVersion;
  bool IsNewVersion = false;
  Future<bool> onLoadActionVersionCheck(Map map) async {
    IsNewVersion = false;
    await new TransectionFuture().apiRequestCheckVersion(map).then((onValue) {
      if (onValue.length > 0) {
        itemsListVersion = onValue.first;
      }
    });
    setState(() {});
    return true;
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          editUsername.text = sharedPreferences.getString("username");
          editPassword.text = sharedPreferences.getString("password");
          // FocusScope.of(context).requestFocus(myFocusNodeUsername);
          // FocusScope.of(context).requestFocus(myFocusNodePassword);
          FocusScope.of(context).unfocus();
          // editUsername.selection = TextSelection.fromPosition(TextPosition(offset: editUsername.text.length));
          // editPassword.selection = TextSelection.fromPosition(TextPosition(offset: editPassword.text.length));
        } else {
          editUsername.clear();
          editPassword.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  _onChanged(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("username", editUsername.text);
      sharedPreferences.setString("password", editPassword.text);
      sharedPreferences.commit();
      getCredential();
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();

    myFocusNodeUsername.dispose();
    myFocusNodePassword.dispose();
    super.dispose();
  }

  // =========================== Go Home =============================
  void _putDataLogin(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      new VerifyDialog(context, "กรุณากรอกข้อมูลให้ครบ.");
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          });
      await onLoadLoginOAG(username, password);
      Navigator.pop(context);

      if (IsNetWorkError) {
        //network not connect
        new NetworkDialog(context, "การเชื่อมต่อกับ Server มีปัญหา");
      } else {
        if (_information == null) {
          //user && pass incorrect!!
          new VerifyDialog(context, "Username หรือ Password ไม่ถูกต้อง");
        } else {
          // if (_information != null && itemsTitle != null && itemsOffice != null && itemsMasProductUnit != null && itemsMasProductSize != null && itemsMasWarehouse != null) {
          if (_information != null) {
            sharedPreferences = await SharedPreferences.getInstance();
            setState(() {
              if (checkValue) {
                sharedPreferences.setString("username", editUsername.text);
                sharedPreferences.setString("password", editPassword.text);
                editUsername.selection = TextSelection.fromPosition(TextPosition(offset: editUsername.text.length));
                editPassword.selection = TextSelection.fromPosition(TextPosition(offset: editPassword.text.length));
              }
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        ItemsData: _information,
                        // itemsLoginStaff: _information,
                        itemsTitle: itemsTitle,
                        itemsOffice: itemsOffice,
                        itemsMasProductUnit: itemsMasProductUnit,
                        itemsMasProductSize: itemsMasProductSize,
                        itemsMasWarehouse: itemsMasWarehouse,
                      )),
            );
          }
          // else {
          //   //new NetworkDialog(context, "การเชื่อมต่อมีปัญหา");
          // }
        }
      }
    }
  }

  // =================================================================
  // =========================== Login OAG ===========================
  Future<bool> onLoadLoginOAG(username, password) async {
    _information = null;
    IsNetWorkError = false;
    String bodyText = "client_id=56e40953-db9d-477b-954e-73f3ec357190&client_secret=71ebae10-1726-4477-8719-2f5dac68281f&grant_source=int_ldap&grant_type=password&password=train01&scope=resource.READ&username=train01";
    String resToken = "";
    Map mapBody = {"UserName": username, "Password": password};
    print("mapBody: ${mapBody}");
    String resID = "";

    //await new LoginFuture().apiRequestOAG(bodyText).then((onValue) async {
    await new LoginFutureProduction().apiRequestProduction().then((onValue) async {
      if (onValue == null) {
        IsNetWorkError = true;
      } else {
        resToken = onValue;
        print("Response Token: ${resToken.toString()}");
      }
    });
    //await new LoginFuture().apiRequestLogin(resToken, mapBody).then((onValue) async {
    await new LoginFutureProduction().apiRequestProductionLogin(resToken, mapBody).then((onValue) async {
      if (onValue == null) {
        IsNetWorkError = true;
      } else {
        resID = onValue.userThaiId;
        print("Response ID: ${resID.toString()}");
      }
    });
    if (resID != null) {
      Map mapMasStaffBody = {"TEXT_SEARCH": resID, "STAFF_ID": ""};
      //await new LoginFuture().apiRequestMasStaffgetByCon(resToken, mapMasStaffBody).then((onValue) async {
      await new LoginFutureProduction().apiRequestProductionMasStaffgetByCon(resToken, mapMasStaffBody).then((onValue) async {
        if (onValue == null) {
          IsNetWorkError = true;
        } else {
          _information = onValue.RESPONSE_DATA.first;
          print("Response: ${onValue.RESPONSE_DATA.first.STAFF_ID}");
          print("Response STAFF_ID: ${_information.STAFF_ID}");
        }
      });
    }

    if (!IsNetWorkError) {
      Map map_title = {"TEXT_SEARCH": ""};
      await new ArrestFutureMaster().apiRequestMasTitlegetByCon(map_title).then((onValue) {
        itemsTitle = onValue;
      });
      Map map_office = {"TEXT_SEARCH": "", "STAFF_ID": ""};
      await new ArrestFutureMaster().apiRequestMasOfficegetByCon(map_office).then((onValue) {
        itemsOffice = onValue;
      });
      //Unit
      Map map_unit = {"TEXT_SEARCH": ""};
      await new ArrestFutureMaster().apiRequestMasProductUnitgetByKeyword(map_unit).then((onValue) {
        itemsMasProductUnit = onValue;
      });
      await new ArrestFutureMaster().apiRequestMasWarehousegetByKeyword(map_unit).then((onValue) {
        itemsMasWarehouse = onValue;
      });
    }
    setState(() {});
    return true;
  }
  // =================================================================

  CupertinoAlertDialog _createCupertinoCloseAppDialog() {
    return CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            "ต้องการปิดแอพพลิเคชั่น.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text('ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(onPressed: () => exit(0), child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void onChange(text) {
    print(text);
  }

  void _showCloseAppAlertDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCloseAppDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    // TODO: implement build
    TextStyle textStyleTitle = TextStyle(fontSize: ScreenUtil().setSp(52.0), color: Color(0xffffffff), fontFamily: _fontStyles.FontFamily, fontWeight: FontWeight.w400);
    TextStyle textStyleLogin = TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w400, fontFamily: _fontStyles.FontFamily);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.white70, fontFamily: _fontStyles.FontFamily);
    TextStyle textInputStyleVersion = TextStyle(fontSize: 14.0, color: Colors.white70, fontFamily: _fontStyles.FontFamily);
    TextStyle textInputStyleVersionUpdate = TextStyle(fontSize: FontStyles().FontSizeData, color: Color(0xfff7ce67), fontWeight: FontWeight.w400, decoration: TextDecoration.underline, fontFamily: _fontStyles.FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: ScreenUtil().setWidth(18.0), bottom: ScreenUtil().setWidth(18.0));

    var size = MediaQuery.of(context).size;
    // double width = (size.width * 85) / 100;
    double width = (ScreenUtil.screenWidthDp * 85) / 100;

    final _button_login = Container(
      width: width,
      //height: (size.height * 7) / 100,
      padding: EdgeInsets.only(top: ScreenUtil().setWidth(14.0), bottom: ScreenUtil().setWidth(14.0)),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF00000),
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
          BoxShadow(
            color: Color(0xFF00000),
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
        ],
        gradient: new LinearGradient(
            colors: [
              Color(0xff51b8d8),
              Color(0xFF1d9cc3),
            ],
            begin: const FractionalOffset(0.2, 0.2),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: MaterialButton(
          highlightColor: Colors.transparent,
          splashColor: Color(0xFF00000),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
            child: Text(
              "เข้าสู่ระบบ",
              style: textStyleLogin,
            ),
          ),
          onPressed: () {
            _putDataLogin(editUsername.text, editPassword.text);
          }),
    );

    final _logo = Padding(
      padding: EdgeInsets.only(
          //top: 65.0, left: 38.0, right: 38.0, bottom: 35.0),
          top: (size.height * 10) / 100,
          left: 38.0,
          right: 38.0,
          bottom: (size.height * 3) / 100),
      child: new Image(fit: BoxFit.cover, image: new AssetImage('assets/images/logo_login.png')),
    );

    final _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: width,
      height: 1.0,
      color: Colors.grey[300],
    );

    final _inputBox = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeUsername,
            controller: editUsername,
            keyboardType: TextInputType.text,
            // textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'ชื่อผู้ใช้งาน',
              labelStyle: textInputStyle,
            ),
            onChanged: onChange,
            onEditingComplete: () => myFocusNodePassword.requestFocus(),
          ),
        ),
        _buildLine,
        Container(
          width: width,
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodePassword,
            controller: editPassword,
            obscureText: _obscureText,
            keyboardType: TextInputType.text,
            // textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            style: textInputStyle,
            decoration: InputDecoration(border: InputBorder.none, labelText: 'รหัสผ่าน', labelStyle: textInputStyle),
            onChanged: (str) {
              print("Password: ${str}");
            },
          ),
        ),
        _buildLine,
      ],
    );

    return WillPopScope(
      onWillPop: () {
        _showCloseAppAlertDialog();
      },
      child: Scaffold(
        backgroundColor: _color_bg,
        body: Stack(
          children: <Widget>[
            Background(),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight((size.height * 20) / 100),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: _logo,
                  )),
              body: Center(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        width: width,
                        child: Center(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'ระบบสารสนเทศงานปราบปราม',
                              style: textStyleTitle,
                            ),
                            Text(
                              'งานเปรียบเทียบปรับ',
                              style: textStyleTitle,
                            ),
                            Text(
                              'งานจัดเก็บและบริหารของกลางในคดี',
                              style: textStyleTitle,
                            ),
                            // Text(
                            //   'ระบบทดสอบ (UAT)',
                            //   style: TextStyle(fontSize: ScreenUtil().setSp(52.0), color: Colors.yellow, fontFamily: _fontStyles.FontFamily, fontWeight: FontWeight.w800),
                            // ),
                          ],
                        ))),
                    Padding(
                      // padding: EdgeInsets.only(top: (size.height * 7) / 100, bottom: (size.height * 7) / 100),
                      padding: EdgeInsets.only(top: (size.height * 7) / 100),
                      child: _inputBox,
                    ),
                    Container(
                      // padding: EdgeInsets.only(top: 8, bottom: (size.height * 7) / 100),
                      padding: EdgeInsets.only(left: 4.0),
                      child: Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white70),
                        child: CheckboxListTile(
                          title: Container(
                            transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
                            child: Text(
                              "จดจำฉัน",
                              style: textInputStyle,
                            ),
                          ),
                          value: checkValue,
                          onChanged: _onChanged,
                          controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                          checkColor: Colors.blue[900],
                          activeColor: Colors.white70,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: (size.height * 5) / 100, bottom: (size.height * 5) / 100),
                      child: _button_login,
                    )
                  ],
                ),
              )),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'เวอร์ชั่น ' + _version,
                  style: textInputStyleVersion,
                ),
                IsNewVersion
                    ? Container(
                        padding: EdgeInsets.only(left: 16.0),
                        child: new ButtonTheme(
                          minWidth: 44.0,
                          padding: new EdgeInsets.all(0.0),
                          child: new FlatButton(
                            child: new Text(
                              "อัพเดท",
                              style: textInputStyleVersionUpdate,
                            ),
                            onPressed: () {
                              _showUpdateVersionAlertDialog("อัพเดท", "ต้องการอัพเดทเป็นเวอร์ชั่น " + itemsListVersion.VERSION_NAME);
                            },
                          ),
                        ),
                      )
                    : Text('')
              ],
            )),
      ),
    );
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;

        try {
          wifiName = await _connectivity.getWifiName();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          wifiBSSID = await _connectivity.getWifiBSSID();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          _connectionStatus = '$result\n'
              'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n'
              'Wifi IP: $wifiIP\n';
        });
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() {
          _connectionStatus = result.toString();
          /*if (result == ConnectivityResult.none) {
            new NoInternetDialog(context, 'เตือน', 'ไม่ได้เชื่อมต่ออินเทอร์เน็ต');
          }*/
        });
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }
}

// class MyCustomRoute<T> extends MaterialPageRoute<T> {
//   MyCustomRoute({WidgetBuilder builder, RouteSettings settings}) : super(builder: builder, settings: settings);

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
//     if (settings.isInitialRoute) return child;
//     // Fades between routes. (If you don't want any animation,
//     // just return child.)
//     return new FadeTransition(opacity: animation, child: child);
//   }
// }
