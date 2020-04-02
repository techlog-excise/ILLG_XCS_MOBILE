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
  // ItemsPersonInformation ItemsData;
  ItemsOAGMasStaff ItemsData;
  ItemsMasterTitleResponse itemsTitle;
  ItemsArrestResponseGetOffice itemsOffice;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  ItemsMasWarehouseResponse itemsMasWarehouse;
  HomeScreen({
    Key key,
    @required this.ItemsData,
    @required this.itemsTitle,
    @required this.itemsOffice,
    @required this.itemsMasProductSize,
    @required this.itemsMasProductUnit,
    @required this.itemsMasWarehouse,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SetText _text = new SetText();
  final drawerItems = [
    new DrawerItem("ระบบสารสนเทศงานปราบปราม งานเปรียบเทียบปรับ งานจัดเก็บ และบริหารของกลางในคดี", null),
    new DrawerItem("บันทึกจับกุม (ส.ส. 2/39)", AssetImage("assets/icons/icon_drawer_tab1.png")),
    new DrawerItem("บันทึกรับคำกล่าวโทษ(ส.ส. 1/55)", AssetImage("assets/icons/icon_drawer_tab2.png")),
    new DrawerItem("พิสูจน์ของกลาง (ส.ส. 2/4)", AssetImage("assets/icons/icon_drawer_tab3.png")),
    new DrawerItem("เปรียบเทียบคดี", AssetImage("assets/icons/icon_drawer_tab4.png")),
    new DrawerItem("จัดการของกลาง", AssetImage("assets/icons/icon_drawer_tab5.png")),
    new DrawerItem("ทะเบียนบัญชีของกลาง", AssetImage("assets/icons/icon_drawer_tab6.png")),
    new DrawerItem("เครือข่ายผู้ต้องหา", AssetImage("assets/icons/icon_drawer_tab7.png")),
    new DrawerItem("ติดตามสถานะคดี", AssetImage("assets/icons/icon_drawer_tab8.png")),
    new DrawerItem("รายงานสถิติ", AssetImage("assets/icons/icon_drawer_tab9.png")),
    // new DrawerItem("ห้องสนทนา", AssetImage("assets/icons/icon_drawer_tab10.png")),
    new DrawerItem("มาตราฐานความผิด", AssetImage("assets/icons/icon_findlaw.png")),
    new DrawerItem("คำนวณค่าปรับ", AssetImage("assets/icons/icon_drawer_fine.png")),
    new DrawerItem("ตรวจรับของกลาง", AssetImage("assets/icons/icon_drawer_tab5_1.png")),
    new DrawerItem("ทำลายของกลาง", AssetImage("assets/icons/icon_drawer_tab5_2.png")),
    new DrawerItem("ขายทอดตลาด", AssetImage("assets/icons/icon_drawer_tab5_3.png")),
    new DrawerItem("โอนย้ายของกลาง", AssetImage("assets/icons/icon_drawer_tab5_4.png")),
    new DrawerItem("ทะเบียนบัญชีของกลาง", AssetImage("assets/icons/icon_drawer_tab6.png")),
    new DrawerItem("จัดเก็บเข้าพิพิธภัณฑ์", AssetImage("assets/icons/icon_drawer_tab5_6.png")),
    new DrawerItem("นำของกลางออกจากคลัง", AssetImage("assets/icons/icon_drawer_tab5_8.png")),
    new DrawerItem("คืนของกลาง", AssetImage("assets/icons/icon_drawer_tab5_9.png")),
    new DrawerItem("ใบแจ้งความนำจับ", AssetImage("assets/icons/icon_drawer_notice.png")),
  ];

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  //set Font
  FontStyles _fontStyles = FontStyles();
  double fontsize_drawer = 16.0;

  int _selectedDrawerIndex = 0;
  TextColors _colors = new TextColors();

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return _main_tab();
      //return new MainMenuFragment(ItemsData: widget.ItemsData,itemsTitle: widget.itemsTitle,);
      case 1:
        return new ArrestFragment(
          ItemsPerson: widget.ItemsData,
          itemsTitle: widget.itemsTitle,
          itemsMasProductSize: widget.itemsMasProductSize,
          itemsMasProductUnit: widget.itemsMasProductUnit,
        );
      case 2:
        return new LawsuitFragment(
          ItemsPerson: widget.ItemsData,
          itemsOffice: widget.itemsOffice,
          itemsMasProductSize: widget.itemsMasProductSize,
          itemsMasProductUnit: widget.itemsMasProductUnit,
        );
      case 3:
        return new ProveFragment(
          ItemsPerson: widget.ItemsData,
          itemsMasProductSize: widget.itemsMasProductSize,
          itemsMasProductUnit: widget.itemsMasProductUnit,
        );
      case 4:
        return new CompareFragment(ItemsPerson: widget.ItemsData);
      case 6:
        return new StockFragment(ItemsPerson: widget.ItemsData);
      case 7:
        return new NetworkFragment();
      case 8:
        return new TrackingFragment(ItemsData: widget.ItemsData);
      case 9:
        return new ReportMainScreenFragment();
      /*case 10:
        return new ChatFragment();*/
      case 10:
        return new FindLawScreen();
      case 11:
        return new FineScreen();
      case 12:
        return new CheckEvidenceFragment(
          ItemsPerson: widget.ItemsData,
          itemsMasProductSize: widget.itemsMasProductSize,
          itemsMasProductUnit: widget.itemsMasProductUnit,
          itemsMasWarehouse: widget.itemsMasWarehouse,
        );
      case 13:
        return new DestroyFragment(
          ItemsPerson: widget.ItemsData,
        );
      case 14:
        return new AuctionFragment(
          ItemsPerson: widget.ItemsData,
        );
      case 15:
        return new TransferFragment(
          ItemsData: widget.ItemsData,
          itemsMasWarehouse: widget.itemsMasWarehouse,
        );
      case 16:
        return new StockFragment(
          ItemsPerson: widget.ItemsData,
        );
      case 17:
        return new MusuimFragment();
      case 18:
        return new ExportFragment();
      case 19:
        return new ReturnFragment(
          ItemsPerson: widget.ItemsData,
        );
      case 20:
        return new NoticeFragment(
          ItemsPerson: widget.ItemsData,
          itemsTitle: widget.itemsTitle,
          itemsMasProductSize: widget.itemsMasProductSize,
          itemsMasProductUnit: widget.itemsMasProductUnit,
        );
      default:
        return new Text(
          drawerItems[pos].title,
          style: TextStyle(fontFamily: _fontStyles.FontFamily, fontSize: 16.0),
        );
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  //dialog
  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);

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

  void _shoLogoutAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoLogoutDialog();
      },
    );
  }

  //String PersonName="";
  @override
  void initState() {
    super.initState();
  }

  buildCollapsed() {
    //Color icon_color = Color(0xff549ee8);
    Color icon_color = Colors.white70;
    var drawerOptions = <Widget>[];
    for (var i = 11; i < 14; i++) {
      var d = drawerItems[i];
      TextStyle textStyle = TextStyle(color: i == _selectedDrawerIndex ? Colors.white : Colors.white70, fontFamily: _fontStyles.FontFamily, fontSize: fontsize_drawer);

      drawerOptions.add(new Column(
        children: <Widget>[
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
                  image: d.icon,
                  height: 35.0,
                  width: 35.0,
                  fit: BoxFit.contain,
                  color: i == _selectedDrawerIndex ? Colors.white : icon_color,
                ),
                title: new Text(
                  d.title,
                  style: textStyle,
                ),
                selected: i == _selectedDrawerIndex,
                onTap: () => _onSelectItem(i),
              ),
            ),
          ),
        ],
      ));
    }
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[new Column(children: drawerOptions)],
        ),
      ],
    );
  }

  buildExpanded() {
    //Color icon_color = Color(0xff549ee8);
    Color icon_color = Colors.white70;
    var drawerOptions = <Widget>[];
    // for (var i = 11; i < drawerItems.length; i++) {
    for (var i = 12; i < 19; i++) {
      /*if(i==11||i==14||i==15){
        var d = drawerItems[i];
        TextStyle textStyle = TextStyle(color: i == _selectedDrawerIndex
            ? Colors.white
            : Colors.white70,
            fontFamily: _fontStyles.FontFamily,
            fontSize: fontsize_drawer);

        drawerOptions.add(
            new Column(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                  //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: Container(
                    decoration: i == _selectedDrawerIndex
                        ? new BoxDecoration (
                      color: _colors.drawer_selected,
                    )
                        : null,
                    alignment: Alignment.center,
                    child: new ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 1.5),
                      leading: Image(
                        image: d.icon,
                        height: 35.0,
                        width: 35.0,
                        fit: BoxFit.contain,
                        color: i == _selectedDrawerIndex
                            ? Colors.white
                            : icon_color,
                      ),
                      title: new Text(d.title, style: textStyle,),
                      selected: i == _selectedDrawerIndex,
                      onTap: () => _onSelectItem(i),
                    ),
                  ),
                ),
              ],
            )
        );
      }*/
      var d = drawerItems[i];
      TextStyle textStyle = TextStyle(color: i == _selectedDrawerIndex ? Colors.white : Colors.white70, fontFamily: _fontStyles.FontFamily, fontSize: fontsize_drawer);

      drawerOptions.add(new Column(
        children: <Widget>[
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
                  image: d.icon,
                  height: 35.0,
                  width: 35.0,
                  fit: BoxFit.contain,
                  color: i == _selectedDrawerIndex ? Colors.white : icon_color,
                ),
                title: new Text(
                  d.title,
                  style: textStyle,
                ),
                selected: i == _selectedDrawerIndex,
                onTap: () => _onSelectItem(i),
              ),
            ),
          ),
        ],
      ));
    }
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[new Column(children: drawerOptions)],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //Color icon_color = Color(0xff549ee8);
    Color icon_color = Colors.white70;

    var drawerSubOptions = <Widget>[];
    for (var i = 12; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      TextStyle textStyle = TextStyle(color: i == _selectedDrawerIndex ? Colors.white : Colors.white70, fontFamily: _fontStyles.FontFamily, fontSize: fontsize_drawer);

      drawerSubOptions.add(new Column(
        children: <Widget>[
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
                  image: d.icon,
                  height: 35.0,
                  width: 35.0,
                  fit: BoxFit.contain,
                  color: i == _selectedDrawerIndex ? Colors.white : icon_color,
                ),
                title: new Text(
                  d.title,
                  style: textStyle,
                ),
                selected: i == _selectedDrawerIndex,
                onTap: () => _onSelectItem(i),
              ),
            ),
          ),
        ],
      ));
    }
    var drawerOptions = <Widget>[];
    String level = widget.ItemsData.OPREATION_POS_LAVEL_NAME == null ? "" : widget.ItemsData.OPREATION_POS_LAVEL_NAME.toString();
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
                      /*CircleAvatar(
                      backgroundColor: Color(0xff2e76bc),
                      child: Text('อ', style: TextStyle(
                          fontSize: 20.0, fontFamily: _fontStyles.FontFamily),),
                    ),*/
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
                                widget.ItemsData.TITLE_SHORT_NAME_TH + widget.ItemsData.FIRST_NAME + " " + widget.ItemsData.LAST_NAME,
                                style: TextStyle(fontFamily: _fontStyles.FontFamily, color: Colors.white70, fontSize: fontsize_drawer),
                              ),
                            ),
                            new Padding(
                              padding: EdgeInsets.only(top: 0), // old : 6
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      /*widget.ItemsData.OPREATION_POS_NAME == null
                                    ? "-"
                                    : widget.ItemsData.OPREATION_POS_NAME +
                                    level*/
                                      widget.ItemsData.OPREATION_POS_NAME,
                                      style: TextStyle(fontFamily: _fontStyles.FontFamily, color: Colors.white70, fontSize: 14, fontWeight: FontWeight.normal)),
                                  // style: TextStyle(fontFamily: _fontStyles.FontFamily, color: Colors.white70, fontSize: fontsize_drawer)),
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
                                    /*Text('หน่วยงาน ',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontFamily: _fontStyles.FontFamily,
                                    color: Colors.white70,
                                    fontSize: fontsize_drawer),),*/
                                    Text("" + widget.ItemsData.OPERATION_OFFICE_SHORT_NAME != null ? widget.ItemsData.OPERATION_OFFICE_SHORT_NAME.toString() : widget.ItemsData.OPERATION_OFFICE_NAME,
                                        style: TextStyle(fontFamily: _fontStyles.FontFamily, color: Colors.white70, fontSize: 14, fontWeight: FontWeight.normal)),
                                    // style: TextStyle(fontFamily: _fontStyles.FontFamily, color: Colors.white70, fontSize: fontsize_drawer)),
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

    //add menu notice
    TextStyle textStyle = TextStyle(color: drawerItems.length - 1 == _selectedDrawerIndex ? Colors.white : Colors.white70, fontFamily: _fontStyles.FontFamily, fontSize: fontsize_drawer);

    var d = drawerItems[drawerItems.length - 1];
    drawerOptions.add(
      new Container(
        padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
        //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: Container(
          decoration: drawerItems.length - 1 == _selectedDrawerIndex
              ? new BoxDecoration(
                  color: _colors.drawer_selected,
                )
              : null,
          alignment: Alignment.center,
          child: new ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.5),
            leading: Image(
              image: d.icon,
              height: 35.0,
              width: 35.0,
              fit: BoxFit.cover,
              color: drawerItems.length - 1 == _selectedDrawerIndex ? Colors.white : icon_color,
            ),
            title: new Text(
              d.title,
              style: textStyle,
            ),
            selected: drawerItems.length - 1 == _selectedDrawerIndex,
            onTap: () => _onSelectItem(drawerItems.length - 1),
          ),
        ),
      ),
    );

    for (var i = 0; i < 12; i++) {
      if (i > 0) {
        var d = drawerItems[i];
        if (i == 4 || i == 5 || i == 6 || i == 7) {
          if (i == 5) {
            drawerOptions.add(new Column(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(left: 18.0, right: 18.0),
                  child: new Container(
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                ExpandableNotifier(
                  child: Stack(
                    children: <Widget>[
                      Expandable(
                        collapsed: buildCollapsed(),
                        expanded: buildExpanded(),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Builder(builder: (context) {
                          var exp = ExpandableController.of(context);
                          return Container(
                            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                            //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                            child: IconButton(
                              icon: Icon(
                                exp.expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                //size: 18.0,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                exp.toggle();
                              },
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ],
            ));
          } else if (i == 6) {
            //
          } else if (i == 7) {
            TextStyle textStyle = TextStyle(color: i == _selectedDrawerIndex ? Colors.white : Colors.white70, fontFamily: _fontStyles.FontFamily, fontSize: fontsize_drawer);

            drawerOptions.add(new Column(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(left: 18.0, right: 18.0),
                  child: new Container(
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
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
                        image: d.icon,
                        height: 35.0,
                        width: 35.0,
                        fit: BoxFit.cover,
                        color: i == _selectedDrawerIndex ? Colors.white : icon_color,
                      ),
                      title: new Text(
                        d.title,
                        style: textStyle,
                      ),
                      selected: i == _selectedDrawerIndex,
                      onTap: () => _onSelectItem(i),
                    ),
                  ),
                ),
              ],
            ));
          } else {
            TextStyle textStyle = TextStyle(color: i == _selectedDrawerIndex ? Colors.white : Colors.white70, fontFamily: _fontStyles.FontFamily, fontSize: fontsize_drawer);

            drawerOptions.add(new Column(
              children: <Widget>[
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
                        image: d.icon,
                        height: 35.0,
                        width: 35.0,
                        fit: BoxFit.cover,
                        color: i == _selectedDrawerIndex ? Colors.white : icon_color,
                      ),
                      title: new Text(
                        d.title,
                        style: textStyle,
                      ),
                      selected: i == _selectedDrawerIndex,
                      onTap: () => _onSelectItem(i),
                    ),
                  ),
                ),
              ],
            ));
          }
        } else {
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
                    image: d.icon,
                    height: 35.0,
                    width: 35.0,
                    fit: BoxFit.cover,
                    color: i == _selectedDrawerIndex ? Colors.white : icon_color,
                  ),
                  title: new Text(
                    d.title,
                    style: textStyle,
                  ),
                  selected: i == _selectedDrawerIndex,
                  onTap: () => _onSelectItem(i),
                ),
              ),
            ),
          );
        }
      }
    }

    return WillPopScope(
      onWillPop: () {
        //
      },
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
              _selectedDrawerIndex == 0 || _selectedDrawerIndex == 10 || _selectedDrawerIndex == 11 // ปิดปุ่มค้นหาหน้ามาตราฐานความผิด
                  ? Container()
                  : new IconButton(
                      icon: _selectedDrawerIndex == 6 || _selectedDrawerIndex == 15
                          ? /*new Icon(Icons.notifications, color: Colors.white,)*/
                          Badge(
                              badgeContent: Text(
                                '',
                                style: TextStyle(fontFamily: FontStyles().FontFamily, color: Colors.white),
                              ),
                              child: Icon(Icons.notifications),
                            )
                          : new Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                      tooltip: _selectedDrawerIndex == 6 || _selectedDrawerIndex == 15 ? 'Notifications' : 'Search',
                      onPressed: () {
                        switch (_selectedDrawerIndex) {
                          case 20:
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => NoticeMainScreenFragmentSearch(
                                      ItemsPerson: widget.ItemsData,
                                      itemsTitle: widget.itemsTitle,
                                      itemsMasProductSize: widget.itemsMasProductSize,
                                      itemsMasProductUnit: widget.itemsMasProductUnit,
                                    )));
                            break;
                          case 1:
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => ArrestMainScreenFragmentSearch(
                                      ItemsData: widget.ItemsData,
                                      // ItemsProductGroup: itemsProductGroup,
                                      itemsTitle: widget.itemsTitle,
                                      itemsMasProductSize: widget.itemsMasProductSize,
                                      itemsMasProductUnit: widget.itemsMasProductUnit,
                                    )));
                            break;
                          case 2:
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => LawsuitMainScreenFragmentSearch2(
                                      ItemsPerson: widget.ItemsData,
                                      itemsOffice: widget.itemsOffice,
                                      itemsMasProductSize: widget.itemsMasProductSize,
                                      itemsMasProductUnit: widget.itemsMasProductUnit,
                                    )));
                            /*LawsuitMainScreenFragmentSearch(
                            ItemsPerson: widget.ItemsData,
                          )));*/
                            break;
                          case 3:
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => ProveMainScreenFragmentSearch2(
                                      ItemsPerson: widget.ItemsData,
                                      itemsMasProductSize: widget.itemsMasProductSize,
                                      itemsMasProductUnit: widget.itemsMasProductUnit,
                                    )));
                            break;
                          case 4:
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => CompareMainScreenFragmentSearch2(
                                      ItemsPerson: widget.ItemsData,
                                    )));
                            break;
                          case 12:
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => CheckEvidenceMainScreenFragmentSearch2(
                                      ItemsPerson: widget.ItemsData,
                                      itemsMasProductSize: widget.itemsMasProductSize,
                                      itemsMasProductUnit: widget.itemsMasProductUnit,
                                      itemsMasWarehouse: widget.itemsMasWarehouse,
                                    )));
                            break;
                          case 13:
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => DestroyMainScreenFragmentSearch2(
                                      ItemsPerson: widget.ItemsData,
                                    )));
                            break;
                          case 14:
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => AuctionMainScreenFragmentSearch2(
                                      ItemsPerson: widget.ItemsData,
                                    )));
                            break;
                          case 15:
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => TranferMainScreenFragmentSearch2(
                                      ItemsPerson: widget.ItemsData,
                                      itemsMasWarehouse: widget.itemsMasWarehouse,
                                    )));
                            break;
                          case 6:
                            /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          StockNotifyFragment(
                            Title: "การแจ้งเตือน",
                            Items: [],
                          ),
                      ));*/
                            _scaffoldKey.currentState.openEndDrawer();

                            break;
                          case 16:
                            /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          StockNotifyFragment(
                            Title: "การแจ้งเตือน",
                            Items: [],
                          ),
                      ));*/
                            _scaffoldKey.currentState.openEndDrawer();
                            break;
                          case 17:
                            Navigator.of(context).push(new MaterialPageRoute(builder: (context) => MusuimSearchScreenFragment()));
                            break;
                          case 18:
                            Navigator.of(context).push(new MaterialPageRoute(builder: (context) => ExportSearchScreenFragment()));
                            break;
                          case 19:
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => ReturnMainScreenFragmentSearch2(
                                      ItemsPerson: widget.ItemsData,
                                    )));
                            break;
                          case 7:
                            Navigator.of(context).push(new MaterialPageRoute(builder: (context) => NetworkMainScreenFragmentSearch()));
                            break;
                          case 8:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrackingBookSearchScreenFragment(
                                    ItemsPerson: widget.ItemsData,
                                  ),
                                ));
                            break;
                          case 9:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReportMainScreenFragmentSearch(),
                                ));
                            break;
                          /*case 10 :
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new Search1()),
                    );
                    break;*/
                        }
                      },
                    ),
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
                            color: /*Color(0xff549ee8)*/ Colors.white70,
                            size: 28.0,
                          ),
                          onPressed: () {
                            _shoLogoutAlertDialog();
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
            endDrawer: new AppDrawerNotify(
              ItemsPerson: widget.ItemsData,
            ),
            key: _scaffoldKey,
            body: _getDrawerItemWidget(_selectedDrawerIndex),
          )),
    );
  }

  //int _selectedMenuIndex = 0;
  Color icon_color = Color(0xff549ee8);

  //set Font
  //FontStyles _fontStyles = FontStyles();
  TextStyle Titlestyle = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle Menustyle = TextStyle(fontSize: 14.0, fontFamily: FontStyles().FontFamily);

  Widget _main_tab() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // backgroundColor: Colors.grey[100],
      body: Stack(
        children: <Widget>[
          BackgroundContent(),
          _getMenuItemWidget(_selectedDrawerIndex),
        ],
      ),
    );
    /*Scaffold(
        backgroundColor: Colors.transparent,
        body: _getMenuItemWidget(_selectedDrawerIndex),
      );*/
  }

  _onClickMenu(index) {
    setState(() => _selectedDrawerIndex = index);
  }

  Widget _buildContent1() {
    var size = MediaQuery.of(context).size;
    return Container(
      //padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.all(12.0),
            child: new Text('งานปราบปราม', style: Titlestyle),
          ),
          new Container(
              //padding: EdgeInsets.all(8.0),
              child: Column(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: Container(
                        width: size.width / 3,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: size.width / 3,
                              child: Column(
                                children: <Widget>[
                                  FlatButton(
                                    highlightColor: TextColors().text_splash_color,
                                    onPressed: () {
                                      _onClickMenu(20);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Image(
                                        image: AssetImage("assets/icons/icon_drawer_notice.png"),
                                        height: 55.0,
                                        width: 55.0,
                                        fit: BoxFit.fitWidth,
                                        color: icon_color,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'ใบแจ้งความนำจับ',
                                    style: Menustyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // new Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 18.0),
                    //   height: size.width / 2.4,
                    //   child: new Card(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(12.0),
                    //     ),
                    //     elevation: 8,
                    //     child: Container(
                    //       width: size.width / 3,
                    //       // height: 100,
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: <Widget>[
                    //           new Container(
                    //             width: 60.0,
                    //             height: 60.0,
                    //             margin: EdgeInsets.only(top: 10.0),
                    //             decoration: new BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               color: Colors.blue,
                    //             ),
                    //             child: Align(
                    //               alignment: Alignment.center,
                    //               child: Image(
                    //                 image: AssetImage("assets/icons/icon_drawer_notice.png"),
                    //                 height: 40.0,
                    //                 width: 40.0,
                    //                 color: Colors.white,
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(height: 16),
                    //           Text(
                    //             'ใบแจ้งความนำจับ',
                    //             style: Menustyle,
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.all(12.0),
                                child: Image(
                                  image: AssetImage("assets/icons/icon_drawer_tab1.png"),
                                  height: 55.0,
                                  width: 55.0,
                                  fit: BoxFit.fitWidth,
                                  color: icon_color,
                                ),
                              ),
                            ),
                            Text(
                              'บันทึกจับกุม\n(ส.ส. 2/39)',
                              style: Menustyle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: size.width / 3,
                    ),
                  ],
                ),
              ),
            ],
          )),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: new Container(
              height: 1.5,
              color: const Color(0xffc8c8c8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent2() {
    var size = MediaQuery.of(context).size;
    return Container(
      //padding: EdgeInsets.only(left:12.0,right: 12.0,bottom: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0, top: 12.0),
            child: new Text(
              'งานส่วนคดี',
              style: Titlestyle,
            ),
          ),
          new Container(
            //padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
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
                                  _onClickMenu(2);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Image(
                                    image: AssetImage("assets/icons/icon_drawer_tab2.png"),
                                    height: 55.0,
                                    width: 55.0,
                                    fit: BoxFit.fitWidth,
                                    color: icon_color,
                                  ),
                                ),
                              ),
                              Text(
                                'บันทึกรับคำกล่าวโทษ\n(ส.ส. 1/55)',
                                style: Menustyle,
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: size.width / 3,
                                child: Column(
                                  children: <Widget>[
                                    FlatButton(
                                      highlightColor: TextColors().text_splash_color,
                                      onPressed: () {
                                        _onClickMenu(4);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Image(
                                          image: AssetImage("assets/icons/icon_drawer_tab4.png"),
                                          height: 55.0,
                                          width: 55.0,
                                          fit: BoxFit.fitWidth,
                                          color: icon_color,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'เปรียบเทียบคดี',
                                      style: Menustyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 3,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: new Container(
                    height: 1.5,
                    color: const Color(0xffc8c8c8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExpanded_menu() {
    var size = MediaQuery.of(context).size;
    return new Container(
        //padding: EdgeInsets.all(8.0),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
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
                          _onClickMenu(3);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_tab3.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.fitWidth,
                            color: icon_color,
                          ),
                        ),
                      ),
                      Text(
                        'พิสูจน์ของกลาง\n(ส.ส. 2/4)',
                        style: Menustyle,
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
                          _onClickMenu(12);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_tab5_1.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.contain,
                            color: icon_color,
                          ),
                        ),
                      ),
                      Text(
                        'ตรวจรับของกลาง',
                        style: Menustyle,
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
                          _onClickMenu(13);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_tab5_2.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.fitWidth,
                            color: icon_color,
                          ),
                        ),
                      ),
                      Text(
                        'ทำลายของกลาง',
                        style: Menustyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                            _onClickMenu(14);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Image(
                              image: AssetImage("assets/icons/icon_drawer_tab5_3.png"),
                              height: 55.0,
                              width: 55.0,
                              fit: BoxFit.fitWidth,
                              color: icon_color,
                            ),
                          ),
                        ),
                        Text(
                          'ขายทอดตลาด',
                          style: Menustyle,
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
                            _onClickMenu(15);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Image(
                              image: AssetImage("assets/icons/icon_drawer_tab5_4.png"),
                              height: 55.0,
                              width: 55.0,
                              fit: BoxFit.contain,
                              color: icon_color,
                            ),
                          ),
                        ),
                        Text(
                          'โอนย้ายของกลาง',
                          style: Menustyle,
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
                            _onClickMenu(6);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Image(
                              image: AssetImage("assets/icons/icon_drawer_tab6.png"),
                              height: 55.0,
                              width: 55.0,
                              fit: BoxFit.fitWidth,
                              color: icon_color,
                            ),
                          ),
                        ),
                        Text(
                          'ทะเบียนบัญชีของกลาง',
                          style: Menustyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
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
                      Card(
                        shape: new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 1.5), borderRadius: BorderRadius.circular(4.0)),
                        elevation: 0.0,
                        child: FlatButton(
                          highlightColor: TextColors().text_splash_color,
                          onPressed: () {
                            _onClickMenu(17);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Image(
                              image: AssetImage("assets/icons/icon_drawer_tab5_6.png"),
                              height: 55.0,
                              width: 55.0,
                              fit: BoxFit.fitWidth,
                              color: icon_color,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'จัดเก็บเข้าพิพิธภัณฑ์',
                        style: Menustyle,
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
                      Card(
                        shape: new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 1.5), borderRadius: BorderRadius.circular(4.0)),
                        elevation: 0.0,
                        child: FlatButton(
                          highlightColor: TextColors().text_splash_color,
                          onPressed: () {
                            _onClickMenu(18);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Image(
                              image: AssetImage("assets/icons/icon_drawer_tab5_8.png"),
                              height: 55.0,
                              width: 55.0,
                              fit: BoxFit.cover,
                              color: icon_color,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'นำของกลางออกจากคลัง',
                        style: Menustyle,
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
                      Card(
                        shape: new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 1.5), borderRadius: BorderRadius.circular(4.0)),
                        elevation: 0.0,
                        child: FlatButton(
                          highlightColor: TextColors().text_splash_color,
                          onPressed: () {
                            _onClickMenu(19);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Image(
                              image: AssetImage("assets/icons/icon_drawer_tab5_9.png"),
                              height: 55.0,
                              width: 55.0,
                              fit: BoxFit.fitWidth,
                              color: icon_color,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'คืนของกลาง',
                        style: Menustyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: new Container(
            height: 1.5,
            color: const Color(0xffc8c8c8),
          ),
        ),
      ],
    ));
  }

  Widget buildCollapsed_menu() {
    var size = MediaQuery.of(context).size;
    return new Container(
        //padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          _onClickMenu(3);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_tab3.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.fitWidth,
                            color: icon_color,
                          ),
                        ),
                      ),
                      Text(
                        'พิสูจน์ของกลาง\n(ส.ส. 2/4)',
                        style: Menustyle,
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
                          _onClickMenu(12);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_tab5_1.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.contain,
                            color: icon_color,
                          ),
                        ),
                      ),
                      Text(
                        'ตรวจรับของกลาง',
                        style: Menustyle,
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
                          _onClickMenu(13);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_tab5_2.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.fitWidth,
                            color: icon_color,
                          ),
                        ),
                      ),
                      Text(
                        'ทำลายของกลาง',
                        style: Menustyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: new Container(
              height: 1.5,
              color: const Color(0xffc8c8c8),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildContent3() {
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
                  child:
                      /*new Text('งานพิสูจน์และจัดการของกลาง',
                    style: Titlestyle,),*/
                      new Text(
                    'งานพิสูจน์',
                    style: Titlestyle,
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
              collapsed: buildExpanded_menu(),
              //expanded: buildCollapsed_menu(),
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
                          _onClickMenu(7);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_tab7.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.fitWidth,
                            color: icon_color,
                          ),
                        ),
                      ),
                      Text(
                        'เครือข่ายผู้ต้องหา',
                        style: Menustyle,
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
                          _onClickMenu(8);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_tab8.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.contain,
                            color: icon_color,
                          ),
                        ),
                      ),
                      Text(
                        'ติดตามสถานะ',
                        style: Menustyle,
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
                          _onClickMenu(9);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_tab9.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.fitWidth,
                            color: icon_color,
                          ),
                        ),
                      ),
                      Text(
                        'รายงานสถิติ',
                        style: Menustyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
                          _onClickMenu(10);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_findlaw.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.fitWidth,
                            color: icon_color,
                          ),
                        ),
                      ),
                      Text(
                        'มาตราฐานความผิด',
                        style: Menustyle,
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
                          _onClickMenu(11);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_fine.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.fitWidth,
                            color: icon_color,
                          ),
                        ),
                      ),
                      Text(
                        'คำนวณค่าปรับ',
                        style: Menustyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: <Widget>[
          //       new ButtonTheme(
          //         minWidth: 44.0,
          //         padding: new EdgeInsets.all(0.0),
          //         child: Container(
          //           width: size.width / 3,
          //           child: Column(
          //             children: <Widget>[
          //               FlatButton(
          //                 highlightColor: TextColors()
          //                     .text_splash_color,
          //                 onPressed: () {
          //                   _onClickMenu(10);
          //                 },
          //                 child: Padding(
          //                   padding: EdgeInsets.all(12.0),
          //                   child: Image(
          //                     image: AssetImage(
          //                         "assets/icons/icon_drawer_tab10.png"),
          //                     height: 55.0,
          //                     width: 55.0,
          //                     fit: BoxFit.fitWidth,
          //                     color: icon_color,
          //                   ),
          //                 ),
          //               ),
          //               Text(
          //                 'ห้องสนทนา',
          //                 style: Menustyle,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),

          //     ],
          //   ),
          // ),
        ],
      ),
    ));
  }

  Widget buildCollapsed_menu1() {
    var size = MediaQuery.of(context).size;
    return new Container(
        //padding: EdgeInsets.all(8.0),
        child: Column(
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
                    Card(
                      shape: new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 1.5), borderRadius: BorderRadius.circular(4.0)),
                      elevation: 0.0,
                      child: FlatButton(
                        highlightColor: TextColors().text_splash_color,
                        onPressed: () {
                          _onClickMenu(7);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_tab7.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.fitWidth,
                            color: icon_color,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'เครือข่ายผู้ต้องหา',
                      style: Menustyle,
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
                    Card(
                      shape: new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 1.5), borderRadius: BorderRadius.circular(4.0)),
                      elevation: 0.0,
                      child: FlatButton(
                        highlightColor: TextColors().text_splash_color,
                        onPressed: () {
                          _onClickMenu(8);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_tab8.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.contain,
                            color: icon_color,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'ติดตามสถานะ',
                      style: Menustyle,
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
                    Card(
                      shape: new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 1.5), borderRadius: BorderRadius.circular(4.0)),
                      elevation: 0.0,
                      child: FlatButton(
                        highlightColor: TextColors().text_splash_color,
                        onPressed: () {
                          _onClickMenu(9);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_tab9.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.contain,
                            color: icon_color,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'รายงานสถิติ',
                      style: Menustyle,
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
                    Card(
                      shape: new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 1.5), borderRadius: BorderRadius.circular(4.0)),
                      elevation: 0.0,
                      child: FlatButton(
                        highlightColor: TextColors().text_splash_color,
                        onPressed: () {
                          _onClickMenu(10);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_findlaw.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.fitWidth,
                            color: icon_color,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'มาตราฐานความผิด',
                      style: Menustyle,
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
                    Card(
                      shape: new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 1.5), borderRadius: BorderRadius.circular(4.0)),
                      elevation: 0.0,
                      child: FlatButton(
                        highlightColor: TextColors().text_splash_color,
                        onPressed: () {
                          _onClickMenu(20);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image(
                            image: AssetImage("assets/icons/icon_drawer_fine.png"),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.fitWidth,
                            color: icon_color,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'คำนวณค่าปรับ',
                      style: Menustyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: new Container(
            height: 1.5,
            color: const Color(0xffc8c8c8),
          ),
        ),
      ],
    ));
  }

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
                    style: Titlestyle,
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

  _getMenuItemWidget(int pos) {
    switch (pos) {
      case 0:
        return SafeArea(
          child: new SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _buildContent1(),
                  _buildContent2(),
                  _buildContent3(),
                  _buildContent4(),
                ],
              ),
            ),
          ),
        );
      case 1:
        return new ArrestFragment(
          ItemsPerson: widget.ItemsData,
          itemsTitle: widget.itemsTitle,
          itemsMasProductSize: widget.itemsMasProductSize,
          itemsMasProductUnit: widget.itemsMasProductUnit,
        );
      case 2:
        return new LawsuitFragment(
          ItemsPerson: widget.ItemsData,
          itemsOffice: widget.itemsOffice,
          itemsMasProductSize: widget.itemsMasProductSize,
          itemsMasProductUnit: widget.itemsMasProductUnit,
        );
      case 3:
        return new ProveFragment(
          ItemsPerson: widget.ItemsData,
          itemsMasProductSize: widget.itemsMasProductSize,
          itemsMasProductUnit: widget.itemsMasProductUnit,
        );
      case 4:
        return new CompareFragment(ItemsPerson: widget.ItemsData);
      case 6:
        return new StockFragment(
          ItemsPerson: widget.ItemsData,
        );
      case 7:
        return new NetworkFragment();
      case 8:
        return new TrackingFragment(ItemsData: widget.ItemsData);
      case 9:
        return new ReportMainScreenFragment();
      /*case 10:
        return new ChatFragment();*/
      case 10:
        return new FindLawScreen();
      case 11:
        return new FineScreen();
      case 12:
        return new CheckEvidenceFragment(
          ItemsPerson: widget.ItemsData,
          itemsMasProductSize: widget.itemsMasProductSize,
          itemsMasProductUnit: widget.itemsMasProductUnit,
          itemsMasWarehouse: widget.itemsMasWarehouse,
        );
      case 13:
        return new DestroyFragment(
          ItemsPerson: widget.ItemsData,
        );
      case 14:
        return new AuctionFragment(
          ItemsPerson: widget.ItemsData,
        );
      case 15:
        return new TransferFragment(
          ItemsData: widget.ItemsData,
          itemsMasWarehouse: widget.itemsMasWarehouse,
        );
      case 16:
        return new StockFragment(
          ItemsPerson: widget.ItemsData,
        );
      case 17:
        return new MusuimFragment();
      case 18:
        return new ExportFragment();
      case 19:
        return new ReturnFragment(
          ItemsPerson: widget.ItemsData,
        );
      case 20:
        return new NoticeFragment(
          ItemsPerson: widget.ItemsData,
          itemsTitle: widget.itemsTitle,
          itemsMasProductSize: widget.itemsMasProductSize,
          itemsMasProductUnit: widget.itemsMasProductUnit,
        );
      default:
        return new Text(
          drawerItems[pos].title,
          style: TextStyle(fontFamily: _fontStyles.FontFamily, fontSize: 16.0),
        );

      /*default:
        return new Text("Error");*/
    }
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Branch>[]]);

  final String title;
  final List<Branch> children;
}

class Branch {
  Branch(this.title, this.desc);

  final String title;
  final String desc;
}

class AppDrawerNotify extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  AppDrawerNotify({
    Key key,
    @required this.ItemsPerson,
  }) : super(key: key);
  @override
  _AppDrawerState createState() => new _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawerNotify> {
  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 14, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textDataStyle = TextStyle(fontSize: 14, color: Colors.black, fontFamily: FontStyles().FontFamily);

  //
  List<ItemsEvidenceList> itemsEvidenceInList = [];
  List<ItemsEvidenceOutList> itemsEvidenceOutList = [];
  List<ItemsStockHistoryList> itemMainsHis = [];
  List ItemsAll = [];

  Future<List<ItemsStockHistoryList>> onLoadAction() async {
    Map map = {
      "ACCOUNT_OFFICE_CODE": "",
      "DELIVERY_DATE_START": "",
      "DELIVERY_DATE_TO": "",
      "DELIVERY_NO": "",
      "DELIVER_NAME": "",
      "DELIVER_OFFICE_NAME": "",
      "EVIDENCE_IN_CODE": "",
      "EVIDENCE_IN_DATE_START": "",
      "EVIDENCE_IN_DATE_TO": "",
      "EVIDENCE_IN_TYPE": null,
      "IS_RECEIVE": 1,
      "RECEIVER_NAME": "",
      "RECEIVER_OFFICE_NAME": ""
    };
    await new CheckEvidenceFuture().apiRequestEvidenceInListgetByConAdv(map).then((onValue) {
      List<ItemsEvidenceList> _items = [];
      onValue.forEach((item) {
        if (item.EVIDENCE_IN_ID != null && item.EVIDENCE_IN_DATE != null) {
          _items.add(item);
        }
      });
      itemsEvidenceInList = _items;
    });
    map = {
      "EVIDENCE_OUT_CODE": "",
      "EVIDENCE_OUT_DATE_FROM": "",
      "EVIDENCE_OUT_DATE_TO": "",
      "EVIDENCE_OUT_NO": "",
      "EVIDENCE_OUT_NO_DATE_FROM": "",
      "EVIDENCE_OUT_NO_DATE_TO": "",
      "EVIDENCE_OUT_TYPE": "",
      "OPERATION_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE,
      "STAFF_NAME": "",
      "STAFF_OFFICE_NAME": ""
    };
    await new ManageEvidenceFuture().apiRequestEvidenceOutListgetByConAdv(map).then((onValue) {
      List<ItemsEvidenceOutList> _items = [];
      onValue.forEach((item) {
        if (item.EVIDENCE_OUT_ID != null && item.EVIDENCE_OUT_DATE != null) {
          _items.add(item);
        }
      });
      itemsEvidenceOutList = _items;
    });

    itemsEvidenceInList.forEach((f) {
      DateTime _date = f.EVIDENCE_IN_DATE != null ? DateTime.parse(f.EVIDENCE_IN_DATE) : DateTime.now();
      DateTime _date_now = DateTime.now();
      int diff = _date_now.difference(_date).inDays;
      if ((diff + 1) <= 7) {
        // วันย้อนหลัง
        itemMainsHis.add(new ItemsStockHistoryList(EVIDENCE_CODE: f.EVIDENCE_IN_CODE.toString(), EVIDENCE_ID: f.EVIDENCE_IN_ID, EVIDENCE_DATE: f.EVIDENCE_IN_DATE.toString(), EVIDENCE_OUT_TYPE: 0, PROVE_ID: f.PROVE_ID));
      }
    });

    itemsEvidenceOutList.forEach((f) {
      DateTime _date = DateTime.parse(f.EVIDENCE_OUT_DATE);
      DateTime _date_now = DateTime.now();
      int diff = _date.difference(_date_now).inDays;
      if ((diff + 1) <= 7) {
        itemMainsHis.add(new ItemsStockHistoryList(EVIDENCE_CODE: f.EVIDENCE_OUT_CODE.toString(), EVIDENCE_ID: f.EVIDENCE_OUT_ID, EVIDENCE_DATE: f.EVIDENCE_OUT_DATE.toString(), EVIDENCE_OUT_TYPE: f.EVIDENCE_OUT_TYPE == null ? 1 : f.EVIDENCE_OUT_TYPE, PROVE_ID: null));
      }
    });

    setState(() {});
    return itemMainsHis;
  }

  @override
  Widget build(BuildContext context) {
    return /**/
        FutureBuilder<List<ItemsStockHistoryList>>(
      future: onLoadAction(),
      //future: onLoadActionTestList(map),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          /*List<ItemsStockHistoryList> items=[];
            snapshot.data.forEach((item){
              if(item.LAWSUIT_ID!=0||item.LAWSUIT_NO!=null){
                if(item.LAWSUIT_NO!="0"){
                  if(item.PROVE_ID==0||item.PROVE_ID==null||item.GUILTBASE_ID!=0||item.GUILTBASE_ID!=null){
                    if(item.PROVE_TYPE==0){
                      items.add(item);
                    }
                  }
                }
              }
            });*/
          /*List<ItemsStockHistoryList> itemMain = snapshot.data;*/
          List<ItemsStockHistoryList> itemMain = [];
          //itemMain = snapshot.data;
          return new Drawer(
            child: new ListView(
              children: <Widget>[
                itemMain.length != 0
                    ? ListView.builder(
                        itemCount: itemMain.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            //padding: EdgeInsets.only(top: 2, bottom: 2),
                            child: Container(
                                padding: EdgeInsets.all(18.0),
                                decoration: BoxDecoration(shape: BoxShape.rectangle, border: index == 0 ? Border(top: BorderSide(color: Colors.grey[300], width: 1.0), bottom: BorderSide(color: Colors.grey[300], width: 1.0)) : Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: paddingLabel,
                                            child: Text(
                                              "เลขที่คืน",
                                              style: textLabelStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: paddingLabel,
                                            child: Text(
                                              "RT080020000010",
                                              style: textDataStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: paddingLabel,
                                            child: Text(
                                              "วันที่จัดเก็บเข้าพิพิธภัณฑ์",
                                              style: textLabelStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: paddingLabel,
                                            child: Text(
                                              "09 กันยายน 2562",
                                              style: textDataStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        })
                    : Stack(
                        children: <Widget>[
                          new Center(
                            child: new Container(
                              padding: EdgeInsets.only(top: 62),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "ไม่มีรายการแจ้งเตือน",
                                    style: TextStyle(fontSize: 20.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: CupertinoActivityIndicator(),
            )
          ],
        );
      },
    );
  }
}
