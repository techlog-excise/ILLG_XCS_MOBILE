import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_evidence.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_section.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;

class TabScreenArrest6Search extends StatefulWidget {
  List ItemsLawbreaker;
  List ItemsProduct;
  ItemsListArrest6Section ItemsSection;
  ItemsListArrest6Section ItemsGuiltbase;
  bool IsUpdate;
  TabScreenArrest6Search({
    Key key,
    @required this.ItemsLawbreaker,
    @required this.ItemsProduct,
    @required this.ItemsSection,
    @required this.IsUpdate,
    @required this.ItemsGuiltbase,
  }) : super(key: key);
  @override
  _TabScreenArrest6SearchState createState() => new _TabScreenArrest6SearchState();
}

class _TabScreenArrest6SearchState extends State<TabScreenArrest6Search> {
  //dialog
  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);

  TabController tabController;
  TextEditingController controller = new TextEditingController();
  List<ItemsListArrest6Section> _searchResult = [];
  int _countItem = 0;
  List<ItemsListArrest6Section> _itemsData = [];
  List<bool> _value = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<ItemsListArrest6Section>> apiRequest(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestMasGuiltbasegetByKeyword",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListArrest6Section.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await apiRequest(map).then((onValue) {
      _searchResult = onValue;
    });
    setState(() {});
    return true;
  }

  //on submitted search
  onSearchTextSubmitted(String text, mContext) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        });
    Map map = {'TEXT_SEARCH': text};
    await onLoadAction(map);
    Navigator.pop(context);
    if (_searchResult.length == 0) {
      new EmptyDialog(mContext, "ไม่พบข้อมูล.");
    }
  }

  buildDataContent(index) {
    Color labelColor = Colors.grey[500];
    Color labelPreview = Color(0xff2e76bc);
    TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    TextStyle textInputStyleSub = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    TextStyle textPreviewStyle = TextStyle(fontSize: 14.0, color: labelPreview, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    return Stack(
      children: <Widget>[
        ListTile(
          title: Container(
            padding: paddingLabel,
            child: Text(
              'มาตรา ' + _searchResult[index].SUBSECTION_NAME,
              style: textInputStyleTitle,
            ),
          ),
          subtitle: Padding(
            padding: paddingInputBox,
            child: Text(
              _searchResult[index].GUILTBASE_NAME,
              style: textInputStyleSub,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[300],
            size: 18,
          ),
        ),
        /*Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: paddingLabel,
                    child: Text(_searchResult[index].SECTION_NAME,
                      style: textInputStyleTitle,),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.arrow_forward_ios,color: Colors.grey[300],size: 18,),
              ],
            ),
            Padding(
              padding: paddingInputBox,
              child: Text(
                _searchResult[index].GUILTBASE_NAME,
                style: textInputStyleSub,),
            ),
          ],
        ),*/
      ],
    );
  }

  Widget _buildSearchResults() {
    Color labelColor = Color(0xff087de1);
    TextStyle textExpandStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    return ListView.builder(
      itemCount: _searchResult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            (widget.ItemsLawbreaker.length > 0 || widget.ItemsProduct.length > 0) ? _navigateSelection(context, 'มาตรา ' + _searchResult[index].SUBSECTION_NAME, _searchResult[index]) : new VerifyDialog(context, "กรุณาระบุผู้ต้องหาหรือของกลาง");
          },
          child: Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
              padding: EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                  //color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    //top: BorderSide(color: Colors.grey[300], width: 1.0),
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
              child: buildDataContent(index),
            ),
          ),
        );
      },
    );
  }

  _navigateSelection(BuildContext context, String title, ItemsListArrest6Section itemMain) async {
    var result;
    if (widget.ItemsLawbreaker.length == 0 && widget.ItemsProduct.length > 0) {
      print("กรณีไม่มีผู้ต้องหาแต่มีของกลาง");
      itemMain.ArrestIndictmentDetail = [];
      result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest6Evidence(
                  IsUpdate: false,
                  Title: title,
                  ItemsData: itemMain,
                  ItemsProduct: widget.ItemsProduct,
                )),
      );
    } else {
      print("กรณีมีผู้ต้องหาและมีของกลาง");
      result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest6Section(
                  Title: title,
                  ItemsLawbreaker: widget.ItemsLawbreaker,
                  ItemsSection: itemMain,
                  ItemsProduct: widget.ItemsProduct,
                  IsUpdate: widget.IsUpdate,
                )),
      );
    }

    //_itemsData=result;
    //Navigator.pop(context);
    if (result.toString() != "back") {
      //_itemsData = result;
      if (widget.ItemsSection != null) {
        widget.ItemsSection = result;
      } else {
        Navigator.pop(context, result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextSearch = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
        onWillPop: () {
          return new Future(() => false);
        },
        child: new Theme(
          data: new ThemeData(primaryColor: Colors.white, accentColor: Colors.white, hintColor: Colors.grey[400]),
          child: Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70.0), // here the desired height
                child: AppBar(
                  title: new Padding(
                    padding: EdgeInsets.only(right: 22.0),
                    child: new Row(
                      children: <Widget>[
                        new SizedBox(
                          width: 10.0,
                        ),
                        new Expanded(
                          child: new Stack(alignment: const Alignment(1.0, 1.0), children: <Widget>[
                            new TextField(
                              decoration: InputDecoration(
                                hintText: 'ค้นหา',
                                hintStyle: styleTextSearch,
                              ),
                              style: styleTextSearch,
                              onChanged: (text) {
                                setState(() {
                                  print(text);
                                });
                              },
                              onSubmitted: (String text) {
                                onSearchTextSubmitted(text, context);
                              },
                              controller: controller,
                            ),
                            controller.text.length > 0
                                ? new IconButton(
                                    icon: new Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        controller.clear();
                                      });
                                    })
                                : new Container(
                                    height: 0.0,
                                  )
                          ]),
                        ),
                      ],
                    ),
                  ),
                  centerTitle: true,
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                      ),
                      onPressed: () {
                        Navigator.pop(context, "back");
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
                          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                          decoration: BoxDecoration(
                              //color: Colors.grey[200],
                              border: Border(
                            top: BorderSide(color: Colors.grey[300], width: 1.0),
                            //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                          )),
                          /*child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: new Text(_searchResult.length==0?'ILG60_B_01_00_23_00':'ILG60_B_01_00_24_00',
                            style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
                        )
                      ],
                    ),*/
                        ),
                        Expanded(
                          child: _searchResult.length != 0 || controller.text.isNotEmpty ? _buildSearchResults() : new Container(),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
