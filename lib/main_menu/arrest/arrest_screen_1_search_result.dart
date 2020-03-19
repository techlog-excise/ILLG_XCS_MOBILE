import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/arrest_screen_1.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_main_edit.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class ArrestMainScreenFragmentSearchResult extends StatefulWidget {
  // ItemsPersonInformation ItemsData;
  ItemsOAGMasStaff ItemsData;
  List<ItemsListArrestSearch> ItemSearch;
  ItemsMasterTitleResponse itemsTitle;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  ArrestMainScreenFragmentSearchResult({
    Key key,
    @required this.ItemsData,
    @required this.ItemSearch,
    @required this.itemsTitle,
    @required this.itemsMasProductSize,
    @required this.itemsMasProductUnit,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<ArrestMainScreenFragmentSearchResult> {
  List<ItemsListArrestSearch> _searchResult = [];
  ItemsListArrestMain _arrestMain;
  ItemsListArrestMainEdit _arrestMainEdit;
  List<ItemsListArrest6Section> _listGuiltbase = [];
  List<ItemsListDocument> itemsListDocument = [];

  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchResult = widget.ItemSearch;
  }

  Future<bool> onLoadActionGetAll(Map map) async {
    await new ArrestFuture().apiRequestGet(map).then((onValue) {
      _arrestMain = onValue;
    });

    await new ArrestFuture().apiRequestGetEdit(map).then((onValue) {
      _arrestMainEdit = onValue;
      // print("Edit: ${_arrestMainEdit.ArrestIndictment[0].ArrestIndictmentDetail[0].ArrestIndictmentProduct[0].PRODUCT_ID}");
    });

    Map map_guiltbase = {"TEXT_SEARCH": ""};
    await new ArrestFuture().apiRequestArrestMasGuiltbasegetByKeyword(map_guiltbase).then((onValue) {
      _listGuiltbase = onValue;
    });

    map = {"DOCUMENT_TYPE": 3, "REFERENCE_CODE": _arrestMain.ARREST_ID};
    print(map);

    await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
      itemsListDocument = [];
      List<ItemsListDocument> items = [];
      onValue.forEach((item) {
        if (int.parse(item.IS_ACTIVE) == 1) {
          items.add(item);
        }
      });

      items.forEach((f) {
        if (int.parse(f.IS_ACTIVE) == 1) {
          itemsListDocument.add(f);
        }
      });
    });

    setState(() {});
    return true;
  }

  _navigateArrestTab(BuildContext context, IsPreview, IsUpdate, ARREST_ID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    Map map = {'ARREST_ID': ARREST_ID};
    await onLoadActionGetAll(map);
    Navigator.pop(context);

    if (_arrestMain != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ArrestMainScreenFragment(
                  IsPreview: IsPreview,
                  IsCreate: false,
                  IsUpdate: IsUpdate,
                  ITEMS_ARREST: _arrestMain,
                  ITEMS_ARREST_EDIT: _arrestMainEdit,
                  ItemsPerson: widget.ItemsData,
                  itemsTitle: widget.itemsTitle,
                  ItemsGuiltbase: _listGuiltbase,
                  itemsMasProductSize: widget.itemsMasProductSize,
                  itemsMasProductUnit: widget.itemsMasProductUnit,
                  itemsListDocument: itemsListDocument,
                )),
      );
      if (result.toString() == "back") {
        print("Return");
        setState(() {
          // refresh = true;
        });
        // Navigator.pop(context);
      }
      //load again
      // onSearchTextSubmitted(controller.text, context, true);
      //Navigator.pop(context, result);
    } else {
      new NetworkDialog(context, "การเชื่อมต่อมีปัญหา");
    }
  }

  @override
  void dispose() {
    controller.dispose();
  }

  Widget _buildSearchResults() {
    Color labelColorPreview = Colors.white;
    Color labelColorEdit = Color(0xff087de1);
    TextStyle textPreviewStyle = TextStyle(fontSize: 16.0, color: labelColorPreview, fontFamily: FontStyles().FontFamily);
    TextStyle textEditStyle = TextStyle(fontSize: 16.0, color: labelColorEdit, fontFamily: FontStyles().FontFamily);

    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    TextStyle textSubInputStyle = TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 6.0, bottom: 6.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return ListView.builder(
      itemCount: _searchResult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Container(
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
                //color: Colors.white,
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
                        "เลขที่ใบงาน",
                        style: textLabelStyle,
                      ),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: Text(
                        _searchResult[index].ARREST_CODE,
                        style: textInputStyle,
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ชื่อผู้จับ",
                        style: textLabelStyle,
                      ),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: Text(
                        _searchResult[index].TITLE_SHORT_NAME_TH + _searchResult[index].FIRST_NAME + " " + _searchResult[index].LAST_NAME,
                        style: textInputStyle,
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "สถานที่เกิดเหตุ",
                        style: textLabelStyle,
                      ),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: Text(
                        _searchResult[index].SUB_DISTRICT_NAME_TH + "/" + _searchResult[index].DISTRICT_NAME_TH + "/" + _searchResult[index].PROVINCE_NAME_TH,
                        style: textInputStyle,
                      ),
                    ),
                  ],
                ),
                Row(
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
                                  width: 100.0,
                                  //height: 40,
                                  child: Center(
                                    child: MaterialButton(
                                      onPressed: () {
                                        _navigateArrestTab(context, true, false, _searchResult[index].ARREST_ID);
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
                        _searchResult[index].IS_LAWSUIT_COMPLETE == 0
                            ? new Card(
                                shape: new RoundedRectangleBorder(side: new BorderSide(color: labelColor, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                                elevation: 0.0,
                                child: Container(
                                    width: 100.0,
                                    //height: 40,
                                    child: Center(
                                      child: MaterialButton(
                                        onPressed: () {
                                          _navigateArrestTab(context, false, true, _searchResult[index].ARREST_ID);
                                        },
                                        splashColor: labelColor,
                                        //highlightColor: Colors.blue,
                                        child: Center(
                                          child: Text(
                                            "แก้ไข",
                                            style: textEditStyle,
                                          ),
                                        ),
                                      ),
                                    )))
                            : Container(),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle styleTextSearch = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    var size = MediaQuery.of(context).size;
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 6.0, bottom: 6.0);
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    // TODO: return main build
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Text(
              "ค้นหางานจับกุม",
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
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey[300], width: 1.0),
                        ),
                      ),
                      child: _searchResult.length > 0
                          ? Container(
                              padding: EdgeInsets.only(right: 18.0, top: 8.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    padding: paddingInputBox,
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
                    // child: new RefreshIndicator(
                    child: _searchResult.length != 0 ? _buildSearchResults() : new Container(),
                    //   onRefresh: _onRefresh,
                    // ),
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
