import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_controller.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product_mapping.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_created.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/SetProductName.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class TabScreenArrest5SearchResult extends StatefulWidget {
  bool IsSearch;
  bool IsUpdate;
  bool IsNotice;
  // ItemsMasProductSizeResponse itemsMasProductSize;
  // ItemsMasProductUnitResponse itemsMasProductUnit;
  List itemProductMapping;
  TabScreenArrest5SearchResult({
    Key key,
    @required this.IsNotice,
    @required this.IsSearch,
    @required this.IsUpdate,
    // @required this.itemsMasProductUnit,
    // @required this.itemsMasProductSize,
    @required this.itemProductMapping,
  }) : super(key: key);
  @override
  _TabScreenArrest5SearchResultState createState() => new _TabScreenArrest5SearchResultState();
}

class _TabScreenArrest5SearchResultState extends State<TabScreenArrest5SearchResult> {
  TabController tabController;
  List _itemsInit = [];
  List _itemsData = [];
  int _countItem = 0;
  bool isCheckAll = false;

  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily, fontWeight: FontWeight.w600);
  TextStyle textInputStyleSubTitle = TextStyle(color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleSubTitle2 = TextStyle(color: Colors.grey[500], fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: FontStyles().FontFamily);
  TextStyle textCheckAllStyle = TextStyle(fontSize: 16.0, color: Color(0xff2e76bc), fontFamily: FontStyles().FontFamily);
  TextStyle styleTextSearch = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);

  TextEditingController controller = new TextEditingController();

  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

  List _itemProduct = [];

  @override
  void initState() {
    super.initState();
    _itemsInit = widget.itemProductMapping;
    List _tempItemProduct = [];
    _itemsInit.forEach((f) {
      _tempItemProduct.add(f);
    });
    _itemProduct = _tempItemProduct;
  }

  Future<bool> onLoadActionProuductProductMappingMaster(Map map) async {
    await new ArrestFutureMaster().apiRequestMasProductMappinggetByKeyword(map).then((onValue) {
      _itemsInit = onValue.RESPONSE_DATA;
      //this.onLoadActionDistinctMaster(onValue.RESPONSE_DATA[0].PROVINCE_ID);
    });
    setState(() {});
    return true;
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
    Map map = {'TEXT_SEARCH': text};
    await onLoadActionProuductProductMappingMaster(map);
    Navigator.pop(context);
    if (_itemsInit.length == 0) {
      new EmptyDialog(context, "ไม่พบข้อมูลของกลาง");
    }
  }

  // nav next page
  _navigateCreaet(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest5Created(
                IsNotice: widget.IsNotice,
                ItemsData: _itemsData,
                // itemsMasProductUnit: widget.itemsMasProductUnit,
                // itemsMasProductSize: widget.itemsMasProductSize,
              )),
    );
    if (result.toString() != "back") {
      //_itemsData = result;
      Navigator.pop(context, result);
    }
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _itemProduct.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (widget.IsUpdate) {
                _itemsInit[index].IsCheck = !_itemsInit[index].IsCheck;
                for (int i = 0; i < _itemsInit.length; i++) {
                  if (index != i) {
                    _itemsInit[i].IsCheck = false;
                  }
                }
              } else {
                _itemsInit[index].IsCheck = !_itemsInit[index].IsCheck;
                int count = 0;
                _itemsInit.forEach((item) {
                  if (item.IsCheck) {
                    count++;
                  }
                });
                count == _itemsInit.length ? isCheckAll = true : isCheckAll = false;
              }
            });
          },
          child: Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
              padding: EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[100], width: 6.0),
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
                            _itemProduct[index].PRODUCT_DESC,
                            // '00000',
                            style: textInputStyleTitle,
                          ),
                        ),
                      ),
                      Center(
                          child: InkWell(
                        onTap: () {
                          setState(() {
                            if (widget.IsUpdate) {
                              _itemsInit[index].IsCheck = !_itemsInit[index].IsCheck;
                              for (int i = 0; i < _itemsInit.length; i++) {
                                if (index != i) {
                                  _itemsInit[i].IsCheck = false;
                                }
                              }
                            } else {
                              _itemsInit[index].IsCheck = !_itemsInit[index].IsCheck;
                              int count = 0;
                              _itemsInit.forEach((item) {
                                if (item.IsCheck) {
                                  count++;
                                }
                              });
                              count == _itemsInit.length ? isCheckAll = true : isCheckAll = false;
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: widget.IsUpdate ? BoxShape.circle : BoxShape.rectangle,
                            color: _itemsInit[index].IsCheck ? Color(0xff3b69f3) : Colors.white,
                            border: _itemsInit[index].IsCheck ? Border.all(color: Color(0xff3b69f3), width: 2) : Border.all(color: Colors.grey[400], width: 2),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: _itemsInit[index].IsCheck
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
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ราคาขายปลีกแนะนำ " + _itemsInit[index].PRICE.toString() + " บาท",
                      style: textInputStyleSubTitle,
                    ),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      _itemsInit[index].COMPANYNAME != "" ? "บริษัท " + _itemsInit[index].COMPANYNAME : "บริษัท ไม่ระบุ",
                      // "บริษัท ทดสอบ",
                      style: textInputStyleSubTitle2,
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

    bool isCheck = false;
    _countItem = 0;
    _itemsInit.forEach((item) {
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
                _itemsData = [];
                _itemsInit.forEach((item) {
                  if (item.IsCheck) _itemsData.add(item);
                });
                /*if (widget.IsSearch) {
            Navigator.pop(context, _itemsData);
          } else {
            _navigateCreaet(context);
          }*/
                _navigateCreaet(context);
              },
              child: Center(
                child: Text(
                  'เลือก (${_countItem.toString()})',
                  style: textStyleButton,
                ),
              ),
            ),
          )
        : null;
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
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                    )),
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
}
