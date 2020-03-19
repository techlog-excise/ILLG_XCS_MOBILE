import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show Platform;
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_search_face.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_create.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_search_service_reg.dart';
import 'package:prototype_app_pang/main_menu/future/item_service_uat100.dart';
import 'package:prototype_app_pang/main_menu/future/item_service_uat200.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class TabScreenArrest4AddServiceReg extends StatefulWidget {
  ItemsMasterTitleResponse itemsTitle;
  TabScreenArrest4AddServiceReg({
    Key key,
    @required this.itemsTitle,
  }) : super(key: key);
  @override
  TabScreenArrest4AddState createState() => new TabScreenArrest4AddState();
}

class TabScreenArrest4AddState extends State<TabScreenArrest4AddServiceReg> {
  List<ItemsListArrestLawbreaker> itemSearch = [];

  //node type1
  final FocusNode myFocusNodeIdentifyNumber = FocusNode();
  //node type1
  TextEditingController editIdentifyNumber = new TextEditingController();

  List _itemsData = [];

  TextStyle textSearchByImgStyle = TextStyle(fontSize: 16.0, color: Colors.blue.shade400, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textStyleSelect = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  TextStyle textStyleStar = Styles.textStyleStar;

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    editIdentifyNumber.dispose();
  }

  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(bottom: MediaQuery.of(context).viewInsets.bottom, right: 0.0, left: 0.0, child: InputDoneView());
    });

    overlayState.insert(overlayEntry);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  Widget _buildContent(BuildContext mContext) {
    Color labelColor = Color(0xff087de1);
    var size = MediaQuery.of(mContext).size;

    Widget _buildLine = Container(
      padding: EdgeInsets.only(bottom: 4.0, left: 22.0, right: 22.0),
      height: 1.0,
      color: Colors.grey[300],
    );

    return Container(
        width: size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 4.0, bottom: 12.0, left: 22.0, right: 22.0),
            //width: Width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "หมายเลขอ้างอิง",
                        style: textLabelStyle,
                      ),
                      Text(
                        " *",
                        style: textStyleStar,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: paddingInputBox,
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(13),
                    ],
                    focusNode: myFocusNodeIdentifyNumber,
                    controller: editIdentifyNumber,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                    style: textInputStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                _buildLine,
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Card(
                          shape: new RoundedRectangleBorder(side: new BorderSide(color: labelColor, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                          elevation: 0.0,
                          child: Container(
                            width: 80.0,
                            child: MaterialButton(
                              onPressed: () {
                                if (editIdentifyNumber.text.isEmpty) {
                                  new VerifyDialog(context, "กรุณากรอกหมายเลขอ้างอิง");
                                } else {
                                  _navigateSearch(mContext);
                                }
                              },
                              splashColor: Colors.grey,
                              child: Center(
                                child: Text(
                                  "ค้นหา",
                                  style: textLabelStyle,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  List<ItemsListFactoryInfo100> factoryInfo = [];
  ItemsListFactoryInfo itemsListFactoryInfo;
  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    factoryInfo = [];
    await new TransectionFuture().apiRequestEDRestServicesUAT100(map).then((onValue) {
      onValue.ResponseData.forEach((resp) {
        List<ItemsListFactoryInfo100> items = [];
        resp.ListFactoryInfo.forEach((item) {
          if (!item.NewregId.isEmpty) {
            items.add(item);
          }
        });
        factoryInfo = items;
      });
    });

    setState(() {});
    return true;
  }

  _navigateSearch(BuildContext mContext) async {
    print(editIdentifyNumber.text.length);
    if (editIdentifyNumber.text.length < 13) {
      new VerifyDialog(context, "กรุณากรอกหมายเลขอ้างอิงให้ถูกต้อง");
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          });
      Map map = {
        "systemid": "systemid",
        "username": "my_username",
        "password": "my_password",
        "IpAddress": "10.11.1.10",
        "requestData": {"Tin": editIdentifyNumber.text, "ActiveStatus": 1}
      };
      await onLoadAction(map);
      Navigator.pop(context);

      if (factoryInfo.length > 0) {
        final result = await Navigator.push(
          mContext,
          MaterialPageRoute(
              builder: (context) => TabScreenArrest4SearchServiceReg(
                    ItemsDataGet: factoryInfo,
                  )),
        );
        if (result.toString() != "back") {
          print("back : " + result.toString());
          _itemsData = result;
          Navigator.pop(mContext, result);
        }
      } else {
        new EmptyDialog(mContext, "ไม่พบข้อมูลผู้ต้องหา");
      }
    }
  }

  CupertinoAlertDialog _cupertinoNetworkError(mContext, text) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
    return new CupertinoAlertDialog(
      content: new Padding(
        padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
        child: Text(
          text,
          style: TitleStyle,
        ),
      ),
      actions: <Widget>[
        new CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Text('ยกเลิก', style: ButtonCancelStyle)),
        new CupertinoButton(
            onPressed: () {
              Navigator.pop(mContext);
            },
            child: new Text('ตกลง', style: ButtonAcceptStyle)),
      ],
    );
  }

  void _showEmptyAlertDialog(context, text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoNetworkError(context, text);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              title: new Padding(
                padding: EdgeInsets.only(right: 22.0),
                child: new Text(
                  "ค้นหาผู้ต้องหา",
                  style: styleTextAppbar,
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context, "back");
                  }),
            ),
          ),
          body: Stack(
            children: <Widget>[
              BackgroundContent(),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //height: 34.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border(
                            top: BorderSide(color: Colors.grey[300], width: 1.0),
                          )),
                      /*child: Column(
                    children: <Widget>[Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: new Text('ILG60_B_01_00_12_00',
                            style: textStylePageName,),
                        ),
                      ],
                    ),
                    ],
                  )*/
                    ),
                    Expanded(
                      child: new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: SingleChildScrollView(
                          child: _buildContent(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
