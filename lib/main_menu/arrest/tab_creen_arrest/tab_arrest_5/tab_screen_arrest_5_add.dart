import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_5.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_GROUP_category.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_category_RDB.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_groups_category.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_type.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_creating.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class TabScreenArrest5Add extends StatefulWidget {
  bool IsNotice;
  bool IsSearch;
  bool IsUpdate;
  //ItemsMasterProductGroupResponse ItemsProductGroup;
  List<ItemsListProductGROUPCategory> ItemsProductGroup;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  TabScreenArrest5Add({
    Key key,
    @required this.IsNotice,
    @required this.IsSearch,
    @required this.IsUpdate,
    @required this.ItemsProductGroup,
    @required this.itemsMasProductSize,
    @required this.itemsMasProductUnit,
  }) : super(key: key);
  @override
  _TabScreenArrest5AddState createState() => new _TabScreenArrest5AddState();
}

class _TabScreenArrest5AddState extends State<TabScreenArrest5Add> {
  List _itemsData = [];

  final FocusNode myFocusNodeMainBrand = FocusNode();
  final FocusNode myFocusNodeSecondaryBrand = FocusNode();
  final FocusNode myFocusNodeProductModel = FocusNode();

  TextEditingController editMainBrand = new TextEditingController();
  TextEditingController editSecondaryBrand = new TextEditingController();
  TextEditingController editProductModel = new TextEditingController();

  List<ItemsListProductGroupCategory> ItemsProductCategory = [];
  List<ItemsListProductCategoryRDB> ItemsProductType = [];

  ItemsListProductGROUPCategory sProductGroup;
  ItemsListProductGroupCategory sProductCategory;
  ItemsListProductCategoryRDB sProductType;

  String dropdownValueUnit = "ขวด";
  String dropdownValueSubProductType;
  String dropdownValueSubSetProductType;

  Color labelColor = Color(0xff087de1);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  @override
  void initState() {
    super.initState();
    if (widget.ItemsProductGroup.length > 0) {
      //sProductGroup = widget.ItemsProductGroup.RESPONSE_DATA[0];
    }
    //this.onLoadActionProuductCategoryMaster(widget.ItemsProductGroup.RESPONSE_DATA[0].PRODUCT_GROUP_ID);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildInput(),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Card(
                          shape: new RoundedRectangleBorder(side: new BorderSide(color: labelColor, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                          elevation: 0.0,
                          child: Container(
                            width: 100.0,
                            child: MaterialButton(
                              onPressed: () {
                                _navigateSearch(context);
                              },
                              splashColor: Colors.grey,
                              child: Center(
                                child: Text(
                                  "ค้นหา",
                                  style: textLabelStyle,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildInput() {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 100) / 100;

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
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ItemsListProductGROUPCategory>(
              isExpanded: true, //
              value: sProductGroup,
              onChanged: (ItemsListProductGROUPCategory newValue) {
                setState(() {
                  sProductGroup = newValue;
                  if (sProductGroup.PRODUCT_GROUP_ID != 13) {
                    _onSelectProductGroup(sProductGroup.PRODUCT_GROUP_CODE, sProductGroup.PRODUCT_GROUP_CODE, null);
                  } else {
                    _onSelectProductGroup(sProductGroup.PRODUCT_GROUP_CODE + sProductGroup.PRODUCT_CATEGORY_CODE, sProductGroup.PRODUCT_GROUP_CODE, sProductGroup.PRODUCT_GROUP_ID);
                  }

                  sProductType = null;
                  sProductCategory = null;
                });
              },
              items: widget.ItemsProductGroup.map<DropdownMenuItem<ItemsListProductGROUPCategory>>((ItemsListProductGROUPCategory value) {
                return DropdownMenuItem<ItemsListProductGROUPCategory>(
                  value: value,
                  child: Text(
                    value.PRODUCT_GROUP_ID != 13 ? value.PRODUCT_GROUP_NAME : value.PRODUCT_CATEGORY_NAME,
                    style: textInputStyle,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "กลุ่มประเภทสินค้า",
            style: textLabelStyle,
          ),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: ItemsProductCategory != null
                ? DropdownButton<ItemsListProductGroupCategory>(
                    isExpanded: true, //
                    value: sProductCategory,
                    onChanged: (ItemsListProductGroupCategory newValue) {
                      setState(() {
                        sProductCategory = newValue;
                        if (sProductGroup.PRODUCT_GROUP_ID != 13) {
                          _onSelectProductCategory(sProductCategory.CATEGORY_GROUP_CODE, sProductGroup.PRODUCT_CATEGORY_CODE, sProductGroup.PRODUCT_GROUP_CODE);
                        } else {
                          _onSelectProductCategory(sProductCategory.CATEGORY_GROUP_CODE, sProductGroup.PRODUCT_GROUP_CODE + sProductGroup.PRODUCT_CATEGORY_CODE, sProductGroup.PRODUCT_GROUP_CODE);
                        }

                        sProductType = null;
                      });
                    },
                    items: ItemsProductCategory.map<DropdownMenuItem<ItemsListProductGroupCategory>>((ItemsListProductGroupCategory value) {
                      return DropdownMenuItem<ItemsListProductGroupCategory>(
                        value: value,
                        child: Text(
                          value.CATEGORY_GROUP_DESC,
                          style: textInputStyle,
                        ),
                      );
                    }).toList(),
                  )
                : Container(
                    padding: paddingLabel,
                    child: Container(),
                  ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ประเภทสินค้า",
            style: textLabelStyle,
          ),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: ItemsProductType != null
                ? DropdownButton<ItemsListProductCategoryRDB>(
                    isExpanded: true, //
                    value: sProductType,
                    onChanged: (ItemsListProductCategoryRDB newValue) {
                      setState(() {
                        sProductType = newValue;
                        //_onSelectProductType(sProductType.PRODUCT_TYPE_ID);
                      });
                    },
                    items: ItemsProductType.map<DropdownMenuItem<ItemsListProductCategoryRDB>>((ItemsListProductCategoryRDB value) {
                      return DropdownMenuItem<ItemsListProductCategoryRDB>(
                        value: value,
                        child: Text(
                          value.CATEGORY_DESC.toString(),
                          style: textInputStyle,
                        ),
                      );
                    }).toList(),
                  )
                : Container(
                    padding: paddingLabel,
                    child: Container(),
                  ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ยี่ห้อสินค้า",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            enabled: sProductGroup == null ? false : true,
            focusNode: myFocusNodeMainBrand,
            controller: editMainBrand,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        /* Container(
          padding: paddingLabel,
          child: Text("ยี่ห้อรองสินค้า", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            enabled: sProductGroup==null?false:true,
            focusNode: myFocusNodeSecondaryBrand,
            controller: editSecondaryBrand,
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
          child: Text("รุ่นสินค้า", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            enabled: sProductGroup==null?false:true,
            focusNode: myFocusNodeProductModel,
            controller: editProductModel,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,*/
      ],
    );
  }

  _navigateSearch(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionProuductProductMappingMaster();
    Navigator.pop(context);

    /*if (_itemsData.length > 0) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest5Search(
                  IsNotice: widget.IsNotice,
                  IsSearch: widget.IsSearch,
                  IsUpdate: widget.IsUpdate,
                  itemProductMapping: _itemsData,
                  itemsMasProductSize: widget.itemsMasProductSize,
                  itemsMasProductUnit: widget.itemsMasProductUnit,
                )),
      );
      if (result.toString() != "back") {
        //_itemsData = result;
        /*ItemsListArrest5Test itm = result;
        itm.ItemsListArrest5Mas.forEach((item){
          _arrestMain.ArrestProduct.add(item);
          list_add_product.add(item);
        });*/

        Navigator.pop(context, result);
      }
    } else {
      new EmptyDialog(context, "ไม่พบข้อมูลของกลาง");
    }*/
  }

  _navigateCreate(BuildContext mContext) async {
    final result = await Navigator.push(
      mContext,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest5Creating(
                ItemsProductGroup: widget.ItemsProductGroup,
              )),
    );
    if (result.toString() != "back") {
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  "ค้นหาของกลาง",
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
              /*actions: <Widget>[
            widget.IsSearch? new FlatButton(
              onPressed: () {
                _navigateCreate(context);
              },
              child: Text("สร้าง",
                style: styleTextAppbar,
              ),
            ):Container(),
          ],*/
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
                        child: new Text('ILG60_B_01_00_20_00',
                          style: textStylePageName,),
                      ),
                    ],
                  ),
                  ],
                )*/
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
              ),
            ],
          )),
    );
  }

  void _onSelectProductGroup(String CODE1, String CODE2, int PRODUCT_GROUP_ID) async {
    await onLoadActionProuductCategoryMaster(CODE1, CODE2, PRODUCT_GROUP_ID);
  }

  void _onSelectProductCategory(String PRODUCT_GROUP_CODE, String CODE1, String CODE2) async {
    await onLoadActionProuductTypeMaster(PRODUCT_GROUP_CODE, CODE1, CODE2);
  }
  /*void _onSelectProductType(int PRODUCT_TYPE_ID)async{
    await onLoadActionProuductSubTypeMaster(PRODUCT_TYPE_ID);
  }
  void _onSelectProductSubType(int PRODUCT_SUBTYPE_ID)async{
    await onLoadActionProuductSubSetTypeMaster(PRODUCT_SUBTYPE_ID);
  }*/

  Future<bool> onLoadActionProuductCategoryMaster(String GROUP_PRC_PRODUCT_CODE, String GROUP_PRODUCT_CODE, int PRODUCT_GROUP_ID) async {
    Map map = {
      "GROUP_PRC_PRODUCT_CODE": GROUP_PRC_PRODUCT_CODE,
      "GROUP_PRODUCT_CODE": GROUP_PRODUCT_CODE,
    };

    List<String> _ids = [];
    List<ItemsListProductGroupCategory> _items = [];
    await new ArrestFutureMaster().apiRequestMasProductCategoryGroupgetByCon(map).then((onValue) {
      onValue.forEach((f) {
        _ids.add(f.CATEGORY_GROUP_CODE);
      });
      _items = onValue;
    });
    var distinctIds = _ids.toSet().toList();
    List<ItemsListProductGroupCategory> _items_real = [];
    for (int i = 0; i < distinctIds.length; i++) {
      for (int j = 0; j < _items.length; j++) {
        if (distinctIds[i] == _items[j].CATEGORY_GROUP_CODE) {
          _items_real.add(_items[j]);
          break;
        }
      }
    }
    ItemsProductCategory = _items_real;

    setState(() {});
    return true;
  }

  Future<bool> onLoadActionProuductTypeMaster(String CATEGORY_GROUP_CODE, String CODE1, String CODE2) async {
    Map map = {"CATEGORY_GROUP_CODE": CATEGORY_GROUP_CODE, "GROUP_PRC_PRODUCT_CODE": CODE1, "GROUP_PRODUCT_CODE": CODE2, "RDB_PRODUCT_CODE": ""};
    print(map);

    List<String> _ids = [];
    List<ItemsListProductCategoryRDB> _items = [];
    await new ArrestFutureMaster().apiRequestMasProductCategoryRDBgetByCon(map).then((onValue) {
      if (onValue != null) {
        onValue.forEach((f) {
          _ids.add(f.CATEGORY_GROUP_CODE);
        });
        _items = onValue;
      }
      var distinctIds = _ids.toSet().toList();
      List<ItemsListProductCategoryRDB> _items_real = [];
      for (int i = 0; i < distinctIds.length; i++) {
        for (int j = 0; j < _items.length; j++) {
          if (distinctIds[i] == _items[j].CATEGORY_GROUP_CODE) {
            _items_real.add(_items[j]);
            break;
          }
        }
      }
      ItemsProductType = _items_real;

      //this.onLoadActionProuductSubTypeMaster(onValue.RESPONSE_DATA[0].PRODUCT_TYPE_ID);
    });
    setState(() {});
    return true;
  }
  /*Future<bool> onLoadActionProuductSubTypeMaster(int PRODUCT_TYPE_ID) async {
    Map map = {
      "TEXT_SEARCH": "",
      "PRODUCT_TYPE_ID": PRODUCT_TYPE_ID,
      "PRODUCT_SUBTYPE_ID": ""
    };
    await new ArrestFutureMaster().apiRequestMasProductSubTypegetByCon(map).then((onValue) {
      ItemsProductSubType = onValue;
      this.onLoadActionProuductSubSetTypeMaster(onValue.RESPONSE_DATA[0].PRODUCT_SUBTYPE_ID);
    });
    setState(() {});
    return true;
  }
  Future<bool> onLoadActionProuductSubSetTypeMaster(int PRODUCT_SUBTYPE_ID) async {
    Map map = {
      "TEXT_SEARCH": "",
      "PRODUCT_SUBTYPE_ID": PRODUCT_SUBTYPE_ID,
      "PRODUCT_SUBSETTYPE_ID": ""
    };
    await new ArrestFutureMaster().apiRequestMasProductSubSetTypegetByCon(map).then((onValue) {
      ItemsProductSubSetType = onValue;
      //this.onLoadActionDistinctMaster(onValue.RESPONSE_DATA[0].PROVINCE_ID);
    });
    setState(() {});
    return true;
  }*/

  Future<bool> onLoadActionProuductProductMappingMaster() async {
    Map map = {
      "PRODUCT_CODE": sProductCategory == null ? "" : (sProductCategory.PRODUCT_CODE == null ? "" : sProductCategory.PRODUCT_CODE),
      "PRODUCT_GROUP_ID": sProductGroup == null ? "" : (sProductGroup.PRODUCT_GROUP_ID == 13 ? sProductGroup.PRODUCT_GROUP_ID : sProductGroup.PRODUCT_GROUP_ID),
      "PRODUCT_NAME_DESC": editMainBrand.text.isNotEmpty ? editMainBrand.text : sProductCategory == null ? "" : (sProductCategory.PRODUCT_CODE == null ? sProductCategory.CATEGORY_GROUP_DESC : ""),
      /*"PRODUCT_CODE": "",
    "PRODUCT_GROUP_ID": sProductGroup!=null?sProductGroup.PRODUCT_GROUP_ID:"",
    "PRODUCT_NAME_DESC": editMainBrand.text,*/
    };
    print(map);
    await new ArrestFutureMaster().apiRequestMasProductMappinggetByConAdv(map).then((onValue) {
      //_itemsData = onValue;
      List _items = [];
      onValue.forEach((item) {
        if (item.PRODUCT_DESC != null) {
          _items.add(item);
        }
      });
      _itemsData = _items;
      //this.onLoadActionDistinctMaster(onValue.RESPONSE_DATA[0].PROVINCE_ID);
    });
    setState(() {});
    return true;
  }
}
