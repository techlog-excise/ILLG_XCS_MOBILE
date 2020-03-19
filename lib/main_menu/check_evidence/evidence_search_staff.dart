import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_staff.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

import 'model/evidence_get_staff.dart';

class TabScreenSearchStaff extends StatefulWidget {
  int CONTRIBUTOR_ID;
  TabScreenSearchStaff({
    Key key,
    @required this.CONTRIBUTOR_ID,
    /*@required this.itemsTitle,*/
  }) : super(key: key);
  @override
  _TabScreenArrest3SearchState createState() => new _TabScreenArrest3SearchState();
}
class _TabScreenArrest3SearchState extends State<TabScreenSearchStaff> {
  TabController tabController;
  TextEditingController controller = new TextEditingController();
  final FocusNode myFocusNodeSearch = FocusNode();
  List<ItemsListArrestStaff> _searchResult = [];
  int _countItem = 0;
  ItemsListEvidenceGetStaff _itemsData;
  List<bool> _value = [];
  bool isChecking = false;

  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleSub = TextStyle(fontSize: 14.0,
      color: Colors.grey[500],
      fontFamily: FontStyles().FontFamily);
  TextStyle textLabelEditCheckedStyle = TextStyle(
      fontSize: 16.0, color: Colors.red, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelEditNonCheckStyle = TextStyle(fontSize: 16.0,
      color: Colors.red[100],
      fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButton = TextStyle(
      color: Colors.white, fontSize: 18.0, fontFamily: FontStyles().FontFamily);
  TextStyle styleTextSearch = TextStyle(
      fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleCreate = TextStyle(color: Color(0xff087de1),
      fontSize: 18.0,
      fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      fontSize: 12.0,
      color: Colors.grey[400],
      fontFamily: FontStyles().FontFamily);
  TextStyle textCheckAllStyle = TextStyle(fontSize: 16.0,
      color: Color(0xff2e76bc),
      fontFamily: FontStyles().FontFamily);


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
            child: CupertinoActivityIndicator(
            ),
          );
        });
    /* Map mapGetByCon={
      "TEXT_SEARCH" : controller.text,
      "STAFF_ID" : 9
    };*/
    Map mapGetByCon = {
      "TEXT_SEARCH" : text,
      "STAFF_ID" : ""
    };
    await onLoadActionInsStaff(mapGetByCon);
    Navigator.pop(context);
    if (_searchResult.length == 0) {
      new EmptyDialog(context,"ไม่พบข้อมูล");
    }
  }

  ArrestFuture future = new ArrestFuture();

  Future<bool> onLoadActionInsStaff(Map map) async {
    /*await future.apiRequestMasStaffgetByCon(map).then((onValue) {
      _searchResult = onValue.RESPONSE_DATA;
    });*/
    await future.apiRequestMasStaffgetByCon(map).then((onValue) {
      List<ItemsListArrestStaff> items = [];
      onValue.RESPONSE_DATA.forEach((item){
        if(item.STAFF_TYPE==1){
          items.add(item);
        }
      });
      _searchResult = items;
    });
    setState(() {});
    return true;
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        String title = _searchResult[index].TITLE_SHORT_NAME_TH.isNotEmpty
            ? _searchResult[index].TITLE_SHORT_NAME_TH
            : _searchResult[index].TITLE_NAME_TH;
        String position = _searchResult[index].OPREATION_POS_NAME != null
            ? _searchResult[index].OPREATION_POS_NAME
            : "";
        String level = _searchResult[index].OPREATION_POS_LAVEL_NAME != null
            ? _searchResult[index].OPREATION_POS_LAVEL_NAME
            : "";
        String office_name = _searchResult[index].OPERATION_OFFICE_SHORT_NAME !=
            null
            ? _searchResult[index].OPERATION_OFFICE_SHORT_NAME
            : _searchResult[index].OPERATION_OFFICE_NAME;
        return GestureDetector(
          onTap: (){
            setState(() {
              _searchResult[index].IsCheck =
              !_searchResult[index].IsCheck;
              for (int i = 0; i < _searchResult.length; i++) {
                if (i != index) {
                  _searchResult[i].IsCheck = false;
                }
              }
            });
          },
          child: Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
              padding: EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                //color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: index == 0 ? Border(
                    top: BorderSide(color: Colors.grey[300], width: 1.0),
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  ) : Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
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
                            title + '' + _searchResult[index].FIRST_NAME + " " +
                                _searchResult[index].LAST_NAME,
                            style: textInputStyleTitle,),
                        ),
                      ),
                      Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _searchResult[index].IsCheck =
                                !_searchResult[index].IsCheck;
                                for (int i = 0; i < _searchResult.length; i++) {
                                  if (i != index) {
                                    _searchResult[i].IsCheck = false;
                                  }
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _searchResult[index].IsCheck
                                    ? Color(0xff3b69f3)
                                    : Colors.white,
                                border: _searchResult[index].IsCheck
                                    ? Border.all(
                                    color: Color(0xff3b69f3), width: 2)
                                    : Border.all(
                                    color: Colors.grey[400], width: 2),
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
                                  )
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      "ตำแหน่ง : " + position + level, style: textInputStyleSub,),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: paddingInputBox,
                          child: Text(
                            "หน่วยงาน : " + office_name,
                            style: textInputStyleSub,),
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
    var size = MediaQuery
        .of(context)
        .size;
    bool isCheck = false;
    _countItem = 0;
    _searchResult.forEach((item) {
      if (item.IsCheck)
        setState(() {
          isCheck = item.IsCheck;
          _countItem++;
        });
    });
    return isCheck ? Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {
          _searchResult.forEach((item) {
            if (item.IsCheck)
              _itemsData = new ItemsListEvidenceGetStaff(
                  STAFF_ID: item.STAFF_ID,
                  STAFF_TYPE: item.STAFF_TYPE,
                  STAFF_CODE: item.STAFF_CODE,
                  STAFF_REF_ID: item.STAFF_REF_ID,
                  ID_CARD: item.ID_CARD,
                  TITLE_ID: item.TITLE_ID,
                  TITLE_NAME_TH: item.TITLE_NAME_TH,
                  TITLE_SHORT_NAME_TH: item.TITLE_SHORT_NAME_TH,
                  FIRST_NAME: item.FIRST_NAME,
                  LAST_NAME: item.LAST_NAME,
                  OPREATION_POS_NAME: item.OPREATION_POS_NAME,
                  OPREATION_POS_LAVEL_NAME: item.OPREATION_POS_LAVEL_NAME,
                  OPERATION_OFFICE_CODE: item.OPERATION_OFFICE_CODE,
                  OPERATION_OFFICE_NAME: item.OPERATION_OFFICE_NAME,
                  OPERATION_OFFICE_SHORT_NAME: item.OPERATION_OFFICE_SHORT_NAME,
                  BIRTH_DATE: item.BIRTH_DATE,
                  OPERATION_POS_CODE: item.OPERATION_POS_CODE,
                  OPREATION_POS_LEVEL: item.OPREATION_POS_LEVEL,
                  OPERATION_POS_LEVEL_NAME: item.OPERATION_POS_LEVEL_NAME,
                  OPERATION_DEPT_CODE: item.OPERATION_DEPT_CODE,
                  OPERATION_DEPT_NAME: item.OPERATION_DEPT_NAME,
                  OPERATION_DEPT_LEVEL: item.OPERATION_DEPT_LEVEL,
                  OPERATION_UNDER_DEPT_CODE: item.OPERATION_UNDER_DEPT_CODE,
                  OPERATION_UNDER_DEPT_NAME: item.OPERATION_UNDER_DEPT_NAME,
                  OPERATION_UNDER_DEPT_LEVEL: item.OPERATION_UNDER_DEPT_LEVEL,
                  OPERATION_WORK_DEPT_CODE: item.OPERATION_WORK_DEPT_CODE,
                  OPERATION_WORK_DEPT_NAME: item.OPERATION_WORK_DEPT_NAME,
                  OPERATION_WORK_DEPT_LEVEL: item.OPERATION_WORK_DEPT_LEVEL,

                  CONTRIBUTOR_ID: widget.CONTRIBUTOR_ID,
                  IsCheck: item.IsCheck);
          });
          Navigator.pop(context, _itemsData);
        },
        child: Center(
          child: Text('เลือก (${_countItem})', style: textStyleButton,),
        ),
      ),
    ) : null;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: new Theme(
        data: new ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.white,
            hintColor: Colors.grey[400]
        ),
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
                  icon: Icon(Icons.arrow_back_ios,), onPressed: () {
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          //color: Colors.grey[200],
                          border: Border(
                            top: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                            //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                          )
                      ),
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
                      child: _searchResult.length != 0 ||
                          controller.text.isNotEmpty
                          ? _buildSearchResults() : new Container(),
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
