import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/component/custom_text.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_group.dart';
import 'package:prototype_app_pang/main_menu/notice/model/item_notice_5.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class TabScreenNotice5Add extends StatefulWidget {
  List itemProduct;
  ItemsListNotice itemProductTab5;
  List temp_itemsDataTab5;
  bool onEdit;

  TabScreenNotice5Add({
    Key key,
    @required this.itemProduct,
    @required this.itemProductTab5,
    @required this.temp_itemsDataTab5,
    @required this.onEdit,
  }) : super(key: key);

  @override
  _TabScreenNotice5AddState createState() => new _TabScreenNotice5AddState();
}

class _TabScreenNotice5AddState extends State<TabScreenNotice5Add> {
  ItemsListNotice _itemsData;
  int noticeId;
  int productGroupID;
  Map mapProduct;
  String productGroupName;
  String productGroupCode;
  int productId;
  bool _isEdit = false;
  List _newItemProduct = [];
  List temp_productGroupName = [];
  String temp_name;
  List nameOldDropD = [];
  List nameNewDropD = [];

  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);

  Color labelColor = Color(0xff087de1);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  ItemsListProductGroup sProductGroup;

  final FocusNode myFocusNodeNote = FocusNode();

  TextEditingController editNote = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ItemsListProductGroup test = new ItemsListProductGroup(PRODUCT_GROUP_ID: 1, PRODUCT_GROUP_CODE: "2", PRODUCT_GROUP_NAME: 'ทดสอบ', IS_ACTIVE: 1);
    widget.itemProduct.forEach((item) {
      if (item.PRODUCT_GROUP_ID != 88) {
        _newItemProduct.add(item);
      }
    });
    if (widget.onEdit) {
      editNote.text = widget.itemProductTab5.PRODUCT_DESC == null ? '' : widget.itemProductTab5.PRODUCT_DESC.toString();
      productGroupName = widget.itemProductTab5.PRODUCT_GROUP_NAME.toString();
      productGroupID = widget.itemProductTab5.PRODUCT_GROUP_ID;
      productGroupCode = widget.itemProductTab5.PRODUCT_GROUP_CODE;
      noticeId = widget.itemProductTab5.NOTICE_ID;
      productId = widget.itemProductTab5.PRODUCT_ID;

      temp_productGroupName = widget.temp_itemsDataTab5;
      temp_name = widget.itemProductTab5.PRODUCT_GROUP_NAME.toString();
      temp_productGroupName.forEach((f) {
        nameOldDropD.add(f.PRODUCT_GROUP_NAME);
        nameNewDropD.add(f.PRODUCT_GROUP_NAME);
      });
    } else {
      temp_productGroupName = widget.temp_itemsDataTab5;
      temp_productGroupName.forEach((f) {
        nameOldDropD.add(f.PRODUCT_GROUP_NAME);
        nameNewDropD.add(f.PRODUCT_GROUP_NAME);
      });
    }
  }

  _navigateCreaet(BuildContext context, ItemsListNotice itemsListNotice) async {
    Navigator.pop(context, itemsListNotice);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: สร้าง Layout
    final List<Widget> btnAdd = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new FlatButton(
              onPressed: () {
                if (productGroupID == null) {
                  new VerifyDialog(context, "กรุณาเลือกหมวดสินค้า");
                } else {
                  ItemsListNotice itemsListNotice = new ItemsListNotice(
                      PRODUCT_MAPPING_ID: null,
                      PRODUCT_CODE: null,
                      PRODUCT_REF_CODE: null,
                      NOTICE_ID: noticeId,
                      PRODUCT_ID: productId,
                      PRODUCT_GROUP_ID: productGroupID,
                      PRODUCT_GROUP_CODE: productGroupCode,
                      PRODUCT_CATEGORY_ID: null,
                      PRODUCT_TYPE_ID: null,
                      PRODUCT_SUBTYPE_ID: null,
                      PRODUCT_SUBSETTYPE_ID: null,
                      PRODUCT_BRAND_ID: null,
                      PRODUCT_SUBBRAND_ID: null,
                      PRODUCT_MODEL_ID: null,
                      PRODUCT_TAXDETAIL_ID: null,
                      UNIT_ID: null,
                      PRODUCT_CATEGORY_NAME: null,
                      PRODUCT_GROUP_NAME: productGroupName,
                      PRODUCT_TYPE_NAME: null,
                      PRODUCT_SUBTYPE_NAME: null,
                      PRODUCT_SUBSETTYPE_NAME: null,
                      PRODUCT_BRAND_NAME_TH: null,
                      PRODUCT_BRAND_NAME_EN: null,
                      PRODUCT_SUBBRAND_CODE: null,
                      PRODUCT_SUBBRAND_NAME_TH: null,
                      PRODUCT_SUBBRAND_NAME_EN: null,
                      PRODUCT_MODEL_NAME_TH: null,
                      PRODUCT_MODEL_NAME_EN: null,
                      SIZES_UNIT_ID: null,
                      QUATITY_UNIT_ID: null,
                      VOLUMN_UNIT_ID: null,
                      SIZES: null,
                      QUANTITY: null,
                      VOLUMN: null,
                      SIZES_UNIT: null,
                      QUANTITY_UNIT: null,
                      VOLUMN_UNIT: null,
                      FINE_ESTIMATE: null,
                      TAX_VALUE: null,
                      TAX_VOLUMN: null,
                      TAX_VOLUMN_UNIT: null,
                      DEGREE: null,
                      SUGAR: null,
                      CO2: null,
                      PRICE: null,
                      PRODUCT_DESC: editNote.text == '' ? '' : editNote.text,
                      REMARK: null,
                      IS_DOMESTIC: null,
                      INDEX: null);
                  _navigateCreaet(context, itemsListNotice);
                }
              },
              child: Text(widget.onEdit ? 'บันทึก' : 'เพิ่ม', style: appBarStyle)),
        ],
      )
    ];
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
                widget.onEdit ? "แก้ไขสินค้าต้องสงสัย" : "เพิ่มสินค้าต้องสงสัย",
                style: Styles.styleTextAppbar,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context, "back");
                }),
            actions: btnAdd,
          ),
        ),
        body: Stack(
          children: <Widget>[
            BackgroundContent(),
            new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      //color: Colors.grey[200],
                      border: Border(
                    top: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
                ),
                Expanded(
                  child: new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: SingleChildScrollView(
                        child: _buildContent(context),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;
    return Container(
      height: size.height,
      decoration: BoxDecoration(
          //color: Colors.white,
          shape: BoxShape.rectangle,
          border: Border(
            top: BorderSide(color: Colors.grey[300], width: 1.0),
            bottom: BorderSide(color: Colors.grey[300], width: 1.0),
          )),
      width: size.width,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
          width: Width,
          child: _buildInput(),
        ),
      ),
    );
  }

  Widget _buildInput() {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 100) / 100;
    // print('sProductGroup ${test.toString()}');

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "หมวดสินค้า",
            style: textLabelStyle,
          ),
        ),
        Container(
          width: Width,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ItemsListProductGroup>(
              isExpanded: true, //
              value: sProductGroup,
              onChanged: (ItemsListProductGroup newValue) {
                !nameNewDropD.contains(newValue.PRODUCT_GROUP_NAME)
                    ? setState(() {
                        sProductGroup = newValue;
                        productGroupID = newValue.PRODUCT_GROUP_ID;
                        productGroupName = newValue.PRODUCT_GROUP_NAME;
                        productGroupCode = newValue.PRODUCT_GROUP_CODE;

                        if (widget.onEdit) {
                          nameNewDropD = [];
                          temp_productGroupName.forEach((f) {
                            if (f.PRODUCT_GROUP_NAME != temp_name) {
                              nameNewDropD.add(f.PRODUCT_GROUP_NAME);
                            }
                          });
                        } else {
                          nameNewDropD = [];
                          temp_productGroupName.forEach((f) {
                            nameNewDropD.add(f.PRODUCT_GROUP_NAME);
                          });
                        }

                        // ========================= Check disable =======================
                        nameNewDropD.add(newValue.PRODUCT_GROUP_NAME);
                        print("nameNewDropD: ${nameNewDropD.toString()}");
                        // ===============================================================
                      })
                    : null;
              },
              items: _newItemProduct.map<DropdownMenuItem<ItemsListProductGroup>>((value) {
                bool isDisabled(String valueDropDownMenu) {
                  for (var item in nameNewDropD) {
                    if (valueDropDownMenu == item) {
                      if (valueDropDownMenu == productGroupName) {
                        return false;
                      } else {
                        return true;
                      }
                    }
                  }
                  return false;
                }

                return DropdownMenuItem<ItemsListProductGroup>(
                  value: value,
                  child: CustomText(value.PRODUCT_GROUP_NAME, isDisabled: isDisabled(value.PRODUCT_GROUP_NAME)),
                );
              }).toList(),
              hint: new Text(widget.onEdit ? widget.itemProductTab5.PRODUCT_GROUP_NAME.toString() : "กรุณาเลือก", style: textInputStyle),
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ข้อมูลสินค้าเพิ่มเติม",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            enabled: widget.onEdit ? true : sProductGroup == null ? false : true,
            focusNode: myFocusNodeNote,
            controller: editNote,
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
    );
  }
}
