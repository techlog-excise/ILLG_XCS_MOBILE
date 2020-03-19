import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_indictment_detail.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_evidence.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_mapping.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class TabScreenArrest6Section extends StatefulWidget {
  String Title;
  List ItemsLawbreaker;
  List ItemsProduct;
  ItemsListArrest6Section ItemsSection;
  bool IsUpdate;
  TabScreenArrest6Section({
    Key key,
    @required this.Title,
    @required this.ItemsLawbreaker,
    @required this.ItemsSection,
    @required this.ItemsProduct,
    @required this.IsUpdate,
  }) : super(key: key);
  @override
  _TabScreenArrest6SectionState createState() => new _TabScreenArrest6SectionState();
}

class _TabScreenArrest6SectionState extends State<TabScreenArrest6Section> {
  TabController tabController;
  TextEditingController controller = new TextEditingController();
  int _countItem = 0;
  List _itemsData = [];
  List<bool> _value = [];
  bool isCheckAll = false;

  List ItemsSuspect = [];

  ItemsListArrestIndictmentDetail _tempItemsIndicment;

  @override
  void initState() {
    super.initState();

    ItemsSuspect = widget.ItemsLawbreaker;

    if (!widget.IsUpdate) {
      widget.ItemsLawbreaker.forEach((item) {
        item.IsCheckOffence = false;
      });
    } else {
      int count = 0;
      ItemsSuspect.forEach((ev) {
        if (ev.IsCheckOffence) {
          count++;
        }
      });
      count == ItemsSuspect.length ? isCheckAll = true : isCheckAll = false;
    }
    /*widget.ItemsLawbreaker.forEach((item){
      item.IsCheckOffence=false;
    });*/
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Colors.grey[500];
    Color labelPreview = Color(0xff2e76bc);
    TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    TextStyle textInputStyleSub = TextStyle(fontSize: 14.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    TextStyle textPreviewStyle = TextStyle(fontSize: 14.0, color: labelPreview, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return ListView.builder(
      itemCount: ItemsSuspect.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              ItemsSuspect[index].IsCheckOffence = !ItemsSuspect[index].IsCheckOffence;

              int count = 0;
              ItemsSuspect.forEach((ev) {
                if (ev.IsCheckOffence) {
                  count++;
                }
              });
              count == ItemsSuspect.length ? isCheckAll = true : isCheckAll = false;
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
                            ItemsSuspect[index].PERSON_TYPE == 0
                                ? (ItemsSuspect[index].TITLE_SHORT_NAME_TH != null ? ItemsSuspect[index].TITLE_SHORT_NAME_TH.toString() : ItemsSuspect[index].TITLE_NAME_TH.toString()) + " " + ItemsSuspect[index].FIRST_NAME + " " + ItemsSuspect[index].LAST_NAME
                                : ItemsSuspect[index].PERSON_TYPE == 1
                                    ? (ItemsSuspect[index].TITLE_SHORT_NAME_EN != null ? ItemsSuspect[index].TITLE_SHORT_NAME_EN.toString() : ItemsSuspect[index].TITLE_NAME_EN.toString()) + " " + ItemsSuspect[index].FIRST_NAME + " " + ItemsSuspect[index].LAST_NAME
                                    : (ItemsSuspect[index].TITLE_SHORT_NAME_TH != null ? ItemsSuspect[index].TITLE_SHORT_NAME_TH.toString() : ItemsSuspect[index].TITLE_NAME_TH.toString()) + ItemsSuspect[index].COMPANY_NAME.toString(),
                            style: textInputStyleTitle,
                          ),
                        ),
                      ),
                      Center(
                          child: InkWell(
                        onTap: () {
                          setState(() {
                            ItemsSuspect[index].IsCheckOffence = !ItemsSuspect[index].IsCheckOffence;

                            int count = 0;
                            ItemsSuspect.forEach((ev) {
                              if (ev.IsCheckOffence) {
                                count++;
                              }
                            });
                            count == ItemsSuspect.length ? isCheckAll = true : isCheckAll = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: ItemsSuspect[index].IsCheckOffence ? Color(0xff3b69f3) : Colors.white,
                            border: ItemsSuspect[index].IsCheckOffence ? Border.all(color: Color(0xff3b69f3), width: 2) : Border.all(color: Colors.grey[400], width: 2),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: ItemsSuspect[index].IsCheckOffence
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
                  ItemsSuspect[index].MISTREAT_NO == 0
                      ? Padding(
                          padding: paddingInputBox,
                          child: Text(
                            "ยังไม่เคยกระทำผิด " + ItemsSuspect[index].MISTREAT_NO.toString() + " ครั้ง",
                            style: textInputStyleSub,
                          ),
                        )
                      : Padding(
                          padding: paddingInputBox,
                          child: Text(
                            "จำนวนครั้งการกระทำผิด " + ItemsSuspect[index].MISTREAT_NO.toString() + " ครั้ง",
                            style: textInputStyleSub,
                          ),
                        ),
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
    TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: FontStyles().FontFamily);
    bool isCheck = false;
    _countItem = 0;
    ItemsSuspect.forEach((item) {
      if (item.IsCheckOffence)
        setState(() {
          isCheck = item.IsCheckOffence;
          _countItem++;
        });
    });
    print(ItemsSuspect.length.toString() + ", " + widget.ItemsProduct.length.toString());

    return Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {
          _itemsData = [];
          for (int i = 0; i < ItemsSuspect.length; i++) {
            if (ItemsSuspect[i].IsCheckOffence) {
              ItemsSuspect[i].INDEX = i;
              _itemsData.add(ItemsSuspect[i]);
              print(ItemsSuspect[i].FIRST_NAME);
            }
          }
          List _id = [];
          _itemsData.forEach((item) {
            _id.add(item.PERSON_ID);
          });
          var _removeDupicate = _id.toSet().toList();
          List ItemsAll = [];
          for (int i = 0; i < _removeDupicate.length; i++) {
            for (int j = 0; j < _itemsData.length; j++) {
              if (_removeDupicate[i] == _itemsData[j].PERSON_ID) {
                ItemsAll.add(_itemsData[j]);
                break;
              }
            }
          }
          widget.ItemsSection.ArrestIndictmentDetail = ItemsAll;
          widget.ItemsSection.ArrestIndictmentProduct = [];

          widget.ItemsProduct.length > 0 ? _navigateEvidence(context) : Navigator.pop(context, widget.ItemsSection);
        },
        child: Center(
          child: widget.ItemsProduct.length > 0
              ? (Text(
                  _countItem == 0 ? 'ถัดไป' : 'ถัดไป (${_countItem})',
                  style: textStyleButton,
                ))
              : Text(
                  'ตกลง (${_countItem})',
                  style: textStyleButton,
                ),
        ),
      ),
    );
  }

  _navigateEvidence(BuildContext context) async {
    var result;
    if (widget.ItemsProduct.length == 0) {
      // ====================== มีคนและไม่มีของ ====================
      widget.ItemsSection.ArrestIndictmentProduct = [];
      result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest6Mapping(
                  Title: widget.Title,
                  ItemsData: widget.ItemsSection,
                )),
      );
    } else {
      // ====================== มีคนและมีของ ======================
      result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest6Evidence(
                  IsUpdate: widget.IsUpdate,
                  Title: widget.Title,
                  ItemsData: widget.ItemsSection,
                  ItemsProduct: widget.ItemsProduct,
                )),
      );
    }
    //print("result section: "+result.toString());
    if (result.toString() != "back") {
      //_itemsData = result;
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    Color labelColor = Color(0xff2e76bc);
    TextStyle textInputStyleCheckAll = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    var size = MediaQuery.of(context).size;
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: new Text(
                widget.Title,
                style: styleTextAppbar,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //height: 34.0,
                    decoration: BoxDecoration(
                        //color: Colors.grey[200],
                        border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                    )),
                    /*child: Column(
                    children: <Widget>[Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: new Text('ILG60_B_01_00_25_00',
                            style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
                        ),
                      ],
                    ),
                    ],
                  )*/
                  ),
                  widget.ItemsLawbreaker.length == 0
                      ? Container()
                      : Container(
                          padding: EdgeInsets.only(left: 22.0, right: 22.0, bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "เลือกผู้ต้องหาทั้งหมด",
                                  style: textInputStyleCheckAll,
                                ),
                                padding: EdgeInsets.all(8.0),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isCheckAll = !isCheckAll;
                                    if (isCheckAll) {
                                      ItemsSuspect.forEach((item) {
                                        item.IsCheckOffence = true;
                                      });
                                    } else {
                                      ItemsSuspect.forEach((item) {
                                        item.IsCheckOffence = false;
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: isCheckAll ? Color(0xff3b69f3) : Colors.grey[200],
                                    border: isCheckAll ? Border.all(color: Color(0xff3b69f3), width: 2) : Border.all(color: Colors.grey[400], width: 2),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: isCheckAll
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
                              )
                            ],
                          ),
                        ),
                  Expanded(
                    child: _buildContent(context),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ItemsSuspect.length == 0 && widget.ItemsProduct.length == 0 ? null : _buildBottom(),
      ),
    );
  }
}
