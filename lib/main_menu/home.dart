import 'package:badges/badges.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/color/text.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/arrest_screen_1_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_office.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_search_screen_2.dart';
import 'package:prototype_app_pang/main_menu/export/export_search_screen.dart';
import 'package:prototype_app_pang/main_menu/find_law/find_law_screen.dart';
import 'package:prototype_app_pang/main_menu/fine/fine_screen.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/lawsuit_screen_2_search.dart';
import 'package:prototype_app_pang/main_menu/musuim/musuim_search_screen.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_screen_2_search.dart';
import 'package:prototype_app_pang/main_menu/report/report_screen.dart';
import 'package:prototype_app_pang/main_menu/report/report_search_screen.dart';
import 'package:prototype_app_pang/main_menu/return/return_body/return_search_screen_2.dart';
import 'package:prototype_app_pang/main_menu/stock/model/stock_list_history.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/arrest_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/auction_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/check_evidence_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/compare_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/destroy_evidence_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/export_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/lawsuit_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/musuim_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/network_page.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/notice_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/prove_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/return_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/stock_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/tacking_tab.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/transfer_tab.dart';
import 'package:prototype_app_pang/main_menu/tracking/tracking_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/transfer/tranfer_search_screen_2.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/text/text.dart';
import 'package:prototype_app_pang/zan/search/SearchPerson.dart';
import 'auction/auction_search_screen_2.dart';
import 'check_evidence/check_evidence_search_screen_2.dart';
import 'check_evidence/future/check_evidence_future.dart';
import 'check_evidence/model/evidence_list.dart';
import 'destroy/destroy_search_screen_2.dart';
import 'manage_evidence/manage_evidence_future/manage_evidence_future.dart';
import 'manage_evidence/model/evidence_out_list.dart';
import 'notice/notice_screen_search.dart';

class DrawerItem {
  String title;
  AssetImage icon;
  DrawerItem(this.title, this.icon);
}

class HomeScreen extends StatefulWidget {
  ItemsOAGMasStaff itemsLoginStaff;
  HomeScreen({
    Key key,
    @required this.itemsLoginStaff,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ============================ Styles =============================
  double fontsize_drawer = 16.0;

  FontStyles _fontStyles = FontStyles();
  TextStyle titleTab = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle menuTextstyle = TextStyle(fontSize: 14.0, fontFamily: FontStyles().FontFamily);
  Color iconMain_color = Color(0xff549ee8);
  Color iconDrawer_color = Colors.white70;

  //dialog
  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  // ===========================================================================================
  // ======================================= Value =============================================
  // ===========================================================================================
  // ======================================= Drawer ============================================
  int _selectedDrawerIndex = 0;
  TextColors _colors = new TextColors();

  final drawerItems = [
    new DrawerItem("ระบบสารสนเทศงานปราบปราม งานเปรียบเทียบปรับ งานจัดเก็บ และบริหารของกลางในคดี", null),
    // new DrawerItem("มาตราฐานความผิด", AssetImage("assets/icons/icon_findlaw.png")),
    // new DrawerItem("คำนวณค่าปรับ", AssetImage("assets/icons/icon_drawer_fine.png")),
    new DrawerItem("ระบบสืบค้นบัญชีรายละเอียดฐานความผิดและอัตราโทษ", AssetImage("assets/icons/icon_findlaw.png")),
    new DrawerItem("ระบบช่วยคำนวนประมาณการค่าปรับเปรียบเทียบคดี", AssetImage("assets/icons/icon_drawer_fine.png")),
  ];
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  // ===========================================================================================

  @override
  void initState() {
    print(widget.itemsLoginStaff.FIRST_NAME);
    // TODO: implement initState
    super.initState();
  }

  // ======================================= Logout ============================================
  CupertinoAlertDialog _createCupertinoLogoutDialog() {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            "ต้องการออกจากระบบ.",
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
                // Navigator.pop(context);
                Navigator.of(context).pushReplacementNamed('/Login');
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void _showLogoutAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoLogoutDialog();
      },
    );
  }

  // ===========================================================================================
  // ======================================= Change index drawer ===============================
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  // ===========================================================================================
  // ======================================= Nav Drawer ========================================
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return _main_tab();
      case 1:
        return new FindLawScreen();
      case 2:
        return new FineScreen();
      default:
        return new Text(
          drawerItems[pos].title,
          style: TextStyle(fontFamily: _fontStyles.FontFamily, fontSize: 16.0),
        );
    }
  }

  // ===========================================================================================
  // ======================================= Change Nav Main ===================================
  _onClickMenu(index) {
    setState(() => _selectedDrawerIndex = index);
  }

  // ===========================================================================================
  // ======================================= Nav Main ==========================================
  Widget _main_tab() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          BackgroundContent(),
          _getMenuItemWidget(_selectedDrawerIndex),
        ],
      ),
    );
  }

  _getMenuItemWidget(int pos) {
    switch (pos) {
      case 0:
        return SafeArea(
          child: new SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _buildContent4(),
                ],
              ),
            ),
          ),
        );
      case 1:
        return new FindLawScreen();
      case 2:
        return new FineScreen();
      default:
        return new Text(
          drawerItems[pos].title,
          style: TextStyle(fontFamily: _fontStyles.FontFamily, fontSize: 16.0),
        );
    }
  }

  // ===========================================================================================
  // ======================================= Main Layout 4 =====================================
  Widget _buildContent4() {
    return Container(
      //padding: EdgeInsets.only(left:12.0,right: 12.0,bottom: 12.0),
      child: ExpandableNotifier(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0, top: 12.0),
                  child: new Text(
                    'งานส่วนอื่นๆ',
                    style: titleTab,
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.only(right: 12.0, bottom: 12.0),
                  child: Builder(builder: (context) {
                    var exp = ExpandableController.of(context);
                    return Container(
                        /* padding: EdgeInsets.only(
                              top: 12.0, bottom: 12.0),*/
                        //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),

                        );
                  }),
                ),
              ],
            ),
            Expandable(
              collapsed: buildExpanded_menu1(),
              //expanded: buildCollapsed_menu1(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpanded_menu1() {
    var size = MediaQuery.of(context).size;
    return new Container(
        //padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new ButtonTheme(
                minWidth: 44.0,
                padding: new EdgeInsets.all(0.0),
                child: Container(
                  width: size.width / 3,
                  child: Column(
                    children: <Widget>[
                      FlatButton(
                        highlightColor: TextColors().text_splash_color,
                        onPressed: () {
                          _onClickMenu(1);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_findlaw.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.fitWidth,
                            color: iconMain_color,
                          ),
                        ),
                      ),
                      Text(
                        'ระบบสืบค้นบัญชีรายละเอียดฐานความผิดและอัตราโทษ',
                        style: menuTextstyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              new ButtonTheme(
                minWidth: 44.0,
                padding: new EdgeInsets.all(0.0),
                child: Container(
                  width: size.width / 3,
                  child: Column(
                    children: <Widget>[
                      FlatButton(
                        highlightColor: TextColors().text_splash_color,
                        onPressed: () {
                          _onClickMenu(2);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_fine.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.fitWidth,
                            color: iconMain_color,
                          ),
                        ),
                      ),
                      Text(
                        'ระบบช่วยคำนวนประมาณการค่าปรับเปรียบเทียบคดี',
                        style: menuTextstyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
  // ===========================================================================================

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    drawerOptions.add(Container(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        height: 220,
        width: MediaQuery.of(context).size.width,
        child: new DrawerHeader(
            child: GestureDetector(
                onTap: () {
                  _onSelectItem(0);
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white30),
                        ),
                        //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                        padding: const EdgeInsets.all(3.0),
                        child: ClipOval(
                          child: new Image(fit: BoxFit.cover, image: new AssetImage('assets/images/avatar.png')),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.only(top: 12.0),
                              child: Text(
                                widget.itemsLoginStaff.TITLE_SHORT_NAME_TH + widget.itemsLoginStaff.FIRST_NAME + " " + widget.itemsLoginStaff.LAST_NAME,
                                style: TextStyle(fontFamily: _fontStyles.FontFamily, color: Colors.white70, fontSize: fontsize_drawer),
                              ),
                            ),
                            new Padding(
                              padding: EdgeInsets.only(top: 0), // old : 6
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(widget.itemsLoginStaff.OPREATION_POS_NAME, style: TextStyle(fontFamily: _fontStyles.FontFamily, color: Colors.white70, fontSize: 14, fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(0.0, -6.0, 0.0),
                              child: Padding(
                                padding: EdgeInsets.only(top: 0), // old : 6
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "" + widget.itemsLoginStaff.OPERATION_OFFICE_SHORT_NAME == null ? widget.itemsLoginStaff.OPERATION_OFFICE_SHORT_NAME.toString() : widget.itemsLoginStaff.OPERATION_OFFICE_NAME.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontFamily: _fontStyles.FontFamily, color: Colors.white70, fontSize: 14, fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))),
      ),
    ));

    for (var i = 1; i < drawerItems.length; i++) {
      TextStyle textStyle = TextStyle(color: i == _selectedDrawerIndex ? Colors.white : Colors.white70, fontFamily: _fontStyles.FontFamily, fontSize: fontsize_drawer);
      drawerOptions.add(
        new Container(
          padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
          //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: Container(
            decoration: i == _selectedDrawerIndex
                ? new BoxDecoration(
                    color: _colors.drawer_selected,
                  )
                : null,
            alignment: Alignment.center,
            child: new ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.5),
              leading: Image(
                image: drawerItems[i].icon,
                height: 35.0,
                width: 35.0,
                fit: BoxFit.cover,
                color: i == _selectedDrawerIndex ? Colors.white : iconDrawer_color,
              ),
              title: new Text(
                drawerItems[i].title,
                style: textStyle,
              ),
              selected: i == _selectedDrawerIndex,
              onTap: () => _onSelectItem(i),
            ),
          ),
        ),
      );
    }

    // TODO: implement build
    return WillPopScope(
      onWillPop: () {},
      child: new Scaffold(
          appBar: new AppBar(
            // here we display the title corresponding to the fragment
            // you can instead choose to have a static title
            centerTitle: true,
            title: new Text(
              drawerItems[_selectedDrawerIndex].title,
              style: TextStyle(fontSize: 18.0, fontFamily: _fontStyles.FontFamily),
            ),
            actions: <Widget>[
              // ปิดปุ่มค้นหาหน้ามาตราฐานความผิด
              Container(),
            ],
          ),
          drawer: new Drawer(
              child: Stack(
            children: <Widget>[
              Background(),
              new SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[new Column(children: drawerOptions)],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 22.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.power_settings_new,
                            color: Colors.white70,
                            size: 28.0,
                          ),
                          onPressed: () {
                            _showLogoutAlertDialog();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
          // body: _getDrawerItemWidget(_selectedDrawerIndex),
          body: Scaffold(
            /*endDrawer: new AppDrawerNotify(
              ItemsPerson: widget.itemsLoginStaff,
            ),*/
            key: _scaffoldKey,
            body: _getDrawerItemWidget(_selectedDrawerIndex),
          )),
    );
  }
}
