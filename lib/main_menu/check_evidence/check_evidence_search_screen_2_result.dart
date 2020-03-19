import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/prove/future/prove_future.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_arrest_product.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_indicment_product.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

import 'check_evidence_screen.dart';
import 'future/check_evidence_future.dart';
import 'model/evidence_arrest.dart';
import 'model/evidence_list.dart';
import 'model/evidence_main.dart';

class CheckEvidenceMainScreenFragmentSearchResult extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  List<ItemsEvidenceList> ItemSearch;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  ItemsMasWarehouseResponse itemsMasWarehouse;
  CheckEvidenceMainScreenFragmentSearchResult({
    Key key,
    @required this.ItemsPerson,
    @required this.ItemSearch,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
    @required this.itemsMasWarehouse,
    //@required this.itemsOffice,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<CheckEvidenceMainScreenFragmentSearchResult> {
  List<ItemsEvidenceList> _searchResult = [];

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

  String _convertYear(String sDate) {
    String year = (int.parse(sDate) + 543).toString();
    return year;
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
        String person, textButton, textTitle, staff_name = "", label = "";
        String data_number = "", data_person = "";
        if (_searchResult[index].EVIDENCE_IN_TYPE == 0) {
          if (_searchResult[index].IS_RECEIVE == 0) {
            label = "ทะเบียนตรวจพิสูจน์";
            person = "ผู้นำส่ง";
            textButton = "ตรวจรับภายใน";
            textTitle = "ตรวจรับภายใน";
            data_number = "น." + _searchResult[index].PROVE_NO.toString() + "/" + _convertYear(_searchResult[index].PROVE_NO_YEAR).toString();
            staff_name = "";
          } else {
            label = "เลขที่หนังสือนำส่ง";
            person = "ผู้นำส่ง";
            textTitle = "ตรวจรับภายใน";
            textButton = "เรียกดู";
            data_number = _searchResult[index].DELIVERY_NO.toString();
            staff_name = "";
          }
        } else if (_searchResult[index].EVIDENCE_IN_TYPE == 1) {
          label = "เลขที่หนังสือนำส่ง";
          person = "หน่วยงาน";
          textTitle = "ตรวจรับภายนอก";
          textButton = "ตรวจรับภายนอก";
        } else {
          label = "เลขที่หนังสือ";
          person = "ชื่อผู้นำออก";
          textTitle = "ตรวจรับจากการนำออก";
          textButton = "ตรวจรับจากการนำออก";
        }

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            label,
                            style: textLabelStyle,
                          ),
                        ),
                        Padding(
                          padding: paddingInputBox,
                          child: Text(
                            data_number,
                            style: textInputStyle,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            person,
                            style: textLabelStyle,
                          ),
                        ),
                        Padding(
                          padding: paddingInputBox,
                          child: Text(
                            get_staff_name(_searchResult[index].EvidenceInStaff, 59) != null ? get_staff_name(_searchResult[index].EvidenceInStaff, 59) : "",
                            style: textInputStyle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                _searchResult[index].IS_RECEIVE != 0
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
                                        width: 100.0,
                                        //height: 40,
                                        child: Center(
                                          child: MaterialButton(
                                            onPressed: () {
                                              _navigate(context, _searchResult[index], textTitle, false, true, false, index);
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
                                    //width: 100.0,
                                    //height: 40,
                                    child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      _navigate(context, _searchResult[index], textButton, true, false, false, index);
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

  ItemsEvidenceArrest itemsEvidenceArrest;
  ItemsEvidenceMain itemsEvidenceMain;
  List<ItemsProveArrestIndicmentProduct> _listProveIndicmentProduct = [];
  List<ItemsProveArrestProduct> _listItemsProveArrestProduct = [];
  List<ItemsListDocument> itemsDocument = [];

  Future<bool> onLoadAction(ItemsEvidenceList itemsMain) async {
    Map map = {"PROVE_ID": itemsMain.PROVE_ID};
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

    map = {"INDICTMENT_ID": itemsEvidenceArrest.INDICTMENT_ID};
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

    /* itemsEvidenceMain.EvidenceInItem.forEach((itm){
      for(int i=0;i<_listItemsProveArrestProduct.length;i++){
        if(itm.PRODUCT_MAPPING_ID == _listItemsProveArrestProduct[i].PRODUCT_MAPPING_ID){
          _listItemsProveArrestProduct[i].IS_CHECK=true;

          break;
        }
      }
    });*/

    map = {"DOCUMENT_TYPE": 11, "REFERENCE_CODE": itemsEvidenceMain.EVIDENCE_IN_ID};
    await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
      List<ItemsListDocument> items = [];
      onValue.forEach((item) {
        if (int.parse(item.IS_ACTIVE) == 1) {
          items.add(item);
        }
      });
      itemsDocument = items;
    });

    setState(() {});
    return true;
  }

  _navigate(BuildContext context, ItemsEvidenceList itemsMain, String title, IsCreate, IsPreview, IsUpdate, index) async {
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

    if (IsPreview) {
      if (itemsEvidenceArrest != null) {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckEvidenceMainScreenFragment(
                    itemsEvidenceMain: itemsEvidenceMain,
                    ItemsPerson: widget.ItemsPerson,
                    itemsEvidenceArrest: itemsEvidenceArrest,
                    title: title,
                    IsCreate: false,
                    IsPreview: true,
                    IsUpdate: false,
                    EVIDENCE_TYPE: itemsMain.EVIDENCE_IN_TYPE,
                    itemsMasProductSize: widget.itemsMasProductSize,
                    itemsMasProductUnit: widget.itemsMasProductUnit,
                    itemsMasWarehouse: widget.itemsMasWarehouse,
                    itemsProveArrestProduct: _listItemsProveArrestProduct,
                    ItemsDocument: itemsDocument,
                  )),
        );
        print("Back: " + result.toString());
        if (result.toString() != "Back") {
          _searchResult.removeAt(index);
        }
      } else {
        new VerifyDialog(context, 'ไม่สามารถเรียกดูข้อมูลได้ เนื่องจากขาดข้อมูลส่วนพิสูจน์');
      }
    } else {
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
        //itemMain = result;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    return WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Text(
              "ค้นหางานตรวจรับของกลาง",
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
              child: _searchResult.length != 0
                  ? Column(
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
                        ),
                        Expanded(
                          child: _searchResult.length != 0 ? _buildSearchResults() : new Container(),
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
          ],
        ),
      ),
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
}
