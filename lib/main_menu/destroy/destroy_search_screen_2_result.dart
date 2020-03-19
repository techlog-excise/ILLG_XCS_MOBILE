import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/manage_evidence_future/manage_evidence_future.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_out_list.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_out_main.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

import 'destroy_screen.dart';

class DestroyMainScreenFragmentSearchResult extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  List<ItemsEvidenceOutList> ItemSearch;
  DestroyMainScreenFragmentSearchResult({
    Key key,
    @required this.ItemsPerson,
    @required this.ItemSearch,
    //@required this.itemsOffice,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<DestroyMainScreenFragmentSearchResult> {
  List<ItemsEvidenceOutList> _searchResult = [];

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
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    String year = (int.parse(splits[3]) + 543).toString();
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
        String staff_name = "";
        _searchResult[index].EvidenceOutStaff.forEach((f) {
          //if(f.CONTRIBUTOR_ID==72){
          staff_name = f.TITLE_SHORT_NAME_TH.toString() + f.FIRST_NAME.toString() + " " + f.LAST_NAME.toString();
          //}
        });

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
                            "เลขที่หนังสืออนุมัติ",
                            style: textLabelStyle,
                          ),
                        ),
                        Padding(
                          padding: paddingInputBox,
                          child: Text(
                            _searchResult[index].EVIDENCE_OUT_NO.toString(),
                            style: textInputStyle,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "ผู้เสนออนุมัติ",
                            style: textLabelStyle,
                          ),
                        ),
                        Padding(
                          padding: paddingInputBox,
                          child: Text(
                            staff_name,
                            style: textInputStyle,
                          ),
                        ),
                      ],
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
                                        _navigate(context, _searchResult[index], false, true, false, index);
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
                        new Container(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: new Card(
                              shape: new RoundedRectangleBorder(side: new BorderSide(color: labelColor, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                              elevation: 0.0,
                              child: Container(
                                  width: 100.0,
                                  //height: 40,
                                  child: Center(
                                    child: MaterialButton(
                                      onPressed: () {
                                        _navigate(context, _searchResult[index], false, false, true, index);
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
                                  ))),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  ItemsEvidenceOutMain itemsEvidenceMain;
  Future<bool> onLoadAction(ItemsEvidenceOutList itemsMain) async {
    Map map = {"EVIDENCE_OUT_ID": itemsMain.EVIDENCE_OUT_ID};
    print(map);
    await new ManageEvidenceFuture().apiRequestEvidenceOutgetByCon(map).then((onValue) {
      itemsEvidenceMain = onValue;
    });
    setState(() {});
    return true;
  }

  _navigate(BuildContext context, ItemsEvidenceOutList itemsMain, IsCreate, IsPreview, IsUpdate, index) async {
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
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DestroyMainScreenFragment(
                  IsPreview: IsPreview,
                  IsCreate: IsCreate,
                  IsUpdate: IsUpdate,
                  ItemsdestroyMain: itemsEvidenceMain,
                )),
      );
      print("Back: " + result.toString());
      if (result.toString() != "Back") {
        _searchResult.removeAt(index);
      }
    } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DestroyMainScreenFragment(
                  IsPreview: IsPreview,
                  IsCreate: IsCreate,
                  IsUpdate: IsUpdate,
                  ItemsdestroyMain: itemsEvidenceMain,
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
              "ค้นหางานทำลายของกลาง",
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
}
