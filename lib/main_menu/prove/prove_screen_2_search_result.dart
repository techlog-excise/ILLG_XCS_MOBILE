import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/future/lawsuit_future.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/model/lawsuit_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/model/lawsuit_main.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_screen.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

import 'future/prove_future.dart';
import 'model/prove_arrest.dart';
import 'model/prove_arrest_product.dart';
import 'model/prove_indicment_product.dart';
import 'model/prove_list.dart';
import 'model/prove_main.dart';
import 'model/prove_product.dart';
import 'model/prove_science.dart';
import 'model/prove_staff.dart';

class ProveMainScreenFragmentSearchResult extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  //ItemsArrestResponseGetOffice itemsOffice;
  List<ItemsProveList> ItemSearch;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  ProveMainScreenFragmentSearchResult({
    Key key,
    @required this.ItemsPerson,
    @required this.ItemSearch,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
    //@required this.itemsOffice,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<ProveMainScreenFragmentSearchResult> {
  List<ItemsProveList> _searchResult = [];
  ItemsLawsuitArrestMain lawsuitMain;
  ItemsLawsuitMain _itemsLawsuitMain;

  var dateFormatDate;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');

    _searchResult = widget.ItemSearch;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildSearchResults() {
    Color labelColorPreview = Colors.white;
    Color labelColorEdit = Color(0xff087de1);
    TextStyle textPreviewStyle = TextStyle(fontSize: 16.0, color: labelColorPreview, fontFamily: FontStyles().FontFamily);
    TextStyle textEditStyle = TextStyle(fontSize: 16.0, color: labelColorEdit, fontFamily: FontStyles().FontFamily);

    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    TextStyle textStyleDataSub = TextStyle(fontSize: 16, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    TextStyle textStyleButtonAccept = TextStyle(fontSize: 16, color: Colors.white, fontFamily: FontStyles().FontFamily);
    TextStyle textStyleButtonNotAccept = TextStyle(fontSize: 16, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);

    return ListView.builder(
      itemCount: _searchResult.length,
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
                    _searchResult[index].PROVE_ID == null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "เลขที่รับคำกล่าวโทษ",
                                  style: textLabelStyle,
                                ),
                              ),
                              Padding(
                                padding: paddingInputBox,
                                child: Text(
                                  _searchResult[index].LAWSUIT_NO.toString() + '/' + _searchResult[index].LAWSUIT_NO_YEAR.toString(),
                                  style: textInputStyle,
                                ),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "ประเภทของกลาง",
                                  style: textLabelStyle,
                                ),
                              ),
                              Padding(
                                padding: paddingInputBox,
                                child: Text(
                                  /*itemMain[index].EvidenceType*/ "-",
                                  style: textInputStyle,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "ทะเบียนตรวจพิสูจน์",
                                  style: textLabelStyle,
                                ),
                              ),
                              _searchResult[index].IS_OUTSIDE == 1
                                  ? Padding(
                                      padding: paddingInputBox,
                                      child: Text(
                                        "น. " + _searchResult[index].PROVE_NO.toString() + '/' + "2562",
                                        style: textInputStyle,
                                      ),
                                    )
                                  : Padding(
                                      padding: paddingInputBox,
                                      child: Text(
                                        _searchResult[index].PROVE_NO.toString() + '/' + "2562",
                                        style: textInputStyle,
                                      ),
                                    ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "ผู้ตรวจพิสูจน์",
                                  style: textLabelStyle,
                                ),
                              ),
                              Padding(
                                padding: paddingInputBox,
                                child: Text(
                                  _searchResult[index].PROVE_STAFF_NAME.trim().isEmpty ? "" : _searchResult[index].PROVE_STAFF_NAME,
                                  style: textInputStyle,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
                _searchResult[index].PROVE_ID != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              new Container(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: new Card(
                                    color: labelColor,
                                    shape: new RoundedRectangleBorder(side: new BorderSide(color: labelColor, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                                    elevation: 0.0,
                                    child: Container(
                                        padding: EdgeInsets.only(left: 6.0, right: 6.0),
                                        //width: 100.0,
                                        //height: 40,
                                        child: Center(
                                          child: MaterialButton(
                                            onPressed: () {
                                              _navigate(context, _searchResult[index].LAWSUIT_ID, _searchResult[index].PROVE_ID, false, true, false, index);
                                            },
                                            splashColor: labelColor,
                                            //highlightColor: Colors.blue,
                                            child: Center(
                                              child: Text(
                                                "เรียกดู",
                                                style: textPreviewStyle,
                                              ),
                                            ),
                                          ),
                                        ))),
                              ),
                            ],
                          )
                        ],
                      )
                    : Row(
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
                                          _navigate(context, _searchResult[index].LAWSUIT_ID, 0, true, false, false, index);
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

  ItemsProveMain itemsProveMain;
  List<ItemsProveStaff> itemsProveSatff = [];
  ItemsProveScience itemsProveScience;
  List<ItemsProveProduct> itemsProveProduct = [];

  bool IsCompareComplete = false;

  Future<bool> onLoadAction(Map map_law, bool IsPreview, int proveID) async {
    await new ProveFuture().apiRequestProveArrestgetByCon(map_law).then((onValue) {
      itemsProveArrest = onValue.first;
    });
    Map map = {"INDICTMENT_ID": itemsProveArrest.INDICTMENT_ID};
    await new ProveFuture().apiRequestProveArrestIndictmentProductgetByCon(map).then((onValue) {
      _listProveIndicmentProduct = onValue;
    });

    _listItemsProveArrestProduct = [];
    for (int i = 0; i < _listProveIndicmentProduct.length; i++) {
      Map map = {"PRODUCT_ID": _listProveIndicmentProduct[i].PRODUCT_ID};
      await new ProveFuture().apiRequestProveArrestProductgetByCon(map).then((onValue) {
        _listItemsProveArrestProduct.add(onValue);
      });
    }

    if (IsPreview) {
      map = {"PROVE_ID": proveID};
      await new ProveFuture().apiRequestProvegetByCon(map).then((onValue) {
        itemsProveMain = onValue;
      });
      await new ProveFuture().apiRequestProveStaffgetByCon(map).then((onValue) {
        itemsProveSatff = onValue;
      });
      await new ProveFuture().apiRequestProveSciencegetByCon(map).then((onValue) {
        if (onValue.length > 0) {
          itemsProveScience = onValue.first;
        }
      });
      await new ProveFuture().apiRequestProveProductgetByProveId(map).then((onValue) {
        itemsProveProduct = onValue;
      });

      await new LawsuitFuture().apiRequestLawsuiltComparegetByLawsuitID(map).then((onValue) {
        if (onValue != null) {
          print("onValue : " + onValue.COMPARE_ID.toString());
          IsCompareComplete = true;
        } else {
          IsCompareComplete = false;
        }
      });

      map = {"LAWSUIT_ID": itemsProveArrest.LAWSUIT_ID};
      await new LawsuitFuture().apiRequestLawsuiltComparegetByLawsuitID(map).then((onValue) {
        if (onValue != null) {
          print("onValue : " + onValue.COMPARE_ID.toString());
          IsCompareComplete = true;
        } else {
          IsCompareComplete = false;
        }
      });
      print(IsCompareComplete.toString());
    }

    setState(() {});
    return true;
  }

  _navigate(BuildContext context, int lawsuitID, int proveID, IsCreate, IsPreview, IsUpdate, index) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    Map map = {"LAWSUIT_ID": lawsuitID};
    await onLoadAction(map, IsPreview, proveID);
    Navigator.pop(context);

    if (IsPreview) {
      _listItemsProveArrestProduct.forEach((item) {
        item.IS_PROVE = true;
      });

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProveMainScreenFragment(
                  itemsProveMain: itemsProveMain,
                  itemsProveSatff: itemsProveSatff,
                  itemsProveScience: itemsProveScience,
                  itemsProveProduct: itemsProveProduct,
                  itemsProveArrest: itemsProveArrest,
                  //itemsIndicmentProduct: _listProveIndicmentProduct,
                  itemsProveArrestProduct: _listItemsProveArrestProduct,
                  ItemsPerson: widget.ItemsPerson,
                  IsCreate: false,
                  IsEdit: false,
                  IsPreview: true,
                  itemsMasProductUnit: widget.itemsMasProductUnit,
                  itemsMasProductSize: widget.itemsMasProductSize,
                  IS_COMPARE_COMPARE: IsCompareComplete,
                )),
      );
      if (result.toString() != "Back") {
        _searchResult.removeAt(index);
      }
    } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProveMainScreenFragment(
                  itemsProveArrest: itemsProveArrest,
                  //itemsIndicmentProduct: _listProveIndicmentProduct,
                  itemsProveArrestProduct: _listItemsProveArrestProduct,
                  ItemsPerson: widget.ItemsPerson,
                  IsCreate: IsCreate,
                  IsEdit: IsUpdate,
                  IsPreview: IsPreview,
                  itemsMasProductUnit: widget.itemsMasProductUnit,
                  itemsMasProductSize: widget.itemsMasProductSize,
                  IS_COMPARE_COMPARE: IsCompareComplete,
                )),
      );
      if (result.toString() != "Back") {
        //
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    Color labelColor = Color(0xff087de1);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);

    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Text(
              "ค้นหางานพิสูจน์ของกลาง",
              style: styleTextAppbar,
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context, "Back");
                }),
          ),
        ),
        body: Stack(
          children: <Widget>[
            BackgroundContent(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      //height: 34.0,
                      decoration: BoxDecoration(
                          border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
                      child: _searchResult.length > 0
                          ? Container(
                              padding: EdgeInsets.only(right: 18.0, top: 8.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      'รวมทั้งหมด ' + _searchResult.length.toString() + ' คดี',
                                      style: textLabelStyle,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container()),
                  Expanded(
                    child: _searchResult.length != 0 ? _buildSearchResults() : new Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
