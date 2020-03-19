import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix1;
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/future/check_evidence_future.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_list.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_main.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_evidence.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/manage_evidence_future/manage_evidence_future.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_out_list.dart';
import 'package:prototype_app_pang/main_menu/stock/future/stock_future.dart';
import 'package:prototype_app_pang/main_menu/stock/model/balance.dart';
import 'package:prototype_app_pang/main_menu/stock/model/balance_detail.dart';
import 'package:prototype_app_pang/main_menu/stock/model/balance_type.dart';
import 'package:prototype_app_pang/main_menu/stock/model/evidence_count_balance.dart';
import 'package:prototype_app_pang/main_menu/stock/model/evidence_count_warehouse.dart';
import 'package:prototype_app_pang/main_menu/stock/model/stock_future.dart';
import 'package:prototype_app_pang/main_menu/stock/model/stock_list.dart';
import 'package:prototype_app_pang/main_menu/stock/model/stock_list_history.dart';
import 'package:prototype_app_pang/main_menu/stock/model/stock_main.dart';
import 'package:prototype_app_pang/main_menu/stock/model/test/test_stock_main.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_screen.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_history_list.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class StockFragment extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  StockFragment({
    Key key,
    @required this.ItemsPerson,
  }) : super(key: key);

  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<StockFragment> {
  @override
  void initState() {
    super.initState();
  }

  //style content
  TextStyle textStyleLanding = Styles.textStyleLanding;
  TextStyle textStyleLabel = Styles.textStyleLabel;
  TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400], fontFamily: FontStyles().FontFamily, fontSize: 12.0);
  TextStyle textStyleDataSub = TextStyle(fontSize: 16, fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleButtonAccept = Styles.textStyleButtonAccept;
  TextStyle textStyleButtonNotAccept = TextStyle(fontSize: 16, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);

  TextStyle textDataStyle = TextStyle(fontSize: 18.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textDataSubStyle = TextStyle(fontSize: 18.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textLabelHeadStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);

  //item data
  List<ItemsEvidenceMain> itemsEvidenceMain = [];

  //String OFFICE_NAME = 'สำนักงานสรรพสามิตพื้นที่พะเยา สาขาปง';
  List<ItemsWarehouseList> _itemMains = [];
  List<Items_Test_StockMain> itemMain = [];

  ItemsEvidenceCountWareHouse itemsEvidenceCountWareHouse;

  Future<bool> onLoadActionEvidenceWareHouse(int WAREHOUSE_ID) async {
    Map map = {
      "OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE,
      "WAREHOUSE_ID": WAREHOUSE_ID
      /*"OFFICE_CODE": "080701",
      "WAREHOUSE_ID": "1"*/
    };
    print(map);

    await new StockFuture().apiRequestEvidenceAccountWarehoustgetByCon(map).then((onValue) {
      itemsEvidenceCountWareHouse = onValue;
      print(onValue.KEEP);
    });

    setState(() {});
    return true;
  }

  _navigat_warehouse(mContext, int WAREHOUSE_ID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionEvidenceWareHouse(WAREHOUSE_ID);
    Navigator.pop(context);
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StockMainScreenFragment(
            Title: "ประวัติการทำรายการ",
            itemsEvidenceCountWareHouse: itemsEvidenceCountWareHouse,
            ItemsPerson: widget.ItemsPerson,
            IsPreview: false,
            IsCreate: true,
            IsUpdate: false,
          ),
        ));
  }

  Widget _buildContent(BuildContext context) {
    Map map = {"WAREHOUSE_TYPE": "", "WAREHOUSE_NAME": "", "OFFICE_NAME": "", "IS_ACTIVE": "1"};
    return FutureBuilder<ItemsWarehouseCase>(
        future: new WarehouseFuture().apiWarehousegetByConAdv(map),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _itemMains = [];
            List<int> _ids = [];

            itemsEvidenceMain.forEach((item) {
              item.EvidenceInItem.forEach((itm) {
                itm.EvidenceOutStockBalance.forEach((it) {
                  for (int i = 0; i < snapshot.data.RESPONSE_DATA.length; i++) {
                    if (it.WAREHOUSE_ID == snapshot.data.RESPONSE_DATA[i].WAREHOUSE_ID) {
                      _ids.add(snapshot.data.RESPONSE_DATA[i].WAREHOUSE_ID);
                      break;
                    }
                  }
                });
              });
            });
            var distinctIds = _ids.toSet().toList();
            distinctIds.forEach((item) {
              for (int i = 0; i < snapshot.data.RESPONSE_DATA.length; i++) {
                if (item == snapshot.data.RESPONSE_DATA[i].WAREHOUSE_ID) {
                  _itemMains.add(snapshot.data.RESPONSE_DATA[i]);
                  break;
                }
              }
            });

            itemMain = [];
            for (int index = 0; index < _itemMains.length; index++) {
              itemMain.add(new Items_Test_StockMain(_itemMains[index].WAREHOUSE_NAME, _itemMains[index].WAREHOUSE_ID));
            }
            _itemMains = snapshot.data.RESPONSE_DATA;
            for (int index = 0; index < _itemMains.length; index++) {
              itemMain.add(new Items_Test_StockMain(_itemMains[index].WAREHOUSE_NAME, _itemMains[index].WAREHOUSE_ID));
            }
            return itemMain.length != 0
                ? ListView.builder(
                    itemCount: itemMain.length /*itemMain_1.length*/,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        //padding: EdgeInsets.only(top: 2, bottom: 2),
                        child: Container(
                          padding: EdgeInsets.all(18.0),
                          decoration: BoxDecoration(shape: BoxShape.rectangle, border: index == 0 ? Border(top: BorderSide(color: Colors.grey[300], width: 1.0), bottom: BorderSide(color: Colors.grey[300], width: 1.0)) : Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))),
                          child: ListTile(
                              leading: Padding(
                                padding: paddingLabel,
                                child: Text(
                                  (index + 1).toString() + '. ',
                                  style: textInputStyleTitle,
                                ),
                              ),
                              title: Padding(
                                padding: paddingLabel,
                                child: Text(
                                  itemMain[index].StockName,
                                  style: textInputStyleTitle,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey[300],
                                size: 18.0,
                              ),
                              onTap: () {
                                _navigat_warehouse(context, itemMain[index].StockID);
                                /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StockMainScreenFragment(
                                        ItemsstockMain: itemMain[index],
                                        IsPreview: false,
                                        IsCreate: true,
                                        IsUpdate: false,
                                        Title: itemMain[index].StockName,
                                      ),
                                ));*/
                              }),
                        ),
                      );
                    })
                : Stack(
                    children: <Widget>[
                      new Center(
                        child: new Container(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "ไม่พบข้อมูล",
                                style: TextStyle(fontSize: 20.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
  }

  //Count Balance Stock
  Future<ItemsEvidenceCountBalance> onLoadActionStockBalance() async {
    ItemsEvidenceCountBalance itemEvidenceCountBalance;
    Map map = {
      "OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE,
    };
    await new StockFuture().apiRequestEvidenceAccountgetByCon(map).then((onValue) {
      itemEvidenceCountBalance = onValue;
    });

    setState(() {});
    return itemEvidenceCountBalance;
  }

  //Count Item History
  List<ItemsEvidenceList> itemsEvidenceInList = [];
  List<ItemsEvidenceOutList> itemsEvidenceOutList = [];
  List<ItemsStockHistoryList> itemMainsHis = [];

  List ItemsAll = [];

  Future<bool> onLoadActionHist() async {
    itemMainsHis = [];
    itemsEvidenceInList = [];
    itemsEvidenceOutList = [];

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
    return true;
  }

  //

  _navigat_his(mContext) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionHist();
    Navigator.pop(context);
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StockHistoryFragment(
            Title: "ประวัติการทำรายการ",
            Items: itemMainsHis,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return new Scaffold(
        body: Stack(
      children: <Widget>[
        BackgroundContent(),
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 22, left: 22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        _navigat_his(context);
                      },
                      child: Text('ประวัติการทำรายการ', style: textLabelStyle),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Container(
                width: width,
                padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 22.0, right: 22.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border(
                      top: BorderSide(color: Colors.grey[500], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[500], width: 1.0),
                      left: BorderSide(color: Colors.grey[500], width: 1.0),
                      right: BorderSide(color: Colors.grey[500], width: 1.0),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 22.0, bottom: 4.0),
                              child: Text(
                                "ของกลางทั้งหมด",
                                style: textLabelStyle,
                              )),
                        ],
                      ),
                      FutureBuilder<ItemsEvidenceCountBalance>(
                          future: onLoadActionStockBalance(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                  padding: EdgeInsets.only(top: 22.0, bottom: 4.0),
                                  child: Text(
                                    snapshot.data.BALANCE_QTY.toString(),
                                    style: textDataStyle,
                                  ));
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }

                            return Center(
                              child: CupertinoActivityIndicator(),
                            );
                          }),
                      Padding(
                          padding: EdgeInsets.only(top: 22.0, bottom: 4.0),
                          child: Text(
                            "รายการ",
                            style: textDataSubStyle,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: _buildContent(context),
            ),
          ],
        ),
      ],
    ));
  }
}
