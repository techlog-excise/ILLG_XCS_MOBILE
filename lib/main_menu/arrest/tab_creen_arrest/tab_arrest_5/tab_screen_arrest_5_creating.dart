import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_5.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_controller.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product_mapping.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_GROUP_category.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_brand.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_category.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_group.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_model.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_size.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_sub_brand.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_type.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_unit.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class TabScreenArrest5Creating extends StatefulWidget {
  bool IsSearch;
  bool IsUpdate;
  //ItemsMasterProductGroupResponse ItemsProductGroup;
  List<ItemsListProductGROUPCategory> ItemsProductGroup;
  var ItemsDataProduct;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  TabScreenArrest5Creating({
    Key key,
    @required this.IsSearch,
    @required this.IsUpdate,
    @required this.ItemsProductGroup,
    @required this.ItemsDataProduct,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
  }) : super(key: key);
  @override
  _TabScreenArrest5AddState createState() => new _TabScreenArrest5AddState();
}

class _TabScreenArrest5AddState extends State<TabScreenArrest5Creating> {
  List _itemsData = [];
  GlobalKey key_product_group = new GlobalKey<AutoCompleteTextFieldState<ItemsListProductGroup>>();

  bool IsMotor = false;

  final FocusNode myFocusNodeMainBrand = FocusNode();
  final FocusNode myFocusNodeSecondaryBrand = FocusNode();
  final FocusNode myFocusNodeProductModel = FocusNode();
  final FocusNode myFocusNodeSize = FocusNode();
  final FocusNode myFocusNodeCapacity = FocusNode();
  final FocusNode myFocusNodeVolumn = FocusNode();
  final FocusNode myFocusNodeVolumnUnit = FocusNode();
  final FocusNode myFocusNodeNumbeMotor = FocusNode();
  final FocusNode myFocusNodeNumberTank = FocusNode();
  final FocusNode myFocusNodeOther = FocusNode();
  final FocusNode myFocusBrandDetail = FocusNode();

  TextEditingController editMainBrand = new TextEditingController();
  TextEditingController editSubBrand = new TextEditingController();
  TextEditingController editModel = new TextEditingController();
  TextEditingController editSecondaryBrand = new TextEditingController();
  TextEditingController editProductModel = new TextEditingController();
  TextEditingController editSize = new TextEditingController();
  TextEditingController editCapacity = new TextEditingController();
  TextEditingController editVolumn = new TextEditingController();
  TextEditingController editVolumnUnit = new TextEditingController();
  TextEditingController editNumbeMotor = new TextEditingController();
  TextEditingController editNumberTank = new TextEditingController();
  TextEditingController editOther = new TextEditingController();

  TextEditingController editBrandDetail = new TextEditingController();

  /*List<String> dropdownItemsSizeUnit = ["ลิตร", 'มิลลิลิตร'];
  List<String> dropdownItemsCapacityUnit = ["ขวด", 'ลัง', 'ซอง', 'คัน'];
  String dropdownValueSizeUnit = null;
  String dropdownValueCapacityUnit = null;*/
  ItemsMasProductSizeResponse dropdownItemsSizeUnit;
  ItemsMasProductUnitResponse dropdownItemsCapacityUnit;
  ItemsListProductSize dropdownValueSizeUnit = null;
  ItemsListProductUnit dropdownValueCapacityUnit = null;

  final formatter = new NumberFormat("#,###.###");

  //String _brandDetail="";

  ItemsMasterProductCategoryResponse ItemsProductCategory;
  ItemsMasterProductTypeResponse ItemsProductType;
  ItemsMasterProductBrandResponse ItemsProductBrand;
  ItemsMasterProductSubBrandResponse ItemsProductSubBrand;
  ItemsMasterProductModelResponse ItemsProductModel;

  //ItemsListProductGroup sProductGroup;
  ItemsListProductGROUPCategory sProductGroup;
  ItemsListProductCategory sProductCategory;
  ItemsListProductType sProductType;
  ItemsListProductBrand sProductBrand;
  ItemsListProductSubBrand sProductSubBrand;
  ItemsListProductModel sProductModel;

  double xSize = 0;
  int yCount = 0;
  double zTotal = 0;

  /*List<String>dropdownItemsLocalCountry = ['ในประเทศ', 'ต่างประเทศ'];
  String dropdownValueLocalCountry = null;*/

  Color labelColor = Color(0xff087de1);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  TextStyle textStyleStar = Styles.textStyleStar;

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  DateFormat dateFormatDate;

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    setAutoCompleteProductGroup();

    dateFormatDate = new DateFormat('yyy-MM-dd');

    dropdownItemsSizeUnit = widget.itemsMasProductSize;
    dropdownItemsCapacityUnit = widget.itemsMasProductUnit;

    if (widget.IsUpdate) {
      widget.ItemsProductGroup.forEach((item) {
        if (item.PRODUCT_GROUP_ID == widget.ItemsDataProduct.PRODUCT_GROUP_ID) {
          sProductGroup = item;
        }
      });

      if (sProductGroup != null) {
        this.onLoadActionProuductCategoryMaster(sProductGroup.PRODUCT_GROUP_ID);
      }

      String pro_detl = "";
      if (widget.ItemsDataProduct.PRODUCT_GROUP_NAME != null) {
        pro_detl += widget.ItemsDataProduct.PRODUCT_GROUP_NAME + " ";
      }
      if (widget.ItemsDataProduct.PRODUCT_CATEGORY_NAME != null) {
        pro_detl += widget.ItemsDataProduct.PRODUCT_CATEGORY_NAME + " ";
      }
      if (widget.ItemsDataProduct.PRODUCT_SUBTYPE_NAME != null) {
        pro_detl += widget.ItemsDataProduct.PRODUCT_SUBTYPE_NAME + " ";
      }
      if (widget.ItemsDataProduct.PRODUCT_BRAND_NAME_TH != null) {
        pro_detl += widget.ItemsDataProduct.PRODUCT_BRAND_NAME_TH + " ";
      }
      editBrandDetail.text = pro_detl;

      editSize.text = widget.ItemsDataProduct.SIZES.toString();
      editCapacity.text = (widget.ItemsDataProduct.QUANTITY.toInt()).toString();
      editVolumn.text = widget.ItemsDataProduct.VOLUMN.toString();

      dropdownItemsSizeUnit.RESPONSE_DATA.forEach((item) {
        if (item.SIZE_NAME_TH == widget.ItemsDataProduct.SIZES_UNIT) {
          dropdownValueSizeUnit = item;
        }
      });
      dropdownItemsCapacityUnit.RESPONSE_DATA.forEach((item) {
        if (item.UNIT_NAME_TH == widget.ItemsDataProduct.QUANTITY_UNIT) {
          dropdownValueCapacityUnit = item;
        }
      });
      editVolumnUnit.text = widget.ItemsDataProduct.VOLUMN_UNIT;
    } else {
      this.onLoadActionProuductCategoryMaster(widget.ItemsProductGroup[0].PRODUCT_GROUP_ID);
    }
  }

  @override
  void dispose() {
    super.dispose();
    editMainBrand.dispose();
    editSubBrand.dispose();
    editModel.dispose();
    editSecondaryBrand.dispose();
    editProductModel.dispose();
    editSize.dispose();
    editCapacity.dispose();
    editVolumn.dispose();
    editVolumnUnit.dispose();
    editNumbeMotor.dispose();
    editNumberTank.dispose();
    editOther.dispose();
    editBrandDetail.dispose();
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

  Widget _buildContent(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;
    return Container(
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
        ));
  }

  void _onSaved(mContext) async {
    if (sProductGroup == null) {
      new VerifyDialog(mContext, 'กรุณาเลือกหมวดหมู่สินค้า');
    }
    /*else if (editSize.text.isEmpty */ /*||dropdownValueSizeUnit==null*/ /*) {
      new VerifyDialog(mContext, 'กรุณากรอกข้อมูลขนาดบรรจุ');
    }*/
    else if (editCapacity.text.isEmpty || dropdownValueCapacityUnit == null) {
      new VerifyDialog(mContext, 'กรุณากรอกข้อมูลและเลือกหน่วยจำนวน');
    } else {
      /*Map map_pro_group = {

      };
      Map map_pro_mapping = {
        "PRODUCT_MAPPING_ID": "",
        "PRODUCT_CODE": "",
        "PRODUCT_REF_CODE": "",
        "PRODUCT_GROUP_ID": sProductGroup.PRODUCT_GROUP_ID,
        "PRODUCT_CATEGORY_ID": sProductCategory.PRODUCT_CATEGORY_ID,
        "PRODUCT_TYPE_ID": sProductType.PRODUCT_TYPE_ID,
        "PRODUCT_SUBTYPE_ID": "",
        "PRODUCT_SUBSETTYPE_ID": "",
        "PRODUCT_BRAND_ID": sProductBrand.PRODUCT_BRAND_ID,
        "PRODUCT_SUBBRAND_ID": "",
        "PRODUCT_MODEL_ID": "",
        "PRODUCT_TAXDETAIL_ID": "",
        "UNIT_ID": 1,
        "SIZES": int.parse(editVolumn.text),
        "SIZES_UNIT": editVolumnUnit.text,
        "DEGREE": "",
        "SUGAR": "",
        "CO2": "",
        "PRICE": "",
        "IS_DOMESTIC": 0,
        "IS_ACTIVE": 1,
        "CREATE_USER_ACCOUNT_ID": 1,
        "CREATE_DATE": dateFormatDate.format(DateTime.now()).toString(),
        "UPDATE_USER_ACCOUNT_ID": "",
        "UPDATE_DATE": ""
      };

      showDialog(
      barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CupertinoActivityIndicator(
              ),
            );
          });
       await onLoadActionInsProductAllMaster(map_pro_mapping);*/

      print(editBrandDetail.text);
      _itemsData.add(new ItemsListArrest5(
          null,
          null,
          null,
          null,
          sProductGroup.PRODUCT_GROUP_ID,
          sProductCategory != null ? sProductCategory.PRODUCT_CATEGORY_ID : null,
          sProductType != null ? sProductType.PRODUCT_TYPE_ID : null,
          null,
          null,
          sProductBrand != null ? sProductBrand.PRODUCT_BRAND_ID : null,
          null,
          null,
          null,
          null,
          sProductGroup.PRODUCT_GROUP_NAME,
          sProductCategory != null ? sProductCategory.PRODUCT_CATEGORY_NAME : "",
          sProductType != null ? sProductType.PRODUCT_TYPE_NAME : "",
          null,
          null,
          sProductBrand != null ? sProductBrand.PRODUCT_BRAND_NAME_TH : (_textListProductBrand != null ? _textListProductBrand.textField.controller.text : ""),
          null,
          null,
          null,
          null,
          null,
          null,
          dropdownValueSizeUnit != null ? dropdownValueSizeUnit.SIZE_ID : null,
          editCapacity.text.isEmpty ? null : double.parse(editCapacity.text.replaceAll(",", "")),
          dropdownValueSizeUnit != null ? dropdownValueSizeUnit.SIZE_ID : null,
          editSize.text.isEmpty ? null : double.parse(editSize.text.replaceAll(",", "")),
          dropdownValueCapacityUnit != null ? dropdownValueCapacityUnit.UNIT_ID : null,
          double.parse(editVolumn.text.replaceAll(",", "")),
          dropdownValueSizeUnit != null ? dropdownValueSizeUnit.SIZE_NAME_TH : "",
          dropdownValueCapacityUnit != null ? dropdownValueCapacityUnit.UNIT_NAME_TH : "",
          editVolumnUnit.text,
          null,
          null,
          null,
          null,
          null,
          editBrandDetail.text,
          "",
          1,
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
          null));
      List item_ops = [];
      if (widget.IsUpdate) {
        widget.ItemsDataProduct.PRODUCT_GROUP_ID = sProductGroup != null ? sProductGroup.PRODUCT_GROUP_ID : null;
        widget.ItemsDataProduct.PRODUCT_CATEGORY_ID = sProductCategory != null ? sProductCategory.PRODUCT_CATEGORY_ID : null;
        widget.ItemsDataProduct.PRODUCT_TYPE_ID = sProductType != null ? sProductType.PRODUCT_TYPE_ID : null;
        widget.ItemsDataProduct.PRODUCT_BRAND_ID = sProductBrand != null ? sProductBrand.PRODUCT_BRAND_ID : null;

        widget.ItemsDataProduct.PRODUCT_GROUP_NAME = sProductGroup.PRODUCT_GROUP_NAME;
        widget.ItemsDataProduct.PRODUCT_CATEGORY_NAME = sProductCategory != null ? sProductCategory.PRODUCT_CATEGORY_NAME : null;
        widget.ItemsDataProduct.PRODUCT_TYPE_NAME = sProductType != null ? sProductType.PRODUCT_TYPE_NAME : "";
        widget.ItemsDataProduct.PRODUCT_BRAND_NAME_TH = sProductBrand != null ? sProductBrand.PRODUCT_BRAND_NAME_TH : (_textListProductBrand != null ? _textListProductBrand.textField.controller.text : "");

        widget.ItemsDataProduct.SIZES = editSize.text.isEmpty ? null : double.parse(editSize.text.replaceAll(",", ""));
        widget.ItemsDataProduct.QUANTITY = editCapacity.text.isEmpty ? null : double.parse(editCapacity.text.replaceAll(",", ""));
        widget.ItemsDataProduct.VOLUMN = double.parse(editVolumn.text.replaceAll(",", ""));

        widget.ItemsDataProduct.SIZES_UNIT = dropdownValueSizeUnit != null ? dropdownValueSizeUnit.SIZE_NAME_TH : "";
        widget.ItemsDataProduct.QUANTITY_UNIT = dropdownValueCapacityUnit != null ? dropdownValueCapacityUnit.UNIT_NAME_TH : "";
        widget.ItemsDataProduct.VOLUMN_UNIT = editVolumnUnit.text;

        widget.ItemsDataProduct.SIZES_UNIT_ID = dropdownValueSizeUnit.SIZE_ID;
        widget.ItemsDataProduct.QUATITY_UNIT_ID = dropdownValueCapacityUnit.UNIT_ID;
        widget.ItemsDataProduct.VOLUMN_UNIT_ID = dropdownValueSizeUnit.SIZE_ID;

        item_ops.add(widget.ItemsDataProduct);
      } else {
        item_ops.add(new ItemsListArrestOps(
            null,
            null,
            null,
            null,
            sProductGroup.PRODUCT_GROUP_ID,
            sProductCategory != null ? sProductCategory.PRODUCT_CATEGORY_ID : null,
            sProductType != null ? sProductType.PRODUCT_TYPE_ID : null,
            null,
            null,
            sProductBrand != null ? sProductBrand.PRODUCT_BRAND_ID : null,
            null,
            null,
            null,
            null,
            sProductGroup.PRODUCT_GROUP_NAME,
            sProductCategory != null ? sProductCategory.PRODUCT_CATEGORY_NAME : "",
            sProductType != null ? sProductType.PRODUCT_TYPE_NAME : "",
            null,
            null,
            sProductBrand != null ? sProductBrand.PRODUCT_BRAND_NAME_TH : (_textListProductBrand != null ? _textListProductBrand.textField.controller.text : ""),
            null,
            null,
            null,
            null,
            null,
            null,
            dropdownValueSizeUnit != null ? dropdownValueSizeUnit.SIZE_ID : null,
            editCapacity.text.isEmpty ? null : double.parse(editCapacity.text),
            dropdownValueSizeUnit != null ? dropdownValueSizeUnit.SIZE_ID : null,
            editSize.text.isEmpty ? null : double.parse(editSize.text),
            dropdownValueCapacityUnit != null ? dropdownValueCapacityUnit.UNIT_ID : null,
            double.parse(editVolumn.text),
            dropdownValueSizeUnit != null ? dropdownValueSizeUnit.SIZE_NAME_TH : "",
            dropdownValueCapacityUnit != null ? dropdownValueCapacityUnit.UNIT_NAME_TH : "",
            editVolumnUnit.text,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            editBrandDetail.text,
            null, //COMPANYNAME,
            "",
            1,
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
            null));
      }

      ItemsListArrest5Test items_test = new ItemsListArrest5Test(_itemsData, item_ops);
      Navigator.pop(context, items_test);

      //Navigator.pop(context, _itemsData);
    }
  }

  Future<bool> onLoadActionInsProductAllMaster(Map map) async {
    int PRODUCT_MAPPING_ID;
    await new ArrestFutureMaster().apiRequestMasProductMappinginsAll(map).then((onValue) {
      PRODUCT_MAPPING_ID = onValue.RESPONSE_DATA;
      print(onValue.RESPONSE_DATA);
    });
    /*await new ArrestFuture().apiRequestArrestProductinsAll(map).then((onValue) {
      PRODUCT_MAPPING_ID = onValue.;
      print(onValue.RESPONSE_DATA);
    });*/
    Map map_id = {"PRODUCT_MAPPING_ID": PRODUCT_MAPPING_ID};

    await new ArrestFutureMaster().apiRequestMasProductMappinggetByCon(map_id).then((onValue) {
      _itemsData = onValue.RESPONSE_DATA;
      if (onValue.SUCCESS) {
        Navigator.pop(context, _itemsData);
      }
    });
    setState(() {});
    return true;
  }

  AutoCompleteTextField _textListProductGroup;
  AutoCompleteTextField _textListProductCategory;
  AutoCompleteTextField _textListProductType;
  AutoCompleteTextField _textListProductBrand;
  AutoCompleteTextField _textListProductSecondBrand;
  AutoCompleteTextField _textListProductModel;

  void setAutoCompleteProductGroup() {
    _textListProductGroup = new AutoCompleteTextField<ItemsListProductGROUPCategory>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          sProductGroup = item;
          _textListProductGroup.textField.controller.text = sProductGroup.PRODUCT_GROUP_NAME.toString();

          _setProductDetail();

          if (sProductGroup.PRODUCT_GROUP_NAME.endsWith("รถยนต์") || sProductGroup.PRODUCT_GROUP_NAME.endsWith("รถจักรยานยนต์")) {
            IsMotor = true;
          } else {
            IsMotor = false;
          }

          sProductCategory = null;
          sProductType = null;
          sProductBrand = null;
          _onSelectProductGroup(sProductGroup.PRODUCT_GROUP_ID);
        });
      },
      key: key_product_group,
      suggestions: widget.ItemsProductGroup,
      itemBuilder: (context, suggestion) => sProductGroup == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.PRODUCT_GROUP_NAME, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.PRODUCT_GROUP_ID == b.PRODUCT_GROUP_ID ? 0 : a.PRODUCT_GROUP_ID > b.PRODUCT_GROUP_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sProductGroup = null;
        return suggestion.PRODUCT_GROUP_NAME.toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  void setAutoCompleteProductCategory() {
    GlobalKey key_product_cate = new GlobalKey<AutoCompleteTextFieldState<ItemsListProductCategory>>();
    bool IsSubmitted = false;
    _textListProductCategory = new AutoCompleteTextField<ItemsListProductCategory>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListProductCategory.textField.controller.text = item.PRODUCT_CATEGORY_NAME.toString();
          sProductCategory = item;
          _setProductDetail();

          sProductType = null;
          sProductBrand = null;
          _onSelectProductCategory(sProductCategory.PRODUCT_CATEGORY_ID);
        });
      },
      key: key_product_cate,
      suggestions: ItemsProductCategory.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sProductCategory == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.PRODUCT_CATEGORY_NAME, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.PRODUCT_CATEGORY_ID == b.PRODUCT_CATEGORY_ID ? 0 : a.PRODUCT_CATEGORY_ID > b.PRODUCT_CATEGORY_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sProductCategory = null;
        return suggestion.PRODUCT_CATEGORY_NAME.toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  void setAutoCompleteProductType() {
    GlobalKey key_product_type = new GlobalKey<AutoCompleteTextFieldState<ItemsListProductType>>();
    _textListProductType = new AutoCompleteTextField<ItemsListProductType>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      itemSubmitted: (item) {
        setState(() {
          _textListProductType.textField.controller.text = item.PRODUCT_TYPE_NAME.toString();
          sProductType = item;
          _setProductDetail();

          sProductBrand = null;
          _onSelectProductType(sProductGroup.PRODUCT_GROUP_ID, sProductCategory.PRODUCT_CATEGORY_ID, sProductType.PRODUCT_TYPE_ID);
        });
      },
      key: key_product_type,
      suggestions: ItemsProductType.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sProductType == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.PRODUCT_TYPE_NAME, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.PRODUCT_TYPE_ID == b.PRODUCT_TYPE_ID ? 0 : a.PRODUCT_TYPE_ID > b.PRODUCT_TYPE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sProductType = null;
        return suggestion.PRODUCT_TYPE_NAME.toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  void setAutoCompleteProductBrand() {
    GlobalKey key_product_brand = new GlobalKey<AutoCompleteTextFieldState<ItemsListProductBrand>>();
    _textListProductBrand = new AutoCompleteTextField<ItemsListProductBrand>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editMainBrand,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListProductBrand.textField.controller.text = item.PRODUCT_BRAND_NAME_TH.toString();
          sProductBrand = item;
          _setProductDetail();

          sProductSubBrand = null;
          sProductModel = null;
          _onSelectProductSubBrand(
            sProductBrand.PRODUCT_BRAND_ID,
          );
        });
      },
      key: key_product_brand,
      suggestions: ItemsProductBrand.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sProductBrand == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.PRODUCT_BRAND_NAME_TH, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.PRODUCT_BRAND_ID == b.PRODUCT_BRAND_ID ? 0 : a.PRODUCT_BRAND_ID > b.PRODUCT_BRAND_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sProductBrand = null;
        return suggestion.PRODUCT_BRAND_NAME_TH.toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  void setAutoCompleteProductSecondBrand() {
    GlobalKey key_product_brand = new GlobalKey<AutoCompleteTextFieldState<ItemsListProductSubBrand>>();
    _textListProductSecondBrand = new AutoCompleteTextField<ItemsListProductSubBrand>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editSubBrand,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListProductSecondBrand.textField.controller.text = item.PRODUCT_SUBBRAND_NAME_TH.toString();
          sProductSubBrand = item;

          sProductModel = null;
          _onSelectProductModel(sProductSubBrand.PRODUCT_SUBBRAND_ID);

          _setProductDetail();
        });
      },
      key: key_product_brand,
      suggestions: ItemsProductSubBrand.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sProductSubBrand == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.PRODUCT_SUBBRAND_NAME_TH, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.PRODUCT_SUBBRAND_ID == b.PRODUCT_SUBBRAND_ID ? 0 : a.PRODUCT_SUBBRAND_ID > b.PRODUCT_SUBBRAND_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sProductSubBrand = null;
        return suggestion.PRODUCT_SUBBRAND_NAME_TH.toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  void setAutoCompleteProductModel() {
    GlobalKey key_product_brand = new GlobalKey<AutoCompleteTextFieldState<ItemsListProductModel>>();
    _textListProductSecondBrand = new AutoCompleteTextField<ItemsListProductModel>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editModel,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListProductSecondBrand.textField.controller.text = item.PRODUCT_MODEL_NAME_TH.toString();
          sProductModel = item;
          _setProductDetail();
        });
      },
      key: key_product_brand,
      suggestions: ItemsProductModel.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sProductModel == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.PRODUCT_MODEL_NAME_TH, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.PRODUCT_MODEL_ID == b.PRODUCT_MODEL_ID ? 0 : a.PRODUCT_MODEL_ID > b.PRODUCT_MODEL_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sProductModel = null;
        return suggestion.PRODUCT_MODEL_NAME_TH.toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  void _setProductDetail() {
    /*if(sProductGroup!=null
        &&sProductCategory==null
        &&sProductType==null
        &&sProductBrand==null){
      editBrandDetail.text = sProductGroup.PRODUCT_GROUP_NAME.toString();
    }else if(sProductGroup!=null
        &&sProductCategory!=null
        &&sProductType==null
        &&sProductBrand==null){
      editBrandDetail.text = sProductGroup.PRODUCT_GROUP_NAME.toString()+" "+sProductCategory.PRODUCT_CATEGORY_NAME.toString();
    }else if(sProductGroup!=null
        &&sProductCategory!=null
        &&sProductType!=null
        &&sProductBrand==null){
      editBrandDetail.text = sProductGroup.PRODUCT_GROUP_NAME.toString()+
          " "+sProductCategory.PRODUCT_CATEGORY_NAME.toString()+
          " "+sProductType.PRODUCT_TYPE_NAME.toString();
    }else if(sProductGroup!=null
        &&sProductCategory!=null
        &&sProductType!=null
        &&sProductBrand!=null){
      editBrandDetail.text = sProductGroup.PRODUCT_GROUP_NAME.toString()+
          " "+sProductCategory.PRODUCT_CATEGORY_NAME.toString()+
          " "+sProductType.PRODUCT_TYPE_NAME.toString()+
          " "+_textListProductBrand.textField.controller.text;
    }else{
      //editBrandDetail.text ="";
    }*/
    editBrandDetail.text = (sProductGroup != null ? sProductGroup.PRODUCT_GROUP_NAME.toString() : "") +
        " " +
        (sProductCategory != null ? sProductCategory.PRODUCT_CATEGORY_NAME.toString() : "") +
        " " +
        (sProductType != null ? sProductType.PRODUCT_TYPE_NAME.toString() : "") +
        " " +
        (sProductBrand != null ? sProductBrand.PRODUCT_BRAND_NAME_TH.toString() : (_textListProductBrand != null ? _textListProductBrand.textField.controller.text : "")) +
        " " +
        (sProductSubBrand != null ? sProductSubBrand.PRODUCT_SUBBRAND_NAME_TH.toString() : (_textListProductSecondBrand != null ? editSecondaryBrand.text : "")) +
        " " +
        (sProductModel != null ? sProductModel.PRODUCT_MODEL_NAME_TH.toString() : (_textListProductModel != null ? _textListProductModel.textField.controller.text : "")) +
        " " +
        editNumbeMotor.text +
        " " +
        editNumberTank.text;
    ;
  }

  _navigateSearch(BuildContext context) async {
    /*final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest5Search(
                IsSearch: widget.IsSearch,
                IsUpdate: widget.IsUpdate,
                itemsMasProductUnit: widget.itemsMasProductUnit,
                itemsMasProductSize: widget.itemsMasProductSize,
                //itemProductMapping: _itemsData,
              )),
    );
    if (result.toString() != "back") {
      Navigator.pop(context, result);
    }*/
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
        !widget.IsUpdate
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: new Card(
                    elevation: 0.0,
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: new GestureDetector(
                      onTap: () {
                        _navigateSearch(context);
                      },
                      child: new ListTile(
                        leading: new Icon(Icons.search),
                        title: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              'ค้นหาของกลาง',
                              style: TextStyle(fontSize: 16.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "หมวดหมู่สินค้า",
                style: textLabelStyle,
              ),
              Text(
                " *",
                style: textStyleStar,
              ),
            ],
          ),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: /*_textListProductGroup*/ DropdownButtonHideUnderline(
            child: DropdownButton<ItemsListProductGROUPCategory>(
              isExpanded: true, //
              value: sProductGroup,
              onChanged: (ItemsListProductGROUPCategory newValue) {
                setState(() {
                  sProductGroup = newValue;
                  _setProductDetail();

                  if (sProductGroup.PRODUCT_GROUP_NAME.endsWith("รถยนต์") || sProductGroup.PRODUCT_GROUP_NAME.endsWith("รถจักรยานยนต์")) {
                    IsMotor = true;
                  } else {
                    IsMotor = false;
                  }

                  sProductCategory = null;
                  sProductType = null;
                  sProductBrand = null;
                  _onSelectProductGroup(sProductGroup.PRODUCT_GROUP_ID);
                });
              },
              items: widget.ItemsProductGroup.map<DropdownMenuItem<ItemsListProductGROUPCategory>>((ItemsListProductGROUPCategory value) {
                return DropdownMenuItem<ItemsListProductGROUPCategory>(
                  value: value,
                  child: Text(
                    value.PRODUCT_GROUP_NAME.toString(),
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
          child: Row(
            children: <Widget>[
              Text(
                "กลุ่มสินค้า",
                style: textLabelStyle,
              ),
              /*Text(" *", style: textStyleStar,),*/
            ],
          ),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: /*_textListProductCategory*/
              DropdownButtonHideUnderline(
            child: ItemsProductCategory != null
                ? DropdownButton<ItemsListProductCategory>(
                    isExpanded: true, //
                    value: sProductCategory,
                    onChanged: (ItemsListProductCategory newValue) {
                      setState(() {
                        sProductCategory = newValue;
                        _setProductDetail();

                        sProductType = null;
                        sProductBrand = null;
                        _onSelectProductCategory(sProductCategory.PRODUCT_CATEGORY_ID);
                      });
                    },
                    items: ItemsProductCategory.RESPONSE_DATA.map<DropdownMenuItem<ItemsListProductCategory>>((ItemsListProductCategory value) {
                      return DropdownMenuItem<ItemsListProductCategory>(
                        value: value,
                        child: Text(
                          value.PRODUCT_CATEGORY_NAME.toString(),
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
          child: /*_textListProductType*/ DropdownButtonHideUnderline(
            child: ItemsProductType != null
                ? DropdownButton<ItemsListProductType>(
                    isExpanded: true, //
                    value: sProductType,
                    onChanged: (ItemsListProductType newValue) {
                      setState(() {
                        sProductType = newValue;
                        _setProductDetail();

                        sProductBrand = null;
                        _onSelectProductType(sProductGroup.PRODUCT_GROUP_ID, sProductCategory.PRODUCT_CATEGORY_ID, sProductType.PRODUCT_TYPE_ID);
                      });
                    },
                    items: ItemsProductType.RESPONSE_DATA.map<DropdownMenuItem<ItemsListProductType>>((ItemsListProductType value) {
                      return DropdownMenuItem<ItemsListProductType>(
                        value: value,
                        child: Text(
                          value.PRODUCT_TYPE_NAME.toString(),
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
        sProductGroup != null && (sProductGroup.PRODUCT_GROUP_ID == 6 || sProductGroup.PRODUCT_GROUP_ID == 7)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ยี่ห้อหลักสินค้า",
                      style: textLabelStyle,
                    ),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child:
                        /*TextField(
                focusNode: myFocusNodeMainBrand,
                controller: editMainBrand,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                style: textInputStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),*/
                        _textListProductBrand,
                  ),
                  _buildLine,
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ยี่ห้อรองสินค้า",
                      style: textLabelStyle,
                    ),
                  ),
                  Padding(
                      padding: paddingInputBox,
                      child:
                          _textListProductSecondBrand /*TextField(
                focusNode: myFocusNodeSecondaryBrand,
                controller: editSecondaryBrand,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                style: textInputStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),*/
                      ),
                  _buildLine,
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "รุ่นสินค้า",
                      style: textLabelStyle,
                    ),
                  ),
                  Padding(
                      padding: paddingInputBox,
                      child:
                          _textListProductModel /*TextField(
                focusNode: myFocusNodeProductModel,
                controller: editProductModel,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                style: textInputStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),*/
                      ),
                  _buildLine,
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "หมายเลขเครื่องยนต์",
                      style: textLabelStyle,
                    ),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: TextField(
                      focusNode: myFocusNodeNumbeMotor,
                      controller: editNumbeMotor,
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
                    child: Text(
                      "หมายเลขตัวถัง",
                      style: textLabelStyle,
                    ),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: TextField(
                      focusNode: myFocusNodeNumberTank,
                      controller: editNumberTank,
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
              )
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ยี่ห้อสินค้า",
                        style: textLabelStyle,
                      ),
                    ),
                    Container(width: Width, child: _textListProductBrand),
                    _buildLine,
                  ],
                ),
              ),
        Container(
          padding: paddingLabel,
          child: Text(
            "ข้อมูลสินค้า",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusBrandDetail,
            controller: editBrandDetail,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
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
                    child: Row(
                      children: <Widget>[
                        Text(
                          "ขนาด",
                          style: textLabelStyle,
                        ),
                        /*Text(" *", style: textStyleStar,),*/
                      ],
                    ),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: TextField(
                      focusNode: myFocusNodeSize,
                      controller: editSize,
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.words,
                      style: textInputStyle,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        xSize = double.parse(text);
                        zTotal = xSize * yCount;
                        editVolumn.text = formatter.format(zTotal).toString();
                      },
                    ),
                  ),
                  _buildLine,
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
                    child: Row(
                      children: <Widget>[
                        Text(
                          "หน่วย",
                          style: textLabelStyle,
                        ),
                        /*Text(" *", style: textStyleStar,),*/
                      ],
                    ),
                  ),
                  Container(
                    width: Width,
                    //padding: paddingInputBox,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<ItemsListProductSize>(
                        isExpanded: true,
                        value: dropdownValueSizeUnit,
                        onChanged: (ItemsListProductSize newValue) {
                          setState(() {
                            dropdownValueSizeUnit = newValue;
                            editVolumnUnit.text = dropdownValueSizeUnit.SIZE_NAME_TH.toString();
                          });
                        },
                        items: dropdownItemsSizeUnit.RESPONSE_DATA.map<DropdownMenuItem<ItemsListProductSize>>((ItemsListProductSize value) {
                          return DropdownMenuItem<ItemsListProductSize>(
                            value: value,
                            child: Text(value.SIZE_NAME_TH.toString(), style: textInputStyle),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  _buildLine,
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
                    child: Row(
                      children: <Widget>[
                        Text(
                          "จำนวน",
                          style: textLabelStyle,
                        ),
                        Text(
                          " *",
                          style: textStyleStar,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: TextField(
                      focusNode: myFocusNodeCapacity,
                      controller: editCapacity,
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.words,
                      style: textInputStyle,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        xSize = 0;
                        if (editSize.text.isEmpty) {
                          xSize = 0;
                        } else {
                          xSize = double.parse(editSize.text);
                        }
                        yCount = int.parse(text);
                        zTotal = xSize * yCount;
                        editVolumn.text = formatter.format(zTotal).toString();
                      },
                    ),
                  ),
                  _buildLine,
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
                    child: Row(
                      children: <Widget>[
                        Text(
                          "หน่วย",
                          style: textLabelStyle,
                        ),
                        Text(
                          " *",
                          style: textStyleStar,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Width,
                    //padding: paddingInputBox,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<ItemsListProductUnit>(
                        isExpanded: true,
                        value: dropdownValueCapacityUnit,
                        onChanged: (ItemsListProductUnit newValue) {
                          setState(() {
                            dropdownValueCapacityUnit = newValue;
                          });
                        },
                        items: dropdownItemsCapacityUnit.RESPONSE_DATA.map<DropdownMenuItem<ItemsListProductUnit>>((ItemsListProductUnit value) {
                          return DropdownMenuItem<ItemsListProductUnit>(value: value, child: new Container(width: Width, child: new Text(value.UNIT_NAME_TH.toString(), overflow: TextOverflow.ellipsis, style: textInputStyle)));
                        }).toList(),
                      ),
                    ),
                  ),
                  _buildLine,
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
                      focusNode: myFocusNodeVolumn,
                      controller: editVolumn,
                      keyboardType: TextInputType.number,
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
                  Container(
                    width: Width,
                    //padding: paddingInputBox,
                    child: TextField(
                      enabled: false,
                      focusNode: myFocusNodeVolumnUnit,
                      controller: editVolumnUnit,
                      keyboardType: TextInputType.text,
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
        /*Container(
          padding: paddingLabel,
          child: Text("ระบุเพิ่มเติม", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeOther,
            controller: editOther,
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

  _navigateSaved(BuildContext context) async {
    /*showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionProuductProductMappingMaster();
    Navigator.pop(context);

    if(_itemsData.length>0) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabScreenArrest5Search(IsUpdate: widget.IsUpdate,)),
      );
      if(result.toString()!="back"){
        _itemsData = result;
        Navigator.pop(context,result);
      }
    }else{
      _showSearchEmptyAlertDialog(context,"ไม่พบข้อมูลของกลาง");
    }*/
  }

  /*_navigateCreate(BuildContext mContext)async {
    final result = await Navigator.push(
      mContext,
      MaterialPageRoute(builder: (context) =>
          TabScreenArrest5Creating(
            ItemsData: null,
          )),
    );
    if (result.toString() != "back") {
      Navigator.pop(context, result);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
          //backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              title: new Padding(
                padding: EdgeInsets.only(right: 22.0),
                child: new Text(
                  "ของกลาง",
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
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    //_navigateSaved(context);
                    _onSaved(context);
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

  void _onSelectProductGroup(int PRODUCT_GROUP_ID) async {
    await onLoadActionProuductCategoryMaster(PRODUCT_GROUP_ID);
  }

  void _onSelectProductCategory(int PRODUCT_CATEGORY_ID) async {
    await onLoadActionProuductTypeMaster(PRODUCT_CATEGORY_ID);
  }

  void _onSelectProductType(int PRODUCT_GROUP_ID, int PRODUCT_CATEGORY_ID, int PRODUCT_TYPE_ID) async {
    await onLoadActionProuductBrandMaster(PRODUCT_GROUP_ID, PRODUCT_CATEGORY_ID, PRODUCT_TYPE_ID);
  }

  void _onSelectProductSubBrand(int PRODUCT_BRAND_ID) async {
    await onLoadActionProuductSubBrandMaster(PRODUCT_BRAND_ID);
  }

  void _onSelectProductModel(int PRODUCT_SUBBRAND_ID) async {
    await onLoadActionProuductModelMaster(null, PRODUCT_SUBBRAND_ID);
  }

  Future<bool> onLoadActionProuductTypeMaster(int PRODUCT_CATEGORY_ID) async {
    Map map = {"TEXT_SEARCH": "", "PRODUCT_CATEGORY_ID": PRODUCT_CATEGORY_ID, "PRODUCT_TYPE_ID": ""};
    await new ArrestFutureMaster().apiRequestMasProductTypegetByCon(map).then((onValue) {
      ItemsProductType = onValue;
      if (ItemsProductType.SUCCESS && ItemsProductType.RESPONSE_DATA.length > 0) {
        setAutoCompleteProductType();
      }

      if (widget.IsUpdate) {
        if (ItemsProductType != null) {
          ItemsProductType.RESPONSE_DATA.forEach((item) {
            if (item.PRODUCT_TYPE_ID == widget.ItemsDataProduct.PRODUCT_TYPE_ID) {
              sProductType = item;
            }
          });
        }
      }
    });
    this.onLoadActionProuductBrandMaster(sProductGroup.PRODUCT_GROUP_ID, PRODUCT_CATEGORY_ID, null);
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionProuductCategoryMaster(int PRODUCT_GROUP_ID) async {
    Map map = {"TEXT_SEARCH": "", "PRODUCT_GROUP_ID": PRODUCT_GROUP_ID, "PRODUCT_CATEGORY_ID": ""};

    await new ArrestFutureMaster().apiRequestMasProductCategorygetByCon(map).then((onValue) {
      ItemsProductCategory = onValue;
      if (ItemsProductCategory.SUCCESS && ItemsProductCategory.RESPONSE_DATA.length > 0) {
        setAutoCompleteProductCategory();
      }

      if (widget.IsUpdate) {
        if (ItemsProductCategory != null) {
          ItemsProductCategory.RESPONSE_DATA.forEach((item) {
            print("cate : " + item.PRODUCT_CATEGORY_NAME);
            if (item.PRODUCT_CATEGORY_ID == widget.ItemsDataProduct.PRODUCT_CATEGORY_ID) {
              sProductCategory = item;
            }
          });
        }
        if (sProductCategory != null) {
          this.onLoadActionProuductTypeMaster(sProductCategory.PRODUCT_CATEGORY_ID);
        }
      }

      this.onLoadActionProuductBrandMaster(PRODUCT_GROUP_ID, null, null);
      this.onLoadActionProuductSubBrandMaster(null);
      this.onLoadActionProuductModelMaster(null, null);
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionProuductBrandMaster(int PRODUCT_GROUP_ID, int PRODUCT_CATEGORY_ID, int PRODUCT_TYPE_ID) async {
    Map map = {"TEXT_SEARCH": "", "PRODUCT_GROUP_ID": PRODUCT_GROUP_ID, "PRODUCT_CATEGORY_ID": PRODUCT_CATEGORY_ID != null ? PRODUCT_CATEGORY_ID : "", "PRODUCT_TYPE_ID": PRODUCT_TYPE_ID != null ? PRODUCT_TYPE_ID : "", "PRODUCT_SUBTYPE_ID": "", "PRODUCT_SUBSETTYPE_ID": "", "PRODUCT_BRAND_ID": ""};

    await new ArrestFutureMaster().apiRequestMasProductBrandgetByCon(map).then((onValue) {
      ItemsProductBrand = onValue;
      if (ItemsProductBrand.SUCCESS && ItemsProductBrand.RESPONSE_DATA.length > 0) {
        setAutoCompleteProductBrand();
      } else {
        //not product brand
        setAutoCompleteProductBrand();

        if (widget.IsUpdate) {
          ItemsProductBrand.RESPONSE_DATA.forEach((f) {
            if (f.PRODUCT_BRAND_ID == widget.ItemsDataProduct.PRODUCT_BRAND_ID) {
              sProductBrand = f;
              _textListProductBrand.textField.controller.text = sProductBrand.PRODUCT_BRAND_NAME_TH;
            }
          });
        }
      }

      if (sProductBrand != null) {
        this.onLoadActionProuductSubBrandMaster(sProductBrand.PRODUCT_BRAND_ID);
      }
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionProuductSubBrandMaster(int PRODUCT_BRAND_ID) async {
    Map map = {"TEXT_SEARCH": "", "PRODUCT_BRAND_ID": PRODUCT_BRAND_ID != null ? PRODUCT_BRAND_ID : "", "PRODUCT_SUBBRAND_ID": ""};

    await new ArrestFutureMaster().apiRequestMasProductSubBrandgetByCon(map).then((onValue) {
      print(onValue.SUCCESS.toString() + ", " + onValue.RESPONSE_DATA[0].PRODUCT_SUBBRAND_NAME_TH);
      ItemsProductSubBrand = onValue;
      if (ItemsProductSubBrand.SUCCESS && ItemsProductSubBrand.RESPONSE_DATA.length > 0) {
        setAutoCompleteProductSecondBrand();
      }

      if (sProductSubBrand != null) {
        this.onLoadActionProuductModelMaster(PRODUCT_BRAND_ID, sProductSubBrand.PRODUCT_SUBBRAND_ID);
      }
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionProuductModelMaster(int PRODUCT_BRAND_ID, int PRODUCT_SUBBRAND_ID) async {
    Map map = {"TEXT_SEARCH": "", "PRODUCT_BRAND_ID": PRODUCT_BRAND_ID == null ? "" : PRODUCT_BRAND_ID, "PRODUCT_SUBBRAND_ID": PRODUCT_SUBBRAND_ID == null ? "" : PRODUCT_SUBBRAND_ID, "PRODUCT_MODEL_ID": ""};

    await new ArrestFutureMaster().apiRequestMasProductModelgetByCon(map).then((onValue) {
      print(onValue.SUCCESS.toString() + ", " + onValue.RESPONSE_DATA[0].PRODUCT_MODEL_NAME_TH);
      ItemsProductModel = onValue;
      if (ItemsProductModel.SUCCESS && ItemsProductModel.RESPONSE_DATA.length > 0) {
        setAutoCompleteProductModel();
      }
    });
    setState(() {});
    return true;
  }
}
