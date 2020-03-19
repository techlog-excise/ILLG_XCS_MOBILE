import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/prove/future/prove_future.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_arrest.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_arrest_product.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_indicment_product.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_list.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_main.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_screen.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class ProveFragment extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  //ItemsArrestResponseGetOffice itemsOffice;
  ProveFragment({
    Key key,
    @required this.ItemsPerson,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
    //@required this.itemsOffice,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<ProveFragment> {
  //style content
  TextStyle textStyleLanding = Styles.textStyleLanding;
  TextStyle textStyleLabel = Styles.textStyleLabel;
  TextStyle textStyleData = Styles.textStyleData;
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400], fontFamily: FontStyles().FontFamily, fontSize: 12.0);
  TextStyle textStyleDataSub = TextStyle(fontSize: 16, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleButtonAccept = Styles.textStyleButtonAccept;
  TextStyle textStyleButtonNotAccept = TextStyle(fontSize: 16, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  //item data

  List<ItemsProveList> itemMain = [];

  Widget _buildContent(BuildContext context) {
    return ListView.builder(
      itemCount: itemMain.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
          child: Container(
            padding: EdgeInsets.all(18.0),
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
                        "เลขที่รับคำกล่าวโทษ",
                        style: textStyleLabel,
                      ),
                    ),
                    itemMain[index].LAWSUIT_IS_OUTSIDE == 1
                        ? Padding(
                            padding: paddingData,
                            child: Text(
                              "น. " + itemMain[index].LAWSUIT_NO.toString() + "/" + (itemMain[index].LAWSUIT_NO_YEAR != null ? _convertYear(itemMain[index].LAWSUIT_NO_YEAR) : ""),
                              style: textStyleData,
                            ),
                          )
                        : Padding(
                            padding: paddingData,
                            child: Text(
                              itemMain[index].LAWSUIT_NO.toString() + "/" + (itemMain[index].LAWSUIT_NO_YEAR != null ? _convertYear(itemMain[index].LAWSUIT_NO_YEAR) : ""),
                              style: textStyleData,
                            ),
                          ),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ผู้รับคดี",
                        style: textStyleLabel,
                      ),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        itemMain[index].LAWSUIT_STAFF_NAME.toString(),
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
                              padding: EdgeInsets.only(left: 6.0, right: 6.0),
                              //width: 100.0,
                              //height: 40,
                              child: Center(
                                child: MaterialButton(
                                  onPressed: () {
                                    _navigate(context, itemMain[index].LAWSUIT_ID);
                                  },
                                  splashColor: Color(0xff087de1),
                                  //highlightColor: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      "พิสูจน์",
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

  ItemsProveArrest itemsProveArrest;
  List<ItemsProveArrestIndicmentProduct> _listProveIndicmentProduct = [];
  List<ItemsProveArrestProduct> _listItemsProveArrestProduct = [];
  Future<bool> onLoadAction(Map map) async {
    await new ProveFuture().apiRequestProveArrestgetByCon(map).then((onValue) {
      itemsProveArrest = onValue.first;
    });
    map = {"INDICTMENT_ID": itemsProveArrest.INDICTMENT_ID};
    await new ProveFuture().apiRequestProveArrestIndictmentProductgetByCon(map).then((onValue) {
      List<ItemsProveArrestIndicmentProduct> items = [];
      onValue.forEach((item) {
        if (item.PRODUCT_ID != 0) {
          items.add(item);
        }
      });

      ///_listProveIndicmentProduct = onValue;
      _listProveIndicmentProduct = items;
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

  _navigate(BuildContext context, int lawsuitID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    Map map = {"LAWSUIT_ID": lawsuitID};
    await onLoadAction(map);
    Navigator.pop(context);

    print("_listItemsProveArrestProduct : " + _listItemsProveArrestProduct.length.toString());
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProveMainScreenFragment(
                itemsProveArrest: itemsProveArrest,
                //itemsIndicmentProduct: _listProveIndicmentProduct,
                itemsProveArrestProduct: _listItemsProveArrestProduct,
                ItemsPerson: widget.ItemsPerson,
                IsCreate: true,
                IsEdit: false,
                IsPreview: false,
                itemsMasProductSize: widget.itemsMasProductSize,
                itemsMasProductUnit: widget.itemsMasProductUnit,
              )),
    );
    if (result.toString() != "Back") {
      //itemMain = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map map = {
      "PROVE_TYPE": "",
      "PROVE_NO": "",
      "PROVE_IS_OUTSIDE": "",
      "RECEIVE_DOC_DATE_FROM": "",
      "RECEIVE_DOC_DATE_TO": "",
      "RECEIVE_OFFICE_NAME": "",
      "PROVE_STAFF_NAME": "",
      "ARREST_CODE": "",
      "ARREST_DATE_FROM": "",
      "ARREST_DATE_TO": "",
      "ARREST_STAFF_NAME": "",
      "ARREST_OFFICE_NAME": "",
      "SECTION_NAME": "",
      "GUILTBASE_NAME": "",
      "LAWSUIT_NO": "",
      "LAWSUIT_IS_OUTSIDE": 1,
      "LAWSUIT_DATE_FROM": "",
      "LAWSUIT_DATE_TO": "",
      "LAWSUIT_OFFICE_NAME": "",
      "LAWSUIT_STAFF_NAME": "",
      "ACCOUNT_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE
    };

    return FutureBuilder<List<ItemsProveList>>(
      future: new ProveFuture().apiRequestProveListgetByConAdv(map),
      //future: onLoadActionTestList(map),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ItemsProveList> items = [];
          snapshot.data.forEach((item) {
            if (item.LAWSUIT_ID != 0 && item.LAWSUIT_NO != null) {
              if (item.LAWSUIT_NO != "0") {
                if ((item.PROVE_ID == 0 || item.PROVE_ID == null) && (item.GUILTBASE_ID != 0 || item.GUILTBASE_ID != null)) {
                  if (item.PROVE_TYPE == 0) {
                    items.add(item);
                  }
                }
              }
            }
          });
          itemMain = items;
          //itemMain = snapshot.data;
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
                              child: Container(
                                padding: EdgeInsets.only(right: 22.0, top: 8.0, bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      padding: paddingLabel,
                                      child: Text(
                                        'รอพิสูจน์ ' + itemMain.length.toString() + ' คดี',
                                        style: textStyleLabel,
                                      ),
                                    )
                                  ],
                                ),
                              )),
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
                                  "ไม่มีรายการพิสูจน์ของกลาง",
                                  style: TextStyle(fontSize: 20.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
              ),
            ],
          ));
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

  String _convertYear(String sDate) {
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    String year = (int.parse(splits[3]) + 543).toString();
    return year;
  }

  var dateFormatDate;
  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
  }
}
