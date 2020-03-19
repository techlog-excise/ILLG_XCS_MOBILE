import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_staff.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_title.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class TabScreenArrest3Create extends StatefulWidget {
  ItemsListArrestMain ItemsMain;
  ItemsListArrestStaff Items;
  ItemsMasterTitleResponse itemsTitle;
  bool IsUpdate;
  TabScreenArrest3Create({
    Key key,
    @required this.ItemsMain,
    @required this.Items,
    @required this.IsUpdate,
    @required this.itemsTitle,
  }) : super(key: key);
  @override
  _TabScreenArrest3CreateState createState() => new _TabScreenArrest3CreateState();
}

class _TabScreenArrest3CreateState extends State<TabScreenArrest3Create> {
  TabController tabController;
  TextEditingController controller = new TextEditingController();
  ItemsListArrestStaff _searchResult;

  GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();

  final FocusNode myFocusNodeIdentifyNumber = FocusNode();
  final FocusNode myFocusNodeFirstName = FocusNode();
  final FocusNode myFocusNodeLastName = FocusNode();
  final FocusNode myFocusNodePosition = FocusNode();
  final FocusNode myFocusNodeUnder = FocusNode();

  TextEditingController editIdentifyNumber = new TextEditingController();
  TextEditingController editFirstName = new TextEditingController();
  TextEditingController editLastName = new TextEditingController();
  TextEditingController editPosition = new TextEditingController();
  TextEditingController editUnder = new TextEditingController();

  ItemsListTitle _title;
  int titleType = 1;

  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily, color: Colors.white);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  TextStyle textStyleStar = Styles.textStyleStar;

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  List<ItemsListArrestStaff> itemsStaff = [];

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    // if (Platform.isAndroid) {
    //   // Android-specific code
    // } else if (Platform.isIOS) {
    //   KeyboardVisibilityNotification().addNewListener(onShow: () {
    //     showOverlay(context);
    //   }, onHide: () {
    //     removeOverlay();
    //   });
    // }
    //print("STAFF_REF_ID : "+widget.Items.STAFF_REF_ID.toString());

    if (widget.Items != null) {
      print(widget.Items.ID_CARD);
      editIdentifyNumber.text = widget.Items.ID_CARD;
      editFirstName.text = widget.Items.FIRST_NAME;
      editLastName.text = widget.Items.LAST_NAME;
      editPosition.text = widget.Items.OPREATION_POS_NAME;
      editUnder.text = widget.Items.OPERATION_OFFICE_NAME;
    }
    setAutoCompleteTitle();

    if (widget.IsUpdate) {
      String title = widget.Items.TITLE_SHORT_NAME_TH;
      for (int i = 0; i < widget.itemsTitle.RESPONSE_DATA.length; i++) {
        String sTitle = widget.itemsTitle.RESPONSE_DATA[i].TITLE_SHORT_NAME_TH == null ? widget.itemsTitle.RESPONSE_DATA[i].TITLE_NAME_TH : widget.itemsTitle.RESPONSE_DATA[i].TITLE_SHORT_NAME_TH;
        if (sTitle.endsWith(title)) {
          _title = widget.itemsTitle.RESPONSE_DATA[i];
          editTitle.text = _title.TITLE_SHORT_NAME_TH != null ? _title.TITLE_SHORT_NAME_TH : _title.TITLE_NAME_TH;
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNodeIdentifyNumber.dispose();
    myFocusNodeFirstName.dispose();
    myFocusNodeLastName.dispose();
    myFocusNodePosition.dispose();
    myFocusNodeUnder.dispose();

    setDisposeAuto(_textLisTitle);
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

  void setDisposeAuto(AutoCompleteTextField item) {
    if (item.textField.focusNode == null) {
      item.textField.focusNode.dispose();
    }
    if (item.textField.controller == null) {
      item.textField.controller.dispose();
    }
  }

  bool checkID(PID) {
    if (PID.length != 13) return false;
    int sum = 0;
    for (int i = 0; i < 12; i++) {
      sum += int.parse(PID[i]) * (13 - i);
    }
    if ((11 - (sum % 11)) % 10 == int.parse(PID[12])) return true;
    return false;
  }

  AutoCompleteTextField _textLisTitle;
  TextEditingController editTitle = new TextEditingController();
  void setAutoCompleteTitle() {
    _textLisTitle = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textLisTitle.controller.text = item.TITLE_SHORT_NAME_TH.toString();
          _title = item;
        });
        if (!mounted) return;
      },
      key: key,
      controller: editTitle,
      suggestions: widget.itemsTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => _title == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.TITLE_SHORT_NAME_TH.toString(), style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        _title = null;
        return (suggestion.TITLE_SHORT_NAME_TH != null ? suggestion.TITLE_SHORT_NAME_TH : suggestion.TITLE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    var size = MediaQuery.of(context).size;
    //final double Width = (size.width * 80) / 100;
    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      //width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );

    return Container(
        padding: EdgeInsets.all(22.0),
        height: size.height,
        decoration: BoxDecoration(
            //color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              top: BorderSide(color: Colors.grey[300], width: 1.0),
              //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        width: size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
            //width: Width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "รหัสบัตรประชาชน",
                        style: textLabelStyle,
                      ),
                      Text(
                        "*",
                        style: textStyleStar,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: paddingInputBox,
                  child: TextField(
                    //maxLength: 14,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(13),
                    ],
                    focusNode: myFocusNodeIdentifyNumber,
                    controller: editIdentifyNumber,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                    style: textInputStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                _buildLine,
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "คำนำหน้าชื่อ",
                        style: textLabelStyle,
                      ),
                      Text(
                        "*",
                        style: textStyleStar,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  //padding: paddingInputBox,
                  child:
                      /*DropdownButtonHideUnderline(
                  child: DropdownButton<ItemsListTitle>(
                    isExpanded: true,
                    value: _title,
                    onChanged: (ItemsListTitle newValue) {
                      setState(() {
                        _title = newValue;
                      });
                    },
                    items: widget.itemsTitle.RESPONSE_DATA
                        .map<DropdownMenuItem<ItemsListTitle>>((ItemsListTitle value) {
                      return DropdownMenuItem<ItemsListTitle>(
                        value: value,
                        child: Text(value.TITLE_SHORT_NAME_TH==null?value.TITLE_NAME_TH:value.TITLE_SHORT_NAME_TH
                          ,style: textInputStyle,),
                      );
                    })
                        .toList(),
                  ),
                ),*/
                      _textLisTitle,
                ),
                _buildLine,
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "ชื่อ",
                        style: textLabelStyle,
                      ),
                      Text(
                        "*",
                        style: textStyleStar,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: paddingInputBox,
                  child: TextField(
                    focusNode: myFocusNodeFirstName,
                    controller: editFirstName,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    style: textInputStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                _buildLine,
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "นามสกุล",
                        style: textLabelStyle,
                      ),
                      Text(
                        "*",
                        style: textStyleStar,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: paddingInputBox,
                  child: TextField(
                    focusNode: myFocusNodeLastName,
                    controller: editLastName,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    style: textInputStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                _buildLine,
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "ตำแหน่ง",
                        style: textLabelStyle,
                      ),
                      Text(
                        "*",
                        style: textStyleStar,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: paddingInputBox,
                  child: TextField(
                    focusNode: myFocusNodePosition,
                    controller: editPosition,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    style: textInputStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                _buildLine,
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "หน่วยงาน",
                        style: textLabelStyle,
                      ),
                      Text(
                        "*",
                        style: textStyleStar,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: paddingInputBox,
                  child: TextField(
                    focusNode: myFocusNodeUnder,
                    controller: editUnder,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    style: textInputStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                _buildLine,
              ],
            ),
          ),
        ));
  }

  bool SUCCESS;
  ArrestFuture future = new ArrestFuture();
  Future<bool> onLoadActionInsStaff(Map map) async {
    SUCCESS = false;
    if (widget.IsUpdate) {
      print("IsUpdate : " + widget.IsUpdate.toString());
      print(map);

      await future.apiRequestMasStaffupdAll(map).then((onValue) {
        print("Upd Mas Staff : " + onValue.SUCCESS.toString());
        SUCCESS = onValue.SUCCESS;
      });
      if (SUCCESS) {
        Map mapGetByCon = {"TEXT_SEARCH": "", "STAFF_ID": widget.Items.STAFF_REF_ID != null ? widget.Items.STAFF_REF_ID : widget.Items.STAFF_ID};

        await future.apiRequestMasStaffgetByCon(mapGetByCon).then((onValue) {
          onValue.RESPONSE_DATA.forEach((item) {
            widget.Items = item;
            widget.Items.IsCheck = true;
            if (widget.Items.STAFF_TYPE == 0) {
              widget.Items.IsCreated = true;
            }
          });
          //Navigator.pop(context);
        });
      }
    } else {
      int RESPONSE_DATA;
      await future.apiRequestMasStaffinsAll(map).then((onValue) {
        SUCCESS = onValue.SUCCESS;
        if (onValue.SUCCESS) {
          RESPONSE_DATA = onValue.RESPONSE_DATA;
          print("Ins Staff : " + onValue.SUCCESS.toString() + " : " + onValue.RESPONSE_DATA.toString());
          //Navigator.pop(context);
        }
      });
      if (SUCCESS) {
        Map mapGetByCon = {"TEXT_SEARCH": "", "STAFF_ID": RESPONSE_DATA};
        await future.apiRequestMasStaffgetByCon(mapGetByCon).then((onValue) {
          itemsStaff = onValue.RESPONSE_DATA;
          itemsStaff.forEach((item) {
            if (item.STAFF_TYPE == 0) {
              item.IsCreated = true;
            }
          });
          //Navigator.pop(context);
        });
      }
    }
    //Navigator.pop(context);
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionupdByCon(List<Map> map) async {
    SUCCESS = false;
    if (widget.IsUpdate) {
      await future.apiRequestArrestStaffupdByCon(map).then((onValue) {
        print("Upd Arrest Staff : " + onValue.IsSuccess.toString() + " : " + onValue.Msg);
        SUCCESS = true;
      });
      if (SUCCESS) {
        Map mapGetByCon = {"TEXT_SEARCH": "", "STAFF_ID": widget.Items.STAFF_REF_ID};
        await future.apiRequestMasStaffgetByCon(mapGetByCon).then((onValue) {
          onValue.RESPONSE_DATA.forEach((item) {
            widget.Items = item;
            widget.Items.IsCheck = true;
            if (widget.Items.STAFF_TYPE == 0) {
              widget.Items.IsCreated = true;
            }
          });
          //Navigator.pop(context);
        });
      }
      //Navigator.pop(context);
    }
    setState(() {});
    return true;
  }

  void onSave(Map map) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionInsStaff(map);
    Navigator.pop(context);

    if (SUCCESS) {
      if (widget.IsUpdate) {
        /*widget.Items = new ItemsListArrestStaff(
          STAFF_ID: null,
          STAFF_TYPE: 0,
          STAFF_CODE: null,
          STAFF_REF_ID: null,
          ID_CARD: editIdentifyNumber.text,
          TITLE_NAME_TH: _title.TITLE_SHORT_NAME_TH,
          TITLE_SHORT_NAME_TH: _title.TITLE_SHORT_NAME_TH,
          FIRST_NAME: editFirstName.text,
          LAST_NAME: editLastName.text,
          OPREATION_POS_NAME: editPosition.text,
          OPREATION_POS_LAVEL_NAME: null,
          OPERATION_OFFICE_NAME: editUnder.text,
          OPERATION_OFFICE_SHORT_NAME: null,
          CONTRIBUTOR_ID: 15,
          IsCheck: true,
          ArrestType: "ผู้ร่วมจับกุม",
          ArrestTypeItems: ["ผู้จับกุม", "ผู้ร่วมจับกุม"]
      );*/

        Navigator.pop(context, widget.Items);
      } else {
        /*itemsStaff.add(new ItemsListArrestStaff(
          STAFF_ID: null,
          STAFF_TYPE: 0,
          STAFF_CODE: null,
          STAFF_REF_ID: null,
          ID_CARD: editIdentifyNumber.text,
          TITLE_NAME_TH: _title.TITLE_SHORT_NAME_TH,
          TITLE_SHORT_NAME_TH: _title.TITLE_SHORT_NAME_TH,
          FIRST_NAME: editFirstName.text,
          LAST_NAME: editLastName.text,
          OPREATION_POS_NAME: editPosition.text,
          OPREATION_POS_LAVEL_NAME: null,
          OPERATION_OFFICE_NAME: editUnder.text,
          OPERATION_OFFICE_SHORT_NAME: null,
          CONTRIBUTOR_ID: 15,
          IsCheck: true,
          ArrestType: "ผู้ร่วมจับกุม",
          ArrestTypeItems: ["ผู้จับกุม", "ผู้ร่วมจับกุม"]
      ));*/
        Navigator.pop(context, itemsStaff);
      }
    } else {
      new NetworkDialog(context, "สร้างผู้จับกุมไม่สำเร็จ");
    }
  }

  void onUpdate(List<Map> map) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionupdByCon(map);
    if (widget.IsUpdate) {
      Navigator.pop(context, widget.Items);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: new Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              title: new Padding(
                padding: EdgeInsets.only(right: 22.0),
                child: new Text(
                  "สร้างผู้จับกุม",
                  style: styleTextAppbar,
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context, "Back");
                  }),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    if (editIdentifyNumber.text.isEmpty) {
                      new VerifyDialog(context, "กรุณากรอกรหัสบัตรประชาชน");
                    } else if (!checkID(editIdentifyNumber.text)) {
                      new VerifyDialog(context, "กรุณากรอกรหัสบัตรประชาชนให้ถูกต้อง");
                    } else if (_title == null) {
                      new VerifyDialog(context, "กรุณาเลือกคำนำหน้าชื่อ");
                    } else if (editFirstName.text.isEmpty || editLastName.text.isEmpty) {
                      new VerifyDialog(context, "กรุณากรอกชื่อ-นามสกุล");
                    } else if (editPosition.text.isEmpty) {
                      new VerifyDialog(context, "กรุณากรอกตำแหน่ง");
                    } else if (editUnder.text.isEmpty) {
                      new VerifyDialog(context, "กรุณากรอกหน่วยงาน");
                    } else {
                      String identify = editIdentifyNumber.text;
                      String titleName = _title.TITLE_NAME_TH;
                      String shortTitle = _title.TITLE_SHORT_NAME_TH;
                      String firstname = editFirstName.text;
                      String lastname = editLastName.text;
                      String position = editPosition.text;
                      String under = editUnder.text;
                      String arrestType = "ผู้จับกุม";
                      bool check = false;

                      if (titleName.endsWith("นาย")) {
                        titleType = 1;
                        shortTitle = "นาย";
                      } else if (titleName.endsWith("นางสาว")) {
                        titleType = 2;
                        shortTitle = "นส.";
                      } else if (titleName.endsWith("นาง")) {
                        titleType = 3;
                        shortTitle = "นาง";
                      }

                      Map map;
                      List<Map> map_arrest = [];
                      if (widget.IsUpdate) {
                        map = {
                          "STAFF_ID": widget.Items.STAFF_REF_ID != null ? widget.Items.STAFF_REF_ID : widget.Items.STAFF_ID,
                          "TITLE_ID": _title.TITLE_ID,
                          "STAFF_CODE": "",
                          "ID_CARD": identify,
                          "STAFF_TYPE": 0,
                          "TITLE_NAME_TH": titleName,
                          "TITLE_SHORT_NAME_TH": shortTitle,
                          "FIRST_NAME": firstname,
                          "LAST_NAME": lastname,
                          "OPREATION_POS_NAME": position,
                          "OPERATION_OFFICE_NAME": under,
                          "STATUS": 1,
                          "IS_ACTIVE": 1
                        };

                        if (widget.Items.STAFF_REF_ID != null) {
                          map_arrest = [
                            {
                              "STAFF_ID": widget.Items.STAFF_ID,
                              "ARREST_ID": widget.ItemsMain.ARREST_ID,
                              "STAFF_REF_ID": widget.Items.STAFF_REF_ID,
                              "TITLE_ID": "",
                              "STAFF_CODE": "",
                              "ID_CARD": identify,
                              "STAFF_TYPE": 1,
                              "TITLE_NAME_TH": titleName,
                              "TITLE_NAME_EN": _title.TITLE_NAME_EN,
                              "TITLE_SHORT_NAME_TH": shortTitle,
                              "TITLE_SHORT_NAME_EN": _title.TITLE_SHORT_NAME_EN,
                              "FIRST_NAME": firstname,
                              "LAST_NAME": lastname,
                              "AGE": "",
                              "OPERATION_POS_CODE": "",
                              "OPREATION_POS_NAME": position,
                              "OPREATION_POS_LEVEL": "",
                              "OPERATION_POS_LEVEL_NAME": "",
                              "OPERATION_DEPT_CODE": "",
                              "OPERATION_DEPT_NAME": "",
                              "OPERATION_DEPT_LEVEL": "",
                              "OPERATION_UNDER_DEPT_CODE": "",
                              "OPERATION_UNDER_DEPT_NAME": "",
                              "OPERATION_UNDER_DEPT_LEVEL": "",
                              "OPERATION_WORK_DEPT_CODE": "",
                              "OPERATION_WORK_DEPT_NAME": "",
                              "OPERATION_WORK_DEPT_LEVEL": "",
                              "OPERATION_OFFICE_CODE": "",
                              "OPERATION_OFFICE_NAME": under,
                              "OPERATION_OFFICE_SHORT_NAME": under,
                              "MANAGEMENT_POS_CODE": "",
                              "MANAGEMENT_POS_NAME": "",
                              "MANAGEMENT_POS_LEVEL": "",
                              "MANAGEMENT_POS_LEVEL_NAME": "",
                              "MANAGEMENT_DEPT_CODE": "",
                              "MANAGEMENT_DEPT_NAME": "",
                              "MANAGEMENT_DEPT_LEVEL": "",
                              "MANAGEMENT_UNDER_DEPT_CODE": "",
                              "MANAGEMENT_UNDER_DEPT_NAME": "",
                              "MANAGEMENT_UNDER_DEPT_LEVEL": "",
                              "MANAGEMENT_WORK_DEPT_CODE": "",
                              "MANAGEMENT_WORK_DEPT_NAME": "",
                              "MANAGEMENT_WORK_DEPT_LEVEL": "",
                              "MANAGEMENT_OFFICE_CODE": "",
                              "MANAGEMENT_OFFICE_NAME": "",
                              "MANAGEMENT_OFFICE_SHORT_NAME": "",
                              "REPRESENTATION_POS_CODE": "",
                              "REPRESENTATION_POS_NAME": "",
                              "REPRESENTATION_POS_LEVEL": "",
                              "REPRESENTATION_POS_LEVEL_NAME": "",
                              "REPRESENTATION_DEPT_CODE": "",
                              "REPRESENTATION_DEPT_NAME": "",
                              "REPRESENTATION_DEPT_LEVEL": "",
                              "REPRESENTATION_UNDER_DEPT_CODE": "",
                              "REPRESENTATION_UNDER_DEPT_NAME": "",
                              "REPRESENTATION_UNDER_DEPT_LEVEL": "",
                              "REPRESENT_WORK_DEPT_CODE": "",
                              "REPRESENT_WORK_DEPT_NAME": "",
                              "REPRESENT_WORK_DEPT_LEVEL": "",
                              "REPRESENT_OFFICE_CODE": "",
                              "REPRESENT_OFFICE_NAME": "",
                              "REPRESENT_OFFICE_SHORT_NAME": "",
                              "STATUS": 1,
                              "REMARK": "",
                              "CONTRIBUTOR_ID": widget.Items.CONTRIBUTOR_ID,
                              "IS_ACTIVE": 1
                            }
                          ];

                          onUpdate(map_arrest);
                        }
                      } else {
                        map = {
                          "STAFF_ID": "",
                          "TITLE_ID": _title.TITLE_ID,
                          "STAFF_CODE": "",
                          "ID_CARD": identify,
                          "STAFF_TYPE": 0,
                          "TITLE_NAME_TH": titleName,
                          "TITLE_SHORT_NAME_TH": shortTitle,
                          "FIRST_NAME": firstname,
                          "LAST_NAME": lastname,
                          "OPREATION_POS_NAME": position,
                          "OPERATION_OFFICE_NAME": under,
                          "STATUS": 1,
                          "IS_ACTIVE": 1
                        };
                      }
                      if (widget.ItemsMain != null) {
                        List<Map> map = [];
                        widget.ItemsMain.ArrestStaff.forEach((item) {
                          if (item.STAFF_REF_ID == widget.Items.STAFF_ID) {
                            print(item.STAFF_ID.toString() + ":" + item.STAFF_REF_ID.toString());
                            map.add({
                              "STAFF_ID": item.STAFF_ID,
                              "ARREST_ID": widget.ItemsMain.ARREST_ID,
                              "STAFF_REF_ID": item.STAFF_REF_ID,
                              "TITLE_ID": "",
                              "STAFF_CODE": "",
                              "ID_CARD": identify,
                              "STAFF_TYPE": 1,
                              "TITLE_NAME_TH": titleName,
                              "TITLE_NAME_EN": _title.TITLE_NAME_EN,
                              "TITLE_SHORT_NAME_TH": shortTitle,
                              "TITLE_SHORT_NAME_EN": _title.TITLE_SHORT_NAME_EN,
                              "FIRST_NAME": firstname,
                              "LAST_NAME": lastname,
                              "AGE": "",
                              "OPERATION_POS_CODE": "",
                              "OPREATION_POS_NAME": position,
                              "OPREATION_POS_LEVEL": "",
                              "OPERATION_POS_LEVEL_NAME": "",
                              "OPERATION_DEPT_CODE": "",
                              "OPERATION_DEPT_NAME": "",
                              "OPERATION_DEPT_LEVEL": "",
                              "OPERATION_UNDER_DEPT_CODE": "",
                              "OPERATION_UNDER_DEPT_NAME": "",
                              "OPERATION_UNDER_DEPT_LEVEL": "",
                              "OPERATION_WORK_DEPT_CODE": "",
                              "OPERATION_WORK_DEPT_NAME": "",
                              "OPERATION_WORK_DEPT_LEVEL": "",
                              "OPERATION_OFFICE_CODE": "",
                              "OPERATION_OFFICE_NAME": under,
                              "OPERATION_OFFICE_SHORT_NAME": under,
                              "MANAGEMENT_POS_CODE": "",
                              "MANAGEMENT_POS_NAME": "",
                              "MANAGEMENT_POS_LEVEL": "",
                              "MANAGEMENT_POS_LEVEL_NAME": "",
                              "MANAGEMENT_DEPT_CODE": "",
                              "MANAGEMENT_DEPT_NAME": "",
                              "MANAGEMENT_DEPT_LEVEL": "",
                              "MANAGEMENT_UNDER_DEPT_CODE": "",
                              "MANAGEMENT_UNDER_DEPT_NAME": "",
                              "MANAGEMENT_UNDER_DEPT_LEVEL": "",
                              "MANAGEMENT_WORK_DEPT_CODE": "",
                              "MANAGEMENT_WORK_DEPT_NAME": "",
                              "MANAGEMENT_WORK_DEPT_LEVEL": "",
                              "MANAGEMENT_OFFICE_CODE": "",
                              "MANAGEMENT_OFFICE_NAME": "",
                              "MANAGEMENT_OFFICE_SHORT_NAME": "",
                              "REPRESENTATION_POS_CODE": "",
                              "REPRESENTATION_POS_NAME": "",
                              "REPRESENTATION_POS_LEVEL": "",
                              "REPRESENTATION_POS_LEVEL_NAME": "",
                              "REPRESENTATION_DEPT_CODE": "",
                              "REPRESENTATION_DEPT_NAME": "",
                              "REPRESENTATION_DEPT_LEVEL": "",
                              "REPRESENTATION_UNDER_DEPT_CODE": "",
                              "REPRESENTATION_UNDER_DEPT_NAME": "",
                              "REPRESENTATION_UNDER_DEPT_LEVEL": "",
                              "REPRESENT_WORK_DEPT_CODE": "",
                              "REPRESENT_WORK_DEPT_NAME": "",
                              "REPRESENT_WORK_DEPT_LEVEL": "",
                              "REPRESENT_OFFICE_CODE": "",
                              "REPRESENT_OFFICE_NAME": "",
                              "REPRESENT_OFFICE_SHORT_NAME": "",
                              "STATUS": 1,
                              "REMARK": "",
                              "CONTRIBUTOR_ID": item.CONTRIBUTOR_ID,
                              "IS_ACTIVE": 1
                            });
                          }
                        });
                        if (!map.isEmpty) {
                          onUpdate(map);
                        }
                      }

                      onSave(map);
                    }
                  },
                  child: Text(
                    "บันทึก",
                    style: styleTextAppbar,
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              BackgroundContent(),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      //height: 34.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
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
                    child: new Text('ILG60_B_01_00_10_00',
                      style: textStylePageName,),
                  )
                ],
              ),*/
                    ),
                    Expanded(
                      child: new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: SingleChildScrollView(
                          child: _buildContent(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
