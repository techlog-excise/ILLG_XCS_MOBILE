import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_staff.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_3/tab_screen_arrest_3_create.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class TabScreenArrest3Search extends StatefulWidget {
  ItemsListArrestMain ItemsMain;
  ItemsMasterTitleResponse itemsTitle;
  TabScreenArrest3Search({
    Key key,
    @required this.ItemsMain,
    @required this.itemsTitle,
  }) : super(key: key);
  @override
  _TabScreenArrest3SearchState createState() => new _TabScreenArrest3SearchState();
}

class _TabScreenArrest3SearchState extends State<TabScreenArrest3Search> {
  TabController tabController;
  TextEditingController controller = new TextEditingController();
  final FocusNode myFocusNodeSearch = FocusNode();
  List<ItemsListArrestStaff> _searchResult = [];
  int _countItem = 0;
  List _itemsData = [];
  List<bool> _value = [];
  bool isChecking = false;

  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleSub = TextStyle(fontSize: 14.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily);
  TextStyle textLabelEditCheckedStyle = TextStyle(fontSize: 16.0, color: Colors.red, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelEditNonCheckStyle = TextStyle(fontSize: 16.0, color: Colors.red[100], fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: FontStyles().FontFamily);
  TextStyle styleTextSearch = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleCreate = TextStyle(color: Color(0xff087de1), fontSize: 18.0, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  TextStyle textCheckAllStyle = TextStyle(fontSize: 16.0, color: Color(0xff2e76bc), fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNodeSearch.dispose();
  }

  onSearchTextSubmitted(String text, mContext) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    Map mapGetByCon = {"TEXT_SEARCH": controller.text, "STAFF_ID": ""};
    /*Map mapGetByCon = {
      "STAFF_CODE": "",
      "STAFF_NAME": "",
      "OFFICE_NAME": "",
      "ID_CARD": "",
      "STATUS": 1
    };*/
    await onLoadActionInsStaff(mapGetByCon);
    Navigator.pop(context);
    if (_searchResult.length == 0) {
      new EmptyDialog(context, "ไม่พบข้อมูล");
    }
  }

  ArrestFuture future = new ArrestFuture();

  Future<bool> onLoadActionInsStaff(Map map) async {
    await future.apiRequestMasStaffgetByCon(map).then((onValue) {
      _searchResult = onValue.RESPONSE_DATA;
      _searchResult.forEach((item) {
        item.IsCreated = true;
      });
    });
    /* await future.apiRequestMasStaffgetByConAdv(map).then((onValue) {
      _searchResult = onValue.RESPONSE_DATA;
    });*/
    setState(() {});
    return true;
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        String title = _searchResult[index].TITLE_SHORT_NAME_TH.isNotEmpty ? _searchResult[index].TITLE_SHORT_NAME_TH : _searchResult[index].TITLE_NAME_TH;
        String position = _searchResult[index].OPREATION_POS_NAME != null ? _searchResult[index].OPREATION_POS_NAME : "";
        String level = _searchResult[index].OPREATION_POS_LAVEL_NAME != null ? _searchResult[index].OPREATION_POS_LAVEL_NAME : "";

        String office_name = "";
        if (_searchResult[index].OPERATION_OFFICE_SHORT_NAME != null) {
          if (_searchResult[index].OPERATION_OFFICE_SHORT_NAME.toString().isEmpty) {
            office_name = _searchResult[index].OPERATION_OFFICE_NAME;
          } else {
            office_name = _searchResult[index].OPERATION_OFFICE_SHORT_NAME;
          }
        } else {
          office_name = _searchResult[index].OPERATION_OFFICE_NAME;
        }
        return GestureDetector(
          onTap: () {
            setState(() {
              _searchResult[index].IsCheck = !_searchResult[index].IsCheck;
              int count = 0;
              _searchResult.forEach((f) {
                if (!f.IsCheck) {
                  count++;
                }
              });
              isChecking = count == _searchResult.length ? false : true;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
              padding: EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                  //color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: index == 0
                      ? Border(
                          top: BorderSide(color: Colors.grey[300], width: 1.0),
                          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )
                      : Border(
                          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: paddingLabel,
                          child: Text(
                            title + '' + _searchResult[index].FIRST_NAME + " " + _searchResult[index].LAST_NAME,
                            style: textInputStyleTitle,
                          ),
                        ),
                      ),
                      Center(
                          child: InkWell(
                        onTap: () {
                          setState(() {
                            _searchResult[index].IsCheck = !_searchResult[index].IsCheck;
                            int count = 0;
                            _searchResult.forEach((f) {
                              if (!f.IsCheck) {
                                count++;
                              }
                            });
                            isChecking = count == _searchResult.length ? false : true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: _searchResult[index].IsCheck ? Color(0xff3b69f3) : Colors.white,
                            border: _searchResult[index].IsCheck ? Border.all(color: Color(0xff3b69f3), width: 2) : Border.all(color: Colors.grey[400], width: 2),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: _searchResult[index].IsCheck
                                  ? Icon(
                                      Icons.check,
                                      size: 18.0,
                                      color: Colors.white,
                                    )
                                  : Container(
                                      height: 18.0,
                                      width: 18.0,
                                      color: Colors.transparent,
                                    )),
                        ),
                      )),
                    ],
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      "ตำแหน่ง : " + position + level,
                      style: textInputStyleSub,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: paddingInputBox,
                          child: Text(
                            "หน่วยงาน : " + office_name,
                            style: textInputStyleSub,
                          ),
                        ),
                      ),
                      /*_searchResult[index].IsCheck ? Center(
                        child: InkWell(
                          onTap: () {
                            _searchResult[index].IsCheck ? _navigateEdit(
                                context, _searchResult[index], index) : null;
                          },
                          child: Container(
                              child: Text("แก้ไข",
                                style: _searchResult[index].IsCheck
                                    ? textLabelEditCheckedStyle
                                    : textLabelEditNonCheckStyle,)
                          ),
                        )
                    ) : Container(),*/
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottom() {
    var size = MediaQuery.of(context).size;
    bool isCheck = false;
    _countItem = 0;
    _searchResult.forEach((item) {
      if (item.IsCheck)
        setState(() {
          isCheck = item.IsCheck;
          _countItem++;
        });
    });
    return isCheck
        ? Container(
            width: size.width,
            height: 65,
            color: Color(0xff2e76bc),
            child: MaterialButton(
              onPressed: () {
                _searchResult.forEach((item) {
                  if (item.IsCheck) _itemsData.add(item);
                });
                _itemsData.forEach((item) {
                  item.IsCreated = false;
                });

                Navigator.pop(context, _itemsData);
              },
              child: Center(
                child: Text(
                  'เลือก (${_countItem})',
                  style: textStyleButton,
                ),
              ),
            ),
          )
        : null;
  }

  _navigateCreate(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest3Create(
                Items: null,
                IsUpdate: false,
                itemsTitle: widget.itemsTitle,
              )),
    );
    if (!result.toString().endsWith("Back")) {
      Navigator.pop(context, result);
    }
  }

  _navigateEdit(BuildContext context, ItemsListArrestStaff items, index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest3Create(
                Items: items,
                IsUpdate: true,
                ItemsMain: widget.ItemsMain,
                itemsTitle: widget.itemsTitle,
              )),
    );
    _searchResult[index] = result;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: new Theme(
        data: new ThemeData(primaryColor: Colors.white, accentColor: Colors.white, hintColor: Colors.grey[400]),
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              title: new Padding(
                padding: EdgeInsets.only(right: 0.0),
                child: new TextField(
                  style: styleTextSearch,
                  controller: controller,
                  focusNode: myFocusNodeSearch,
                  decoration: new InputDecoration(
                    hintText: "ค้นหา",
                    hintStyle: styleTextSearch,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]),
                    ),
                  ),
                  onSubmitted: (String text) {
                    onSearchTextSubmitted(text, context);
                  },
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
              // actions: <Widget>[
              //   new Center(
              //       child: isChecking
              //           ? Container()
              //           : new FlatButton(
              //               onPressed: () {
              //                 _navigateCreate(context);
              //               },
              //               child: new Text("สร้าง", style: textStyleCreate),
              //             )),
              // ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              BackgroundContent(),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          //color: Colors.grey[200],
                          border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          /*Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text('ILG60_B_01_00_09_00',
                        style: textStylePageName,),
                    )*/
                        ],
                      ),
                    ),
                    Expanded(
                      child: _searchResult.length != 0 || controller.text.isNotEmpty ? _buildSearchResults() : new Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: _buildBottom(),
        ),
      ),
    );
  }
}
