import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_controller.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_indictment.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_indictment_detail.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product_mapping.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_mapping.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_product.dart';
import 'package:prototype_app_pang/model/SetProductName.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:intl/intl.dart';

class TabScreenArrest6Evidence extends StatefulWidget {
  String Title, Detail;
  ItemsListArrest6Section ItemsData;
  List ItemsProduct;
  bool IsUpdate;
  TabScreenArrest6Evidence({
    Key key,
    @required this.Title,
    @required this.Detail,
    @required this.ItemsData,
    @required this.ItemsProduct,
    @required this.IsUpdate,
  }) : super(key: key);
  @override
  _TabScreenArrest6EvidenceState createState() => new _TabScreenArrest6EvidenceState();
}

class _TabScreenArrest6EvidenceState extends State<TabScreenArrest6Evidence> {
  List _itemsInit = [];
  List _itemsDataSelect = [];
  int _countItem = 0;
  bool isCheckAll = false;

  ItemsListArrestIndictmentDetail _temp;

  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textErrorStyle = TextStyle(fontSize: 14.0, color: Colors.red, fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  final formatter = new NumberFormat("#,##0.000");

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    _itemsInit = widget.ItemsProduct;

    if (!widget.IsUpdate) {
      widget.ItemsProduct.forEach((item) {
        item.IsCheckOffence = false;
      });
    } else {
      int count = 0;
      _itemsInit.forEach((ev) {
        if (ev.IsCheckOffence) {
          count++;
        }
      });
      count == _itemsInit.length ? isCheckAll = true : isCheckAll = false;
    }

    if (_itemsInit != null) {
      _itemsInit.forEach((item) {
        item.Arrest6Controller.editQuantity.text = (item.QUANTITY.toInt()).toString();

        if (item.PRODUCT_GROUP_ID == 13 || item.PRODUCT_GROUP_ID == 2) {
          item.Arrest6Controller.editVolume.text = formatter.format(item.VOLUMN).toString();
        } else {
          item.Arrest6Controller.editVolume.text = item.VOLUMN.toString();
        }

        item.Arrest6Controller.editQuantityUnit.text = item.QUANTITY_UNIT.toString();
        item.Arrest6Controller.editVolumeUnit.text = item.VOLUMN_UNIT.toString();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    /*if(_itemsInit!=null){
      _itemsInit.forEach((item) {
        item.Arrest6Controller.myFocusNodeFine.dispose();
        item.Arrest6Controller.myFocusNodeSize.dispose();
        item.Arrest6Controller.myFocusNodeQuantity.dispose();
        item.Arrest6Controller.myFocusNodeVolume.dispose();
        item.Arrest6Controller.myFocusNodeQuantityUnit.dispose();
        item.Arrest6Controller.myFocusNodeVolumeUnit.dispose();
      });
    }*/
  }

  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(bottom: MediaQuery.of(context).viewInsets.bottom, right: 0.0, left: 0.0, child: InputDoneView());
    });

    overlayState.insert(overlayEntry);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  Widget _buildSearchResults() {
    TextStyle textLabelEditNonCheckStyle = TextStyle(fontSize: 16.0, color: Colors.red[100], fontFamily: FontStyles().FontFamily);
    TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 40) / 100;

    return ListView.builder(
      itemCount: _itemsInit.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        bool _validate = false;

        return GestureDetector(
          onTap: () {
            setState(() {
              _itemsInit[index].IsCheckOffence = !_itemsInit[index].IsCheckOffence;

              int count = 0;
              _itemsInit.forEach((ev) {
                if (ev.IsCheckOffence) {
                  count++;
                }
              });
              count == _itemsInit.length ? isCheckAll = true : isCheckAll = false;
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
                            _itemsInit[index].PRODUCT_DESC.toString(),
                            style: textInputStyleTitle,
                          ),
                        ),
                      ),
                      Center(
                          child: InkWell(
                        onTap: () {
                          setState(() {
                            _itemsInit[index].IsCheckOffence = !_itemsInit[index].IsCheckOffence;

                            int count = 0;
                            _itemsInit.forEach((ev) {
                              if (ev.IsCheckOffence) {
                                count++;
                              }
                            });
                            count == _itemsInit.length ? isCheckAll = true : isCheckAll = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: _itemsInit[index].IsCheckOffence ? Color(0xff3b69f3) : Colors.white,
                            border: _itemsInit[index].IsCheckOffence ? Border.all(color: Color(0xff3b69f3), width: 2) : Border.all(color: Colors.grey[400], width: 2),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: _itemsInit[index].IsCheckOffence
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
                  _itemsInit[index].IsCheckOffence
                      ? Container(
                          padding: EdgeInsets.only(top: 12),
                          child: Container(
                            //width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: ((size.width * 75) / 100) / 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: paddingLabel,
                                            child: Text(
                                              "จำนวน",
                                              style: textLabelStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: paddingInputBox,
                                            child: TextField(
                                              focusNode: _itemsInit[index].Arrest6Controller.myFocusNodeQuantity,
                                              controller: _itemsInit[index].Arrest6Controller.editQuantity,
                                              keyboardType: TextInputType.number,
                                              textCapitalization: TextCapitalization.words,
                                              style: textInputStyle,
                                              decoration: InputDecoration(border: InputBorder.none, errorText: _itemsInit[index].Arrest6Controller.isErrorQuantity ? "ห้ามเกินจำนวนที่ระบุมา" : "", errorStyle: textErrorStyle),
                                              onChanged: (text) {
                                                double qauntity = double.parse(text);
                                                if (qauntity <= _itemsInit[index].QUANTITY) {
                                                  /*double volumn = qauntity *
                                              _itemsInit[index].SIZES;
                                          _itemsInit[index]
                                              .Arrest6Controller.editVolume
                                              .text = volumn.toString();*/

                                                  setState(() {
                                                    _itemsInit[index].Arrest6Controller.isErrorQuantity = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    _itemsInit[index].Arrest6Controller.isErrorQuantity = true;
                                                  });
                                                }
                                              },
                                              /*onSubmitted: (text){
                                        double qauntity = double.parse(text);
                                        if(qauntity<=_itemsInit[index].QUANTITY) {
                                          double volumn = qauntity *
                                              _itemsInit[index].SIZES;
                                          _itemsInit[index]
                                              .Arrest6Controller.editVolume
                                              .text = volumn.toString();
                                        }else{
                                          _validate = true;
                                        }
                                      },*/
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
                                            height: 1.0,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: ((size.width * 75) / 100) / 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: paddingLabel,
                                            child: Text(
                                              "หน่วย",
                                              style: textLabelStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: paddingInputBox,
                                            child: TextField(
                                              enabled: false,
                                              focusNode: _itemsInit[index].Arrest6Controller.myFocusNodeQuantityUnit,
                                              controller: _itemsInit[index].Arrest6Controller.editQuantityUnit,
                                              keyboardType: TextInputType.number,
                                              textCapitalization: TextCapitalization.words,
                                              style: textInputStyle,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: ((size.width * 75) / 100) / 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: paddingLabel,
                                            child: Text(
                                              "ปริมาณสุทธิ",
                                              style: textLabelStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: paddingInputBox,
                                            child: TextField(
                                              focusNode: _itemsInit[index].Arrest6Controller.myFocusNodeVolume,
                                              controller: _itemsInit[index].Arrest6Controller.editVolume,
                                              keyboardType: TextInputType.number,
                                              textCapitalization: TextCapitalization.words,
                                              style: textInputStyle,
                                              decoration: InputDecoration(border: InputBorder.none, errorText: _itemsInit[index].Arrest6Controller.isErrorVolume ? "ห้ามเกินปริมาณที่ระบุมา" : "", errorStyle: textErrorStyle),
                                              onChanged: (text) {
                                                double volume = double.parse(text);
                                                if (volume <= _itemsInit[index].VOLUMN) {
                                                  setState(() {
                                                    _itemsInit[index].Arrest6Controller.isErrorVolume = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    _itemsInit[index].Arrest6Controller.isErrorVolume = true;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
                                            height: 1.0,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: ((size.width * 75) / 100) / 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: paddingLabel,
                                            child: Text(
                                              "หน่วย",
                                              style: textLabelStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: paddingInputBox,
                                            child: TextField(
                                              enabled: false,
                                              focusNode: _itemsInit[index].Arrest6Controller.myFocusNodeVolumeUnit,
                                              controller: _itemsInit[index].Arrest6Controller.editVolumeUnit,
                                              keyboardType: TextInputType.number,
                                              textCapitalization: TextCapitalization.words,
                                              style: textInputStyle,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ), /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Container(
                        width: Width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                _navigateEdit(context, _itemsInit[index]);
                              },
                              child: Container(
                                  child: Text(
                                    "แก้ไข", style: textLabelEditNonCheckStyle,)
                              ),
                            ),
                          ],
                        )
                      )
                    ],
                  ),*/
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _navigateEdit(BuildContext context, item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest6Product(
                ItemsProductEdit: item,
                IsComplete: false,
              )),
    );
    setState(() {
      _itemsDataSelect = result;
    });
  }

  Widget _buildBottom() {
    var size = MediaQuery.of(context).size;
    TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: FontStyles().FontFamily);
    bool isCheck = false;
    bool IsLawbreaker = false;
    if (widget.ItemsData.ArrestIndictmentDetail.length > 0) {
      IsLawbreaker = true;
      isCheck = true;
    }
    _countItem = 0;
    _itemsInit.forEach((item) {
      if (item.IsCheckOffence)
        setState(() {
          isCheck = item.IsCheckOffence;
          _countItem++;
        });
    });
    int isProve = widget.ItemsData.IS_PROVE;
    print("isProve: $isProve");

    return isCheck
        ? Container(
            // isCheck คือได้เลือกผู้ต้องหามั้ย
            width: size.width,
            height: 65,
            color: Color(0xff2e76bc),
            child: MaterialButton(
              onPressed: () {
                double fine = 0;
                bool isErrorQuantity = false;
                bool isErrorVolume = false;
                //new item product
                _itemsDataSelect = [];
                for (int i = 0; i < _itemsInit.length; i++) {
                  if (_itemsInit[i].IsCheckOffence) {
                    isErrorQuantity = _itemsInit[i].Arrest6Controller.isErrorQuantity;
                    isErrorVolume = _itemsInit[i].Arrest6Controller.isErrorVolume;
                    if (isErrorQuantity || isErrorVolume) {
                      break;
                    }

                    _itemsInit[i].QUANTITY = double.parse(_itemsInit[i].Arrest6Controller.editQuantity.text.replaceAll(",", ""));
                    _itemsInit[i].VOLUMN = double.parse(_itemsInit[i].Arrest6Controller.editVolume.text.replaceAll(",", ""));
                    _itemsInit[i].INDEX = i;
                    _itemsDataSelect.add(_itemsInit[i]);
                  }
                }
                if (!isErrorQuantity && !isErrorVolume) {
                  if (isProve == 1 && _countItem == 0) {
                    new VerifyDialog(context, 'กรุณาเลือกของกลาง');
                  } else {
                    widget.ItemsData.ArrestIndictmentProduct = _itemsDataSelect;
                    Navigator.pop(context, widget.ItemsData);
                    //_navigateMapping(context);
                  }
                }
              },
              child: Center(
                // มีเงื่อนไขว่าต้องกดเลือกของกลางในมาตรา
                child: Text(
                  _countItem == 0 ? 'ตกลง' : 'ตกลง (${_countItem})',
                  style: textStyleButton,
                ),
              ),
            ),
          )
        : null;
  }

  _navigateMapping(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest6Mapping(
                Title: widget.Title,
                ItemsData: widget.ItemsData,
              )),
    );
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
                        child: new Text('ILG60_B_01_00_26_00',
                          style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
                      ),
                    ],
                  ),
                  ],
                )*/
                  ),
                  widget.ItemsProduct.length == 0
                      ? Container()
                      : Container(
                          padding: EdgeInsets.only(left: 22.0, right: 22.0, bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "เลือกของกลางทั้งหมด",
                                  style: textInputStyleCheckAll,
                                ),
                                padding: EdgeInsets.all(8.0),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isCheckAll = !isCheckAll;
                                    if (isCheckAll) {
                                      _itemsInit.forEach((item) {
                                        item.IsCheckOffence = true;
                                      });
                                    } else {
                                      _itemsInit.forEach((item) {
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
                    child: new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: _buildSearchResults(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottom(),
      ),
    );
  }

  String validatePassword(String value, int quantity) {
    if ((int.parse(value) > quantity) && value.isNotEmpty) {
      return "อย่ากรอกเกิน!!";
    }
    return null;
  }
}
