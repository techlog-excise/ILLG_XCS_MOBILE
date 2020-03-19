import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_5.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_controller.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_GROUP_category.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_GROUP_category_SRP.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_group.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_search_result.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class TabScreenArrest5Search extends StatefulWidget {
  bool IsNotice;
  bool IsSearch;
  bool IsUpdate;
  String arrestDate;
  List ItemsProductGroup;
  TabScreenArrest5Search({
    Key key,
    @required this.IsNotice,
    @required this.IsSearch,
    @required this.IsUpdate,
    @required this.arrestDate,
    @required this.ItemsProductGroup,
  }) : super(key: key);
  @override
  _TabScreenArrest5SearchNew createState() => new _TabScreenArrest5SearchNew();
}

class _TabScreenArrest5SearchNew extends State<TabScreenArrest5Search> {
  List _itemsData = [];

  final FocusNode myFocusNodeNote = FocusNode();
  TextEditingController editNote = new TextEditingController();
  ItemsListProductGROUPCategorySRP sProductGroup;
  List initProductItem = [];

  Color labelColor = Color(0xff087de1);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  String group_id = "";
  List _itemAll = [];
  List _itemPrcInq = [];
  List _itemMapping = [];

  int product_group_id;

  @override
  void initState() {
    super.initState();
  }

  // api find PRODUCT_GROUP_ID form PRODUCT_GROUP_CODE_OLD1(group_id in SRP)
  Future<bool> onLoadActionMasProductGroupgetByCon() async {
    Map map = {
      "GROUP_CODE_OLD": group_id,
      "PRODUCT_GROUP_ID": "",
      "TEXT_SEARCH": "",
    };
    print("Map_MasProductGroupgetByCon: $map");
    await new ArrestFutureMaster().apiRequestMasProductGroupgetByCon(map).then((onValue) {
      List<ItemsListProductGroup> _tempItemsListProductGroup = [];
      int _tempProductGroupId;
      _tempItemsListProductGroup = onValue;

      _tempItemsListProductGroup.forEach((f) => {
            _tempProductGroupId = f.PRODUCT_GROUP_ID,
          });
      product_group_id = _tempProductGroupId;
      print('product_group_id: ${product_group_id.toString()}');
    });
    setState(() {});
    return true;
  }

  // api search SRP
  Future<bool> onLoadActionPrcInqProductByName() async {
    Map map = {
      "SystemId": "sssss",
      "UserName": "train02",
      "Password": "train02",
      "IpAddress": "10.1.1.1",
      "RequestData": {
        "ProductGroupCode": group_id, // Code เก่า
        "ProductDesc": editNote.text,
        "Barcode": "",
        "EffectiveDate": widget.arrestDate, // วันที่จับกุม
      },
    };
    print("Map_PrcInqProductByName: $map");
    await new ArrestFutureMaster().apiRequestPrcInqProductByName(map).then((onValue) {
      List _tempProductList = [];
      List _tempItemPrcInq = [];
      if (onValue != null) {
        print('Request_PrcInqProductByName: ${onValue.ResponseMessage}');
        (onValue.ResponseData.ProductList).forEach((f) {
          _tempProductList.add(f);
        });
        _tempProductList.forEach((f) {
          (f.ProductInfo).forEach((item) {
            _tempItemPrcInq.add(new ItemsListArrestOps(
                0,
                item.ProductCode,
                item.ExciseProductCode,
                null,
                item.ProductCode != "" ? int.parse(item.ProductCode.substring(0, 2)) : "",
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                item.ProductGroupName,
                item.ProductCategoryName,
                null,
                null,
                null,
                item.BrandMainTha,
                item.BrandMainEng,
                item.BrandSecondCode,
                item.BrandSecondNameTha,
                item.BrandSecondNameEng,
                null,
                null,
                null,
                null,
                null,
                double.parse(item.SizeDesc),
                null,
                null,
                item.SizeUnit,
                item.UnitName,
                item.SizeUnit,
                null,
                null,
                null,
                null,
                item.Degree,
                item.SugarQuantity,
                item.Co2Quantity,
                item.RetailPrice,
                item.ProductName,
                item.CompanyName,
                null,
                int.parse(item.TypeSellCode),
                false,
                false,
                new ItemsListArrest6Controller(
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  false,
                  false,
                ),
                0));
          });
        });
        _itemPrcInq = _tempItemPrcInq;
      } else {
        _itemPrcInq = [];
      }
    });
    setState(() {});
    return true;
  }

  // api search Mapping
  Future<bool> onLoadActionProuductProductMappingMaster() async {
    Map map = {
      "PRODUCT_CODE": "",
      "PRODUCT_GROUP_ID": product_group_id == null ? "" : product_group_id,
      "PRODUCT_NAME_DESC": "",
    };
    print("Map_MasProductMappinggetByConAdv: $map");
    await new ArrestFutureMaster().apiRequestMasProductMappinggetByConAdv(map).then((onValue) {
      List _tempItemMapping = [];
      onValue.forEach((item) {
        _tempItemMapping.add(new ItemsListArrestOps(
          item.PRODUCT_MAPPING_ID,
          item.PRODUCT_CODE,
          item.PRODUCT_REF_CODE,
          item.PRODUCT_ID,
          item.PRODUCT_GROUP_ID,
          item.PRODUCT_CATEGORY_ID,
          item.PRODUCT_TYPE_ID,
          item.PRODUCT_SUBTYPE_ID,
          item.PRODUCT_SUBSETTYPE_ID,
          item.PRODUCT_BRAND_ID,
          item.PRODUCT_SUBBRAND_ID,
          item.PRODUCT_MODEL_ID,
          item.PRODUCT_TAXDETAIL_ID,
          item.UNIT_ID,
          item.PRODUCT_GROUP_NAME,
          item.PRODUCT_CATEGORY_NAME,
          item.PRODUCT_TYPE_NAME,
          item.PRODUCT_SUBTYPE_NAME,
          item.PRODUCT_SUBSETTYPE_NAME,
          item.PRODUCT_BRAND_NAME_TH,
          item.PRODUCT_BRAND_NAME_EN,
          null,
          item.PRODUCT_SUBBRAND_NAME_TH,
          item.PRODUCT_SUBBRAND_NAME_EN,
          item.PRODUCT_MODEL_NAME_TH,
          item.PRODUCT_MODEL_NAME_EN,
          item.SIZES_UNIT_ID,
          item.QUANTITY,
          item.VOLUMN_UNIT_ID,
          item.SIZES,
          item.QUATITY_UNIT_ID,
          item.VOLUMN,
          item.SIZES_UNIT,
          item.QUANTITY_UNIT,
          item.VOLUMN_UNIT,
          null,
          item.TAX_VALUE,
          item.TAX_VOLUMN,
          item.TAX_VOLUMN_UNIT,
          item.DEGREE,
          item.SUGAR,
          item.CO2,
          item.PRICE,
          item.PRODUCT_DESC,
          "",
          null,
          item.IS_DOMESTIC,
          item.IsCheck,
          item.IsCheckOffence,
          new ItemsListArrest6Controller(
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            false,
            false,
          ),
          0,
        ));
      });
      _itemMapping = _tempItemMapping;
    });
    setState(() {});
    return true;
  }

  onCombineList() {
    _itemAll = new List.from(_itemPrcInq)..addAll(_itemMapping);
  }

  // api nav
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
    await onLoadActionPrcInqProductByName();
    onCombineList();
    Navigator.pop(context);

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest5SearchResult(
                IsNotice: widget.IsNotice,
                IsSearch: widget.IsSearch,
                IsUpdate: widget.IsUpdate,
                itemProductMapping: _itemAll,
              )),
    );

    // if (_itemsData.length > 0) {
    //   final result = await Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => TabScreenArrest5Search(
    //               IsNotice: widget.IsNotice,
    //               IsSearch: widget.IsSearch,
    //               IsUpdate: widget.IsUpdate,
    //               itemProductMapping: _itemsData,
    //             )),
    //   );
    if (result.toString() != "back") {
      //_itemsData = result;
      /*ItemsListArrest5Test itm = result;
        itm.ItemsListArrest5Mas.forEach((item){
          _arrestMain.ArrestProduct.add(item);
          list_add_product.add(item);
        });*/

      Navigator.pop(context, result);
    }
    // } else {
    //   new EmptyDialog(context, "ไม่พบข้อมูลของกลาง");
    // }
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
            child: DropdownButton<ItemsListProductGROUPCategorySRP>(
              isExpanded: true, //
              value: sProductGroup,
              onChanged: (ItemsListProductGROUPCategorySRP newValue) {
                setState(() {
                  sProductGroup = newValue;
                  // if (sProductGroup.GROUP_ID != 13) {
                  _onSelectProductGroup(sProductGroup.GROUP_ID, sProductGroup.GROUP_ID, null);
                  group_id = newValue.GROUP_ID;
                  onLoadActionMasProductGroupgetByCon();
                  // } else {
                  //   _onSelectProductGroup(sProductGroup.PRODUCT_GROUP_CODE + sProductGroup.PRODUCT_CATEGORY_CODE, sProductGroup.PRODUCT_GROUP_CODE, sProductGroup.PRODUCT_GROUP_ID);
                  // }
                });
              },
              items: widget.ItemsProductGroup.map<DropdownMenuItem<ItemsListProductGROUPCategorySRP>>((value) {
                return DropdownMenuItem<ItemsListProductGROUPCategorySRP>(
                  value: value,
                  child: Text(
                    value.GROUP_NAME,
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
            "ระบุคำ",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            enabled: sProductGroup == null ? false : true,
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

  Future<bool> onLoadActionProuductCategoryMaster(String GROUP_PRC_PRODUCT_CODE, String GROUP_PRODUCT_CODE, int PRODUCT_GROUP_ID) async {
    // Map map = {
    //   "GROUP_PRC_PRODUCT_CODE": GROUP_PRC_PRODUCT_CODE,
    //   "GROUP_PRODUCT_CODE": GROUP_PRODUCT_CODE,
    // };

    // List<String> _ids = [];
    // List<ItemsListProductGroupCategory> _items = [];
    // await new ArrestFutureMaster().apiRequestMasProductCategoryGroupgetByCon(map).then((onValue) {
    //   onValue.forEach((f) {
    //     _ids.add(f.CATEGORY_GROUP_CODE);
    //   });
    //   _items = onValue;
    // });
    // var distinctIds = _ids.toSet().toList();
    // List<ItemsListProductGroupCategory> _items_real = [];
    // for (int i = 0; i < distinctIds.length; i++) {
    //   for (int j = 0; j < _items.length; j++) {
    //     if (distinctIds[i] == _items[j].CATEGORY_GROUP_CODE) {
    //       _items_real.add(_items[j]);
    //       break;
    //     }
    //   }
    // }
    // ItemsProductCategory = _items_real;

    setState(() {});
    return true;
  }
}
