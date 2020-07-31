import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_division_rate.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/future/compare_future.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_list.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class CompareFragment extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsMasterTitleResponse itemsTitle;
  CompareFragment({
    Key key,
    @required this.ItemsPerson,
    @required this.itemsTitle,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<CompareFragment> {
  //style content
  TextStyle textStyleLanding = Styles.textStyleLanding;
  TextStyle textStyleLabel = Styles.textStyleLabel;
  TextStyle textStyleData = Styles.textStyleData;
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400], fontFamily: FontStyles().FontFamily, fontSize: 12.0);
  TextStyle textStyleDataSub = TextStyle(fontSize: 16, fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleButtonAccept = Styles.textStyleButtonAccept;
  TextStyle textStyleButtonNotAccept = TextStyle(fontSize: 16, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);

  //item data
  List<ItemsCompareList> itemMain = [];
  ItemsCompareArrestMain compareMain;

  var dateFormatDate;

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
  }

  Widget _buildContent(BuildContext context) {
    return ListView.builder(
      itemCount: itemMain.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        String compare_year = "";
        /*DateTime dt_lawsuit_year = DateTime.parse(
                  itemMain[index].LAWSUIT_NO_YEAR);*/
        //DateTime dt_lawsuit_year = itemMain[index].LAWSUIT_NO_YEAR != null ? DateTime.parse(itemMain[index].LAWSUIT_NO_YEAR) : DateTime.now();
        //List splitslawYear = dateFormatDate.format(dt_lawsuit_year).toString().split(" ");

        //String title_lawsuit_name = itemMain[index].LAWSUIT_TITLE_SHORT_NAME_TH != null ? itemMain[index].LAWSUIT_TITLE_SHORT_NAME_TH : itemMain[index].LAWSUIT_TITLE_NAME_TH;
        String title_lawsuit_name = "ทดสอบ";

        //compare_year = (int.parse(splitslawYear[3]) + 543).toString();
        compare_year = itemMain[index].LAWSUIT_NO_YEAR;
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
                    Padding(
                      padding: paddingData,
                      child: Text(
                        "น. " + itemMain[index].LAWSUIT_NO.toString() + "/" + compare_year,
                        style: textStyleData,
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ชื่อผู้กล่าวหา",
                        style: textStyleLabel,
                      ),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        "ทดสอบ",
                        //title_lawsuit_name + itemMain[index].LAWSUIT_FIRST_NAME + " " + itemMain[index].LAWSUIT_LAST_NAME,
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
                              //width: 130.0,
                              //height: 40,
                              child: Center(
                                child: MaterialButton(
                                  onPressed: () {
                                    _navigate(context, itemMain[index].INDICTMENT_ID);
                                  },
                                  splashColor: Color(0xff087de1),
                                  //highlightColor: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      "ชำระค่าปรับ",
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

  ItemsListDivisionRate itemsListDivisionRate;

  Future<bool> onLoadActionGetCompareIndicment(Map map) async {
    await new CompareFuture().apiRequestCompareArrestgetByIndictmentID(map).then((onValue) {
      compareMain = onValue[0];
    });
    map = {"TEXT_SEARCH": "", "DIVISIONRATE_ID": ""};
    await new ArrestFutureMaster().apiRequestMasDivisionRategetByCon(map).then((onValue) {
      itemsListDivisionRate = onValue.RESPONSE_DATA.first;
    });

    for (int i = 0; i < compareMain.CompareArrestIndictmentDetail.length; i++) {
      Map map_mist = {"PERSON_ID": compareMain.CompareArrestIndictmentDetail[i].PERSON_ID, "SUBSECTION_ID": compareMain.SUBSECTION_ID};
      await new CompareFuture().apiRequestCompareCountMistreatgetByCon(map_mist).then((onValue) {
        print(compareMain.CompareArrestIndictmentDetail[i].PERSON_ID.toString() + " : " + onValue.MISTREAT.toString());
        compareMain.CompareArrestIndictmentDetail[i].MISTREAT_NO = onValue.MISTREAT;
      });
    }

    setState(() {});
    return true;
  }

  _navigate(BuildContext context, int INDICTMENT_ID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    Map map = {"INDICTMENT_ID": INDICTMENT_ID};
    await onLoadActionGetCompareIndicment(map);
    Navigator.pop(context);
    if (compareMain != null || itemsListDivisionRate != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CompareMainScreenFragment(
                  itemsListDivisionRate: itemsListDivisionRate,
                  itemsCompareMain: null,
                  itemsCompareArrestMain: compareMain,
                  ItemsPerson: widget.ItemsPerson,
                  IsEdit: false,
                  IsPreview: false,
                )),
      );
      if (result.toString() != "Back") {
        itemMain = result;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map map = {
      "COMPARE_NO": "",
      "COMPARE_NO_YEAR": "",
      "COMPARE_DATE_FROM": "",
      "COMPARE_DATE_TO": "",
      "COMPARE_NAME": "",
      "COMPARE_OFFICE_NAME": "",
      "COMPARE_IS_OUTSIDE": "",
      "ARREST_CODE": "",
      "OCCURRENCE_DATE_FROM": "",
      "OCCURRENCE_DATE_TO": "",
      "ARREST_NAME": "",
      "ARREST_OFFICE_NAME": "",
      "SUBSECTION_NAME": "",
      "GUILTBASE_NAME": "",
      "LAWSUIT_IS_OUTSIDE": 1,
      "LAWSUIT_NO": "",
      "LAWSUIT_NO_YEAR": "",
      "LAWSUIT_DATE_FROM": "",
      "LAWSUIT_DATE_TO": "",
      "LAWSUIT_OFFICE_NAME": "",
      "LAWSUIT_NAME": "",
      "PROVE_IS_OUTSIDE": "",
      "PROVE_NO": "",
      "PROVE_NO_YEAR": "",
      "RECEIVE_DOC_DATE_FROM": "",
      "RECEIVE_DOC_DATE_TO": "",
      "RECEIVE_OFFICE_NAME": "",
      "PROVE_NAME": "",
      "ACCOUNT_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE
    };

    return FutureBuilder<List<ItemsCompareList>>(
      future: new CompareFuture().apiRequestCompareListgetByConAdv(map),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //itemMain = snapshot.data;
          List<ItemsCompareList> items = [];
          snapshot.data.forEach((f) {
            if ((f.COMPARE_ID == null || f.COMPARE_ID == 0) && f.IS_COMPARE == 1) {
              //if ((f.PROVE_NO > 0 && f.IS_PROVE == 1) || (f.PROVE_NO <= 0 && f.IS_PROVE == 0)) {
              if ((f.PROVE_NO != null && f.IS_PROVE == 1) || (f.PROVE_NO != null && f.IS_PROVE == 0)) {
                items.add(f);
              }
            }
          });
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
                              //height: 34.0,
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
                                        'รอเปรียบเทียบ ' + itemMain.length.toString() + ' คดี',
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
                                  "ไม่มีรายการเปรียบเทียบคดี",
                                  style: TextStyle(fontSize: 20.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
              )
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
}
