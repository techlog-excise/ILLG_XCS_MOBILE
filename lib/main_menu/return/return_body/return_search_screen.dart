import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_main.dart';
import 'package:prototype_app_pang/main_menu/destroy/destroy_screen.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/approve.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_evidence.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_main.dart';
import 'package:prototype_app_pang/main_menu/return/return_body/return_screen.dart';
import 'package:prototype_app_pang/main_menu/return/return_body/model/approve.dart';
import 'package:prototype_app_pang/main_menu/return/return_body/model/donate.dart';
import 'package:prototype_app_pang/main_menu/return/return_body/model/return.dart';
import 'package:prototype_app_pang/main_menu/return/return_body/model/return_main.dart';
import 'package:prototype_app_pang/main_menu/return/return_body/model/government.dart';
import 'package:prototype_app_pang/main_menu/musuim/model/approve.dart';
import 'package:prototype_app_pang/main_menu/musuim/model/musuim.dart';
import 'package:prototype_app_pang/main_menu/musuim/model/musuim_main.dart';
import 'package:prototype_app_pang/main_menu/musuim/musuim_screen.dart';
import 'package:prototype_app_pang/main_menu/transfer/model/approve.dart';
import 'package:prototype_app_pang/main_menu/transfer/model/tranfer.dart';
import 'package:prototype_app_pang/main_menu/transfer/model/transfer_main.dart';
import 'package:prototype_app_pang/main_menu/transfer/transfer_screen.dart';
import 'package:prototype_app_pang/model/Constants.dart';

class ReturnSearchScreenFragment extends StatefulWidget {
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<ReturnSearchScreenFragment> {
  TextEditingController controller = new TextEditingController();
  List<ItemsExportMain> _searchResult = [];
  List<ItemsExportMain> _itemsInit = [
    new ItemsExportMain(
        new ItemsExportApprove(
        "กค 0809.1/2561",
        "09 กันยายน 2561",
        "เวลา 13.00 น.",
        "นายนิรมิตร เนตรนัย",
        "สสพ.ระยอง",
        "นายนิรมิตร เนตรนัย",
        "สสพ.สุราษฎร์ธานี",
        "09 กันยายน 2561",
        "เวลา 13.00 น.",
            "แถลงข่าว",
            "คลัง 5",
        0,
        new ItemsGovernment(
          "9 กันยายน 2561"
        ),
        null),
        new ItemsExport(
            "Auto Generate",
            "09 กันยายน 2561",
            "11.30",
            "นายนิรมิตร  เนตรนัย",
            "สสพ.สุราษฎร์ธานี",
            [
              new ItemsDestroyEvidence(
                "สุรา",
                "สราแช่",
                "ชนิดเบียร์",
                "4.4",
                "ดีกรี",
                "hoegaarden",
                "",
                "SADLER S PEAKY BLINDER",
                0,
                "ลิตร",
                0,
                "",
                0,
                "",
                false,
                null,
                false,
                new ItemsCheckEvidenceDetailController(
                    new ExpandableController(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    "ขวด",
                    "ลิตร",
                    ['ขวด', 'ลัง'],
                    ['ลิตร']),
              ),
            ]),
        true),
    new ItemsExportMain(
        new ItemsExportApprove(
            "กค 0809.1/2561",
            "09 กันยายน 2561",
            "เวลา 13.00 น.",
            "นายนิรมิตร เนตรนัย",
            "สสพ.ระยอง",
            "นายนิรมิตร เนตรนัย",
            "สสพ.สุราษฎร์ธานี",
            "09 กันยายน 2561",
            "เวลา 13.00 น.",
            "แถลงข่าว",
            "คลัง 5",
            1,
            null,
            new ItemsDonate(
              "นายนิรมิตร เนตรนัย",
              "หนัวหน้า สสพ.ระยอง",
              "สสพ.สุราษฎร์ธานี"
            )),
        new ItemsExport(
            "Auto Generate",
            "09 กันยายน 2561",
            "11.30",
            "นายนิรมิตร  เนตรนัย",
            "สสพ.สุราษฎร์ธานี",
            [
              new ItemsDestroyEvidence(
                "สุรา",
                "สราแช่",
                "ชนิดเบียร์",
                "4.4",
                "ดีกรี",
                "hoegaarden",
                "",
                "SADLER S PEAKY BLINDER",
                0,
                "ลิตร",
                0,
                "",
                0,
                "",
                false,
                null,
                false,
                new ItemsCheckEvidenceDetailController(
                    new ExpandableController(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    "ขวด",
                    "ลิตร",
                    ['ขวด', 'ลัง'],
                    ['ลิตร']),
              ),
            ]),
        true),
  ];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'ใช้ทางราชการ', icon: Icons.mode_edit),
    const Constants(text: 'บริจาค', icon: Icons.delete_outline),
  ];

  @override
  void initState() {
    super.initState();
  }

  onSearchTextChanged(String text) async {
    print(text);
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    /*for(int i=0;i<_items.length;i++){
      if (_items[i].contains(text) ||
          _searchDetails[i].contains(text)) {
        _searchResult.add(_searchDetails[i]);
        _searchResult1.add(_searchDetails1[i]);
      }
    }*/
    _itemsInit.forEach((userDetail) {
      if (userDetail.Approves.ApproveNumber.contains(text))
        _searchResult.add(userDetail);
    });
    setState(() {});
  }

  Widget _buildSearchResults() {
    Color labelColorPreview = Colors.white;
    Color labelColorEdit = Color(0xff087de1);
    TextStyle textPreviewStyle = TextStyle(
        fontSize: 16.0, color: labelColorPreview,fontFamily: FontStyles().FontFamily);
    TextStyle textEditStyle = TextStyle(fontSize: 16.0, color: labelColorEdit,fontFamily: FontStyles().FontFamily);

    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
    TextStyle textStyleDataSub = TextStyle(
        fontSize: 16, color: Colors.grey[400],fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor,fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
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
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("เลขที่หนังสืออนุมัติ", style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _searchResult[index].Approves.ApproveNumber,
                      style: textInputStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("ผู้นำออกจากคลัง", style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _searchResult[index].Exports.ExportPerson,
                      style: textInputStyle,),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: new Card(
                            color: labelColor,
                            shape: new RoundedRectangleBorder(
                                side: new BorderSide(
                                    color: labelColor, width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            elevation: 0.0,
                            child: Container(
                                width: 100.0,
                                //height: 40,
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      _navigate(
                                          context, _searchResult[index], false,
                                          true, false);
                                    },
                                    splashColor: labelColor,
                                    //highlightColor: Colors.blue,
                                    child: Center(
                                      child: Text(
                                        "เรียกดู", style: textPreviewStyle,),),
                                  ),
                                )
                            )
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: new Card(
                            shape: new RoundedRectangleBorder(
                                side: new BorderSide(
                                    color: labelColor, width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            elevation: 0.0,
                            child: Container(
                                width: 100.0,
                                //height: 40,
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      _navigate(
                                          context, _searchResult[index], true,
                                          false, false);
                                    },
                                    splashColor: labelColor,
                                    //highlightColor: Colors.blue,
                                    child: Center(
                                      child: Text(
                                        "แก้ไข", style: textEditStyle,),),
                                  ),
                                )
                            )
                        ),
                      ),
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

  _navigate(BuildContext context, ItemsExportMain itemMain, IsEdit,
      IsPreview, IsCreate) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          ReturnMainScreenFragment(
            //ItemsexportMain: itemMain,
            IsUpdate: IsEdit,
            IsPreview: IsPreview,
            IsCreate: IsCreate,
          )),
    );
    if (result.toString() != "Back") {
      _searchResult = result;
      print("resut : " + result.toString());
    }
  }
  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("ใช้ทางราชการ")) {
        List<ItemsExportMain> items=[];
        _searchResult.forEach((item){
          if(item.Approves.ExportType==0){
            items.add(item);
          }
        });
        setState(() {
          _searchResult=items;
        });
      } else {
        List<ItemsExportMain> items=[];
        _searchResult.forEach((item){
          if(item.Approves.ExportType==0){
            items.add(item);
          }
        });
        setState(() {
          _searchResult=items;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextSearch = TextStyle(
        fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    var size = MediaQuery
        .of(context)
        .size;

    return new Theme(
      data: new ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          hintColor: Colors.grey[400]
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            title: new Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: new TextField(
                style: styleTextSearch,
                controller: controller,
                decoration: new InputDecoration(
                  hintText: "ค้นหา",
                  hintStyle: styleTextSearch,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                ),
                onChanged: onSearchTextChanged,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,), onPressed: () {
              Navigator.pop(context, "Back");
            }),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                //height: 34.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      /*Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
                              child: new Text('ILG60_B_10_00_02_00',
                                style: TextStyle(color: Colors.grey[400],
                                    fontFamily: FontStyles().FontFamily,
                                    fontSize: 12.0),),
                            ),
                          ]
                      ),*/
                      _searchResult.length>0?Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: PopupMenuButton<Constants>(
                              onSelected: choiceAction,
                              icon: Icon(FontAwesomeIcons.alignRight,),
                              itemBuilder: (BuildContext context) {
                                return constants.map((Constants contants) {
                                  return PopupMenuItem<Constants>(
                                    value: contants,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.only(left: 4.0),
                                          child: Text(contants.text,style: TextStyle(fontFamily: FontStyles().FontFamily),),)
                                      ],
                                    ),
                                  );
                                }).toList();
                              },
                            )
                          )
                        ],
                      ):Container(),
                    ],
                  )

              ),
              Expanded(
                child: _searchResult.length != 0 || controller.text.isNotEmpty
                    ? _buildSearchResults() : new Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
