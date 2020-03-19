import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_evidence.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_list_screen.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

import 'future/stock_future.dart';
import 'model/evidence_count_warehouse.dart';
import 'model/evidence_product_list.dart';
import 'model/test/evidence_list_name.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class StockMainScreenFragment extends StatefulWidget {
  ItemsEvidenceCountWareHouse itemsEvidenceCountWareHouse;
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  bool IsUpdate;
  bool IsPreview;
  bool IsCreate;
  String Title;
  StockMainScreenFragment({
    Key key,
    @required this.itemsEvidenceCountWareHouse,
    @required this.IsUpdate,
    @required this.IsPreview,
    @required this.IsCreate,
    @required this.Title,
    @required this.ItemsPerson,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

const double _kPickerSheetHeight = 216.0;

class _FragmentState extends State<StockMainScreenFragment> with TickerProviderStateMixin {
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'ของกลางคงเหลือ'),
    Choice(title: 'รายงาน'),
  ];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete),
  ];

  List<ItemsDestroyEvidence> itemEvidence = [];

  //item หลักทั้งหมด
  ItemsEvidenceCountWareHouse itemMain;
  //ประเภททั้งหมด
  List<ItemsEvidenceListMain> itemsType = [];

  TextStyle textDataStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textDataSubStyle = TextStyle(fontSize: 14.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 14.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textLabelHeadStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);

  //paffing
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  EdgeInsets paddingInputBoxSub = EdgeInsets.only(top: 8.0, bottom: 8.0);

  var dateFormatDate, dateFormatTime;
  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');

    itemMain = widget.itemsEvidenceCountWareHouse;
    itemsType = [
      new ItemsEvidenceListMain(EVIDENCE_TYPE_NAME: "คืนของกลาง", EVIDENCE_TYPE_SHORT_NAME: "รอคืน", BALANCE_QTY: itemMain.INSIDE, WAREHOUSE_ID: 0, EVIDENCE_OUT_TYPE: 1),
      new ItemsEvidenceListMain(EVIDENCE_TYPE_NAME: "ทำลายของกลาง", EVIDENCE_TYPE_SHORT_NAME: "รอทำลาย", BALANCE_QTY: itemMain.DESTROY, WAREHOUSE_ID: 0, EVIDENCE_OUT_TYPE: 4),
      new ItemsEvidenceListMain(EVIDENCE_TYPE_NAME: "ขายทอดตลาด", EVIDENCE_TYPE_SHORT_NAME: "รอขาย", BALANCE_QTY: itemMain.SELL, WAREHOUSE_ID: 0, EVIDENCE_OUT_TYPE: 3),
      new ItemsEvidenceListMain(EVIDENCE_TYPE_NAME: "ยืมของกลาง", EVIDENCE_TYPE_SHORT_NAME: "รอยืม", BALANCE_QTY: itemMain.LEND, WAREHOUSE_ID: 0, EVIDENCE_OUT_TYPE: 5),
      new ItemsEvidenceListMain(EVIDENCE_TYPE_NAME: "จัดเก็บเข้าพิพิธภัณฑ์", EVIDENCE_TYPE_SHORT_NAME: "รอเก็บเข้าพิพิธภัณฑ์", BALANCE_QTY: itemMain.KEEP, WAREHOUSE_ID: 0, EVIDENCE_OUT_TYPE: 2),
      new ItemsEvidenceListMain(EVIDENCE_TYPE_NAME: "บริจาคของกลาง", EVIDENCE_TYPE_SHORT_NAME: "รอบริจาค", BALANCE_QTY: itemMain.DONATE, WAREHOUSE_ID: 0, EVIDENCE_OUT_TYPE: 6),
      new ItemsEvidenceListMain(EVIDENCE_TYPE_NAME: "โอนย้ายของกลาง", EVIDENCE_TYPE_SHORT_NAME: "รอโอนย้าย", BALANCE_QTY: itemMain.TRANSFER, WAREHOUSE_ID: 0, EVIDENCE_OUT_TYPE: 7)
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54, fontFamily: FontStyles().FontFamily);
    TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    TextStyle appBarStylePay = TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: FontStyles().FontFamily);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () {
        setState(() {
          if (_onSaved) {
            if (_onEdited) {
              _onEdited = false;
              _onSaved = false;
            } else {
              Navigator.pop(context);
              //Navigator.pop(context, itemMain);
            }
          } else {
            Navigator.pop(context);
            //Navigator.pop(context, itemMain);
          }
        });
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: new Text(
              widget.Title,
              style: appBarStyle,
            ),
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context, "Back");
                }),
          ),
          body: Stack(
            children: <Widget>[
              BackgroundContent(),
              _buildContent_tab_1(),
            ],
          )),
    );
  }

  List<ItemsEvidenceProductList> itemsEvidenceProductList = [];
  Future<bool> onLoadActionEvidenceProduct(int WAREHOUSE_ID, int EVIDENCE_TYPE) async {
    Map map = {"OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE, "WAREHOUSE_ID": WAREHOUSE_ID, "EVIDENCE_OUT_TYPE": EVIDENCE_TYPE};
    print(map);
    await new StockFuture().apiRequestEvidenceAccountProductgetByCon(map).then((onValue) {
      itemsEvidenceProductList = onValue;
    });

    setState(() {});
    return true;
  }

  _navigat_product(mContext, ItemsEvidenceListMain listMain) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionEvidenceProduct(listMain.WAREHOUSE_ID, listMain.EVIDENCE_OUT_TYPE);
    Navigator.pop(context);
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StockListScreenFragment(
            Title: listMain.EVIDENCE_TYPE_NAME,
            itemsEvidenceProductList: itemsEvidenceProductList,
            itemsEvidenceListMain: listMain,
          ),
        ));
  }

  //************************start_tab_1*****************************
  Widget _buildContent_tab_1() {
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery.of(context).size;
      final double Width = (size.width * 90) / 100;
      Widget _buildLine = Container(
        padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
        width: Width,
        height: 1.0,
        color: Colors.grey[700],
      );
      return Container(
        padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 12.0, bottom: 22.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ของกลางรอดำเนินการ",
                          style: textLabelHeadStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: GestureDetector(
                    onTap: () {
                      if (itemsType[index].BALANCE_QTY <= 0) {
                        new EmptyDialog(context, "ไม่มีรายการ" + itemsType[index].EVIDENCE_TYPE_SHORT_NAME.toString());
                      } else {
                        _navigat_product(context, itemsType[index]);
                      }
                    },
                    child: Container(
                      width: size.width / 2.3,
                      /*padding: EdgeInsets.only(
                            top: 4.0, bottom: 12.0, left: 22.0, right: 22.0),*/
                      decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey[500], width: 1.0),
                            bottom: BorderSide(color: Colors.grey[500], width: 1.0),
                            left: BorderSide(color: Colors.grey[500], width: 1.0),
                            right: BorderSide(color: Colors.grey[500], width: 1.0),
                          ),
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  itemsType[index].EVIDENCE_TYPE_NAME,
                                  style: textLabelStyle,
                                )),
                          ),
                          Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                itemsType[index].BALANCE_QTY.toString(),
                                style: textDataStyle,
                              )),
                          Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "รายการ",
                                style: textDataSubStyle,
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: itemsType.length,
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
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
    );
  }
//************************end_tab_1*******************************

}
