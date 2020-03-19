import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/check_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/future/check_evidence_future.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_arrest.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_list.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_main.dart';
import 'package:prototype_app_pang/main_menu/prove/future/prove_future.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_arrest.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_arrest_product.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_indicment_product.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class CheckEvidenceFragment extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  ItemsMasWarehouseResponse itemsMasWarehouse;
  CheckEvidenceFragment({
    Key key,
    @required this.ItemsPerson,
    @required this.itemsMasProductSize,
    @required this.itemsMasProductUnit,
    @required this.itemsMasWarehouse,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<CheckEvidenceFragment> with TickerProviderStateMixin {
  //style content
  TextStyle textStyleLanding = Styles.textStyleLanding;
  TextStyle textStyleLabel = Styles.textStyleLabel;
  TextStyle textStyleData = Styles.textStyleData;
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400], fontFamily: FontStyles().FontFamily, fontSize: 12.0);

  TextStyle textStyleFloatingBtn = TextStyle(color: Colors.black, fontFamily: FontStyles().FontFamily, fontSize: 16.0);

  TextStyle textStyleAdd = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleDataSub = TextStyle(fontSize: 16, fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleButtonAccept = Styles.textStyleButtonAccept;
  TextStyle textStyleButtonNotAccept = TextStyle(fontSize: 16, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);

  int _angle = 90;
  bool _isRotated = true;

  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _animation2;
  Animation<double> _animation3;

  List<ItemsEvidenceList> itemMain = [];

  var dateFormatDate, dateFormatTime;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _animation = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 1.0, curve: Curves.linear),
    );

    _animation2 = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.5, 1.0, curve: Curves.linear),
    );

    _animation3 = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.8, 1.0, curve: Curves.linear),
    );
    _controller.reverse();
  } //item data

  void _rotate() {
    setState(() {
      if (_isRotated) {
        _angle = 45;
        _isRotated = false;
        _controller.forward();
      } else {
        _angle = 90;
        _isRotated = true;
        _controller.reverse();
      }
    });
  }

  String _convertDate(String sDate) {
    String result;
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    result = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

    return result;
  }

  String _convertTime(String sDate) {
    DateTime dt = DateTime.parse(sDate);
    String result = "เวลา " + dateFormatTime.format(dt).toString();
    return result;
  }

  String _convertYear(String sDate) {
    String year = (int.parse(sDate) + 543).toString();
    return year;
  }

  Widget _buildContent(BuildContext context) {
    return ListView.builder(
      itemCount: itemMain.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        String person, textButton, staff_name = "", label = "";
        String data_number = "", data_person = "";
        if (itemMain[index].EVIDENCE_IN_TYPE == 0) {
          String prefix = "";
          if (itemMain[index].PROVE_IS_OUTSIDE == 1) {
            prefix = "น. ";
          }

          label = "ทะเบียนตรวจพิสูจน์";
          person = "ผู้นำส่ง";
          textButton = "ตรวจรับภายใน";
          data_number = prefix + itemMain[index].PROVE_NO.toString() + "/" + _convertYear(itemMain[index].PROVE_NO_YEAR).toString();
          staff_name = "";
        } else if (itemMain[index].EVIDENCE_IN_TYPE == 1) {
          label = "เลขที่หนังสือนำส่ง";
          person = "หน่วยงาน";
          textButton = "ตรวจรับภายนอก";
        } else {
          label = "เลขที่หนังสือ";
          person = "ชื่อผู้นำออก";
          textButton = "ตรวจรับจากการนำออก";
        }

        itemMain[index].EvidenceInStaff.forEach((item) {
          staff_name = item.TITLE_SHORT_NAME_TH.toString() + item.FIRST_NAME + " " + item.LAST_NAME;
        });

        return Padding(
          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
          child: Container(
            padding: EdgeInsets.only(left: 18.0, top: 18.0, bottom: 18.0, right: 8.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        label,
                        style: textStyleLabel,
                      ),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        /*itemMain[index].DELIVERY_NO + "/" +
                          _convertYear(itemMain[index].DELIVERY_DATE)*/
                        data_number,
                        style: textStyleData,
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ผู้นำส่ง",
                        style: textStyleLabel,
                      ),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        get_staff_name(itemMain[index].EvidenceInStaff, 59) != null ? get_staff_name(itemMain[index].EvidenceInStaff, 59) : "",
                        style: textStyleData,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: new Card(
                          color: Color(0xff087de1),
                          shape: new RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                          elevation: 0.0,
                          child: Container(
                              width: 155.0,
                              child: Center(
                                child: MaterialButton(
                                  onPressed: () {
                                    _navigate(context, itemMain[index], textButton);
                                  },
                                  splashColor: Color(0xff087de1),
                                  //highlightColor: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      textButton,
                                      style: textStyleButtonAccept,
                                    ),
                                  ),
                                ),
                              ))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String get_staff_name(var Items, int CONTRIBUTOR_ID) {
    String name;
    Items.forEach((item) {
      if (item.CONTRIBUTOR_ID == CONTRIBUTOR_ID) {
        name = item.TITLE_SHORT_NAME_TH + item.FIRST_NAME + " " + item.LAST_NAME;
      }
    });
    return name;
  }

  ItemsEvidenceArrest itemsEvidenceArrest;
  ItemsEvidenceMain itemsEvidenceMain;

  ItemsProveArrest itemsProveArrest;
  List<ItemsProveArrestIndicmentProduct> _listProveIndicmentProduct = [];
  List<ItemsProveArrestProduct> _listItemsProveArrestProduct = [];

  Future<bool> onLoadAction(ItemsEvidenceList itemsMain) async {
    Map map = {"PROVE_ID": itemsMain.PROVE_ID};
    print(map);
    await new CheckEvidenceFuture().apiRequestEvidenceInArrestgetByProveID(map).then((onValue) {
      if (onValue.length > 0) {
        itemsEvidenceArrest = onValue.first;
      }
    });

    if (itemsMain.EVIDENCE_IN_TYPE == 0) {
      map = {"EVIDENCE_IN_ID": itemsMain.EVIDENCE_IN_ID, "PROVE_ID": itemsMain.PROVE_ID};
      await new CheckEvidenceFuture().apiRequestEvidenceIngetByCon(map).then((onValue) {
        itemsEvidenceMain = onValue;
      });
    }

    map = {
      "LAWSUIT_ID": itemsEvidenceArrest.LAWSUIT_ID // id คดี
    };
    await new ProveFuture().apiRequestProveArrestgetByCon(map).then((onValue) {
      itemsProveArrest = onValue.first;
    });
    map = {
      "INDICTMENT_ID": itemsProveArrest.INDICTMENT_ID // id คำฟ้อง
    };
    await new ProveFuture().apiRequestProveArrestIndictmentProductgetByCon(map) // พิสูจน์การจำกุมคำฟ้องสินค้า
        .then((onValue) {
      _listProveIndicmentProduct = onValue;
    });
    _listItemsProveArrestProduct = [];
    for (int i = 0; i < _listProveIndicmentProduct.length; i++) {
      Map map = {"PRODUCT_ID": _listProveIndicmentProduct[i].PRODUCT_ID};
      await new ProveFuture().apiRequestProveArrestProductgetByCon(map).then((onValue) {
        _listItemsProveArrestProduct.add(onValue);
      });
    }

    setState(() {});
    return true;
  }

  _navigate(BuildContext context, ItemsEvidenceList itemsMain, String title) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadAction(itemsMain);
    Navigator.pop(context);

    if (itemsEvidenceArrest != null) {
      print("itemsEvidenceArrest : " + itemsEvidenceArrest.LAWSUIT_NO);
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CheckEvidenceMainScreenFragment(
                  itemsEvidenceMain: itemsEvidenceMain,
                  ItemsPerson: widget.ItemsPerson,
                  itemsEvidenceArrest: itemsEvidenceArrest,
                  title: title,
                  IsCreate: true,
                  IsPreview: false,
                  IsUpdate: false,
                  EVIDENCE_TYPE: itemsMain.EVIDENCE_IN_TYPE,
                  itemsMasProductUnit: widget.itemsMasProductUnit,
                  itemsMasProductSize: widget.itemsMasProductSize,
                  itemsProveArrestProduct: _listItemsProveArrestProduct,
                  itemsMasWarehouse: widget.itemsMasWarehouse,
                )),
      );
      if (result.toString() != "Back") {
        itemMain = result;
      }
    }
  }

  _navigateCreate(BuildContext context, int EVIDENCE_TYPE, String title) async {
    final result = await Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => CheckEvidenceMainScreenFragment(
              ItemsPerson: widget.ItemsPerson,
              IsPreview: false,
              IsUpdate: false,
              title: title,
              IsCreate: true,
              EVIDENCE_TYPE: EVIDENCE_TYPE,
              itemsMasProductUnit: widget.itemsMasProductUnit,
              itemsMasProductSize: widget.itemsMasProductSize,
              itemsMasWarehouse: widget.itemsMasWarehouse,
            )));
  }

  Future<List<ItemsEvidenceList>> onLoadActionTestList() async {
    Map map_evidence = {
      "ACCOUNT_OFFICE_CODE": "",
      "DELIVERY_DATE_START": "",
      "DELIVERY_DATE_TO": "",
      "DELIVERY_NO": "",
      "DELIVER_NAME": "",
      "DELIVER_OFFICE_NAME": "",
      "EVIDENCE_IN_CODE": "",
      "EVIDENCE_IN_DATE_START": "",
      "EVIDENCE_IN_DATE_TO": "",
      "EVIDENCE_IN_TYPE": 0,
      "IS_RECEIVE": 0,
      "RECEIVER_NAME": "",
      "OPERATION_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE
    };
    List<ItemsEvidenceList> items_evidence = [];
    await new CheckEvidenceFuture().apiRequestEvidenceInListgetByConAdv(map_evidence).then((onValue) {
      List<ItemsEvidenceList> items = [];
      onValue.forEach((item) {
        if (item.IS_RECEIVE == 0) {
          items.add(item);
        }
      });
      items_evidence = items;
    });

    for (int i = 0; i < items_evidence.length; i++) {
      if (items_evidence[i].PROVE_ID != 0 || items_evidence[i].PROVE_ID != null) {
        Map map = {"PROVE_ID": items_evidence[i].PROVE_ID};
        await new ProveFuture().apiRequestProvegetByCon(map).then((onValue) {
          items_evidence[i].PROVE_NO = onValue.PROVE_NO;
          items_evidence[i].PROVE_NO_YEAR = onValue.PROVE_NO_YEAR;
          items_evidence[i].PROVE_IS_OUTSIDE = onValue.IS_OUTSIDE;
        });
      }
    }
    return items_evidence;
  }

  @override
  Widget build(BuildContext context) {
    Map map = {
      "ACCOUNT_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE,
      "DELIVERY_DATE_START": "",
      "DELIVERY_DATE_TO": "",
      "DELIVERY_NO": "",
      "DELIVER_NAME": "",
      "DELIVER_OFFICE_NAME": "",
      "EVIDENCE_IN_CODE": "",
      "EVIDENCE_IN_DATE_START": "",
      "EVIDENCE_IN_DATE_TO": "",
      "EVIDENCE_IN_TYPE": 0,
      "IS_RECEIVE": 0,
      "RECEIVER_NAME": "",
      "RECEIVER_OFFICE_NAME": widget.ItemsPerson.OPERATION_OFFICE_CODE,
    };
    return FutureBuilder<List<ItemsEvidenceList>>(
      //future: new CheckEvidenceFuture().apiRequestEvidenceInListgetByConAdv(map),
      future: onLoadActionTestList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //itemMain = snapshot.data;
          List<ItemsEvidenceList> items = [];
          snapshot.data.forEach((f) {
            if (f.IS_RECEIVE == 0) {
              items.add(f);
            }
          });
          print("test");

          itemMain = items;
          return new Scaffold(
            body: Stack(
              children: <Widget>[
                BackgroundContent(),
                Center(
                  child: itemMain.length != 0
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                top: BorderSide(color: Colors.grey[300], width: 1.0),
                              )),
                            ),
                            Expanded(
                              child: _buildContent(context),
                            ),
                          ],
                        )
                      : Stack(
                          children: <Widget>[
                            new Center(
                                child: new Container(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "ไม่มีรายการตรวจรับของกลาง",
                                    style: TextStyle(fontSize: 20.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                ),
                new Positioned(
                    bottom: 148.0,
                    right: 20.0,
                    child: new Container(
                      child: new Row(
                        children: <Widget>[
                          new ScaleTransition(
                            scale: _animation2,
                            alignment: FractionalOffset.center,
                            child: new Container(
                              margin: new EdgeInsets.only(right: 16.0),
                              child: new Text('ตรวจรับจากหน่วยงานภายนอก', style: textStyleFloatingBtn),
                            ),
                          ),
                          new ScaleTransition(
                            scale: _animation2,
                            alignment: FractionalOffset.center,
                            child: new Material(
                                color: new Color(0xff5887f9),
                                type: MaterialType.circle,
                                elevation: 6.0,
                                child: new GestureDetector(
                                  child: new Container(
                                      width: 50.0,
                                      height: 50.0,
                                      child: new InkWell(
                                        onTap: () {
                                          if (_angle == 45.0) {
                                            _rotate();
                                            Navigator.of(context).push(new MaterialPageRoute(
                                                builder: (context) => CheckEvidenceMainScreenFragment(
                                                      IsPreview: false,
                                                      IsUpdate: false,
                                                      title: "ตรวจรับจากหน่วยงานภายนอก",
                                                      IsCreate: true,
                                                      itemsMasProductUnit: widget.itemsMasProductUnit,
                                                      itemsMasProductSize: widget.itemsMasProductSize,
                                                      itemsMasWarehouse: widget.itemsMasWarehouse,
                                                    )));
                                          }
                                        },
                                        child: new Center(
                                          child: new Icon(
                                            Icons.add,
                                            color: new Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      )),
                                )),
                          ),
                        ],
                      ),
                    )),
                new Positioned(
                    bottom: 88.0,
                    right: 20.0,
                    child: new Container(
                      child: new Row(
                        children: <Widget>[
                          new ScaleTransition(
                            scale: _animation,
                            alignment: FractionalOffset.center,
                            child: new Container(
                              margin: new EdgeInsets.only(right: 16.0),
                              child: new Text('ตรวจรับจากการนำออกไปใช้ในราชการ', style: textStyleFloatingBtn),
                            ),
                          ),
                          new ScaleTransition(
                            scale: _animation,
                            alignment: FractionalOffset.center,
                            child: new Material(
                                color: new Color(0xff5887f9),
                                type: MaterialType.circle,
                                elevation: 6.0,
                                child: new GestureDetector(
                                  child: new Container(
                                      width: 50.0,
                                      height: 50.0,
                                      child: new InkWell(
                                        onTap: () {
                                          if (_angle == 45.0) {
                                            print("foo3");
                                          }
                                        },
                                        child: new Center(
                                          child: new Icon(
                                            Icons.add,
                                            color: new Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      )),
                                )),
                          ),
                        ],
                      ),
                    )),
                new Positioned(
                  bottom: 16.0,
                  right: 16.0,
                  child: new Material(
                      color: new Color(0xff087de1),
                      type: MaterialType.circle,
                      elevation: 6.0,
                      child: new GestureDetector(
                        child: new Container(
                            width: 56.0,
                            height: 56.00,
                            child: new InkWell(
                              onTap: /*_rotate*/ () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SafeArea(
                                        child: new Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                                              )),
                                              child: new ListTile(
                                                leading: new Icon(
                                                  Icons.add,
                                                  color: Color(0xff087de1),
                                                  size: 32,
                                                ),
                                                title: new Text('ตรวจรับจากหน่วยงานภายนอก', style: textStyleFloatingBtn),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  _navigateCreate(context, 3, "ตรวจรับจากหน่วยงานภายนอก");
                                                },
                                              ),
                                            ),
                                            new ListTile(
                                              leading: new Icon(
                                                Icons.add,
                                                color: Color(0xff087de1),
                                                size: 32,
                                              ),
                                              title: new Text(
                                                'ตรวจรับจากการนำออกไปใช้ในราชการ',
                                                style: textStyleFloatingBtn,
                                              ),
                                              onTap: () {
                                                Navigator.pop(context);
                                                _navigateCreate(context, 4, "ตรวจรับจากการนำออกไปใช้ในราชการ");
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: new Center(
                                  child: new RotationTransition(
                                turns: new AlwaysStoppedAnimation(_angle / 360),
                                child: new Icon(
                                  Icons.add,
                                  color: new Color(0xFFFFFFFF),
                                ),
                              )),
                            )),
                      )),
                ),
              ],
            ),
            /*bottomNavigationBar: Container(
              color: Colors.transparent,
              //padding: EdgeInsets.only(bottom: 22.0),
              height: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text('สร้างงานตรวจรับจากหน่วยงานภายนอก',
                        style: textStyleAdd),
                  ),
                  new IconButton(
                    padding: new EdgeInsets.all(0.0),
                    color: Colors.white,
                    icon: new Icon(
                        Icons.add_circle, color: Color(0xff087de1),
                        size: 65.0),
                    onPressed: () {
                      Navigator.of(context)
                          .push(
                          new MaterialPageRoute(
                              builder: (context) =>
                                  CheckEvidenceMainScreenFragment(
                                    IsPreview: false,
                                    IsUpdate: false,
                                    title: "ตรวจรับจากหน่วยงานภายนอก",
                                    IsCreate: true,
                                  )));
                    },
                  )
                ],
              ),
            ),*/
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
