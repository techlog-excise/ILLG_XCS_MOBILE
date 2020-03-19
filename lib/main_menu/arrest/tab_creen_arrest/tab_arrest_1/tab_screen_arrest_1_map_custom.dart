import 'dart:async';
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_location.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_distinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_category.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_province.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_subdistinct.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class TabScreenArrest1MapCustom extends StatefulWidget {
  ItemsListArrestLocation itemsLocale;
  bool IsPageArrest;
  TabScreenArrest1MapCustom({
    Key key,
    @required this.itemsLocale,
    @required this.IsPageArrest,
  }) : super(key: key);
  @override
  _TabScreenArrest1MapState createState() => new _TabScreenArrest1MapState();
}

class _TabScreenArrest1MapState extends State<TabScreenArrest1MapCustom> {
  TabController tabController;

  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  bool isLoading = false;
  String errorMessage;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LocationData _startLocation;
  LocationData _currentLocation;
  StreamSubscription<LocationData> _locationSubscription;
  Location _locationService = new Location();
  bool _permission = false;
  String error;
  bool currentWidget = true;

  bool isPlace = false;
  bool isClearProvice = false;

  String _placeName = "", _addressno = "", _province = "", _distict = "", _sub_distinct = "", _lane = "", _gps = "", _pos = "", _country = "", _road = "";
  String placeAddress = "";

  //textfield
  final FocusNode myFocusNodeArrestRoad = FocusNode();
  final FocusNode myFocusNodeArrestLane = FocusNode();
  final FocusNode myFocusNodeArrestHouseNumber = FocusNode();
  final FocusNode myFocusNodeArrestOther = FocusNode();

  TextEditingController editArrestRoad = new TextEditingController();
  TextEditingController editArrestLane = new TextEditingController();
  TextEditingController editArrestHouseNumber = new TextEditingController();
  TextEditingController editArrestOther = new TextEditingController();

  ItemsMasterProvinceResponse ItemProvince;
  ItemsMasterDistictResponse ItemDistrict;
  ItemsMasterSubDistictResponse ItemSubDistrict;

  ItemsListSubDistict sSubDistrict;
  ItemsListDistict sDistrict;
  ItemsListProvince sProvince;

  ItemsMasterProvinceResponse ItemProvinceMap;
  ItemsMasterDistictResponse ItemDistrictMap;
  ItemsMasterSubDistictResponse ItemSubDistrictMap;

  ItemsListSubDistict sSubDistrictMap;
  ItemsListDistict sDistrictMap;
  ItemsListProvince sProvinceMap;

  ItemsListArrestLocation itemsLocale;

  //Place Style
  TextStyle textStylePlaceName = TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePlaceAddress = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);

  //App Bar Style
  TextStyle textStyleAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);

  //Block Choice Style
  Color backColorChoiceOne = Colors.white;
  Color backColorChoiceTwo = Colors.grey[200];
  TextStyle textStyleSelect = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleUnselect = TextStyle(fontSize: 16.0, color: Colors.black54, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleStar = Styles.textStyleStar;

  //dialog
  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  @override
  void initState() {
    super.initState();
    itemsLocale = widget.itemsLocale;
    if (widget.itemsLocale?.Other?.isEmpty ?? true) {
      editArrestOther.text = "";
    } else {
      editArrestOther.text = widget.itemsLocale.Other;
    }
    print("locale : " + itemsLocale.toString());

    _onSelectCountry(1);
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNodeArrestRoad.dispose();
    myFocusNodeArrestLane.dispose();
    myFocusNodeArrestHouseNumber.dispose();
    myFocusNodeArrestOther.dispose();

    setDisposeAuto(_textListProvince);
    setDisposeAuto(_textListDistrict);
    setDisposeAuto(_textListSubDistrict);
  }

  void setDisposeAuto(AutoCompleteTextField item) {
    if (item.textField.focusNode == null) {
      item.textField.focusNode.dispose();
    }
    if (item.textField.controller == null) {
      item.textField.controller.dispose();
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void _setMarker(placeName) {
    final String markerIdVal = placeName;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      //icon: BitmapDescriptor.fromAsset('assets/icons/marker.png',),
      position: LatLng(_startLocation.latitude, _startLocation.longitude),
      infoWindow: InfoWindow(
        title: markerIdVal, /*snippet: '*'*/
      ),
    );

    setState(() {
      markers = <MarkerId, Marker>{};
      markers[markerId] = marker;
    });
  }

  void getPlaceAddress(latitude, longitude) async {
    final coordinates = new Coordinates(latitude, longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);

    var place = addresses.first;
    _placeName = place.featureName + " " + place.thoroughfare;
    _addressno = place.subThoroughfare;
    _province = place.adminArea;
    _country = place.countryName;
    _pos = place.postalCode;
    _gps = place.coordinates.latitude.toString() + "," + coordinates.longitude.toString();

    placeAddress = place.addressLine;
    _setMarker(place.addressLine);

    if (place.subLocality.contains("เขต")) {
      List splits = place.subLocality.split(" ");
      _distict = splits[1];
    }

    /*print("featureName " + place.featureName);
    print("subLocality " + place.subLocality.toString());
    print("locality " + place.locality.toString());
    print("subAdminArea " + place.subAdminArea.toString());
    print("thoroughfare " + place.thoroughfare.toString());
    print("subThoroughfare " + place.subThoroughfare.toString());
    print("postalCode " + place.postalCode.toString());
    print("adminArea "+place.adminArea);
    print("coordinates "+place.coordinates.latitude.toString()+","+coordinates.longitude.toString());
    print("countryName "+place.countryName);
    print("countryCode "+place.countryCode);
    print("addressLine "+place.addressLine.split(" ").toString());*/
    List addressLine = place.addressLine.split(" ");
    for (int i = 0; i < addressLine.length; i++) {
      if (addressLine[i].toString().endsWith("ซอย")) {
        _lane = addressLine[i + 1];
      } else if (addressLine[i].toString().endsWith("ถนน")) {
        _road = addressLine[i + 1];
      } else if (addressLine[i].toString().endsWith("แขวง")) {
        _sub_distinct = addressLine[i + 1];
      }
    }

    setState(() {});
  }

  initPlatformState() async {
    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();
          print("Location: ${location.latitude}");
          _locationSubscription = _locationService.onLocationChanged().listen((LocationData result) {
            if (mounted) {
              setState(() {
                _currentLocation = result;
                getPlaceAddress(result.latitude, result.longitude);
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
    });
  }

  CupertinoAlertDialog _createCupertinoIsPlaceDialog() {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            "สถานที่เดียวกับเขียนที่",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  isPlace = false;
                  _putAddress();
                });
              },
              child: new Text('ไม่', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  isPlace = true;
                  _putAddress();
                });
              },
              child: new Text('ใช่', style: ButtonAcceptStyle)),
        ]);
  }

  void _putAddress() {
    String houseNumber = editArrestHouseNumber.text;
    String road = editArrestRoad.text;
    String lane = editArrestLane.text;
    String gps = "";
    if (itemsLocale != null) {
      itemsLocale.SUB_DISTICT.SUB_DISTRICT_ID != sSubDistrict.SUB_DISTRICT_ID ? "" : widget.itemsLocale.GPS;
    }
    itemsLocale = new ItemsListArrestLocation(
      sProvince,
      sDistrict,
      sSubDistrict,
      road,
      lane,
      houseNumber,
      gps,
      houseNumber + (lane.isEmpty ? "" : " ซอย " + lane) + (road.isEmpty ? "" : " ถนน " + road) + " อำเภอ/เขต " + sDistrict.DISTRICT_NAME_TH + " ตำบล/แขวง " + sSubDistrict.SUB_DISTRICT_NAME_TH + " จังหวัด " + sProvince.PROVINCE_NAME_TH,
      isPlace,
      editArrestOther.text,
    );
    Navigator.pop(context, itemsLocale);
  }

  void _showIsPlaceAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoIsPlaceDialog();
      },
    );
  }

  void _onSaved() {
    if (/*editArrestHouseNumber.text.isEmpty ||*/
        sProvince == null || sDistrict == null || sSubDistrict == null || editArrestOther.text.isEmpty) {
      new VerifyDialog(context, "กรุณากรอกข้อมูลที่อยู่ให้ครบถ้วน");
    } else {
      // _showIsPlaceAlertDialog();
      _putAddress();
    }
  }
  /*GlobalKey key_province = new GlobalKey<AutoCompleteTextFieldState<ItemsListProvince>>();
  GlobalKey key_districe = new GlobalKey<AutoCompleteTextFieldState<ItemsListDistict>>();
  GlobalKey key_subDistrict = new GlobalKey<AutoCompleteTextFieldState<ItemsListSubDistict>>();*/

  AutoCompleteTextField<ItemsListProvince> _textListProvince;
  AutoCompleteTextField _textListDistrict;
  AutoCompleteTextField _textListSubDistrict;
  TextEditingController editProvince = new TextEditingController();
  TextEditingController editDistrict = new TextEditingController();
  TextEditingController editSubDistrict = new TextEditingController();
  void setAutoCompleteProvince() {
    GlobalKey key_province = new GlobalKey<AutoCompleteTextFieldState<ItemsListProvince>>();
    _textListProvince = new AutoCompleteTextField<ItemsListProvince>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      itemSubmitted: (item) {
        setState(() {
          _textListProvince.textField.controller.text = item.PROVINCE_NAME_TH.toString();

          sProvince = item;

          editDistrict.text = "";
          editSubDistrict.text = "";
          editArrestRoad.text = "";
          editArrestLane.text = "";
          editArrestHouseNumber.text = "";
          sDistrict = null;
          sSubDistrict = null;
          isClearProvice = true;

          print(sProvince.PROVINCE_NAME_TH);
          _onSelectProvince(sProvince.PROVINCE_ID);
        });
        if (!mounted) return;
      },
      key: key_province,
      clearOnSubmit: false,
      controller: editProvince,
      suggestions: ItemProvince.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sProvince == null
          ? new Padding(
              child: new ListTile(
                title: new Text(
                  suggestion.PROVINCE_NAME_TH,
                  style: textInputStyle,
                ),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.PROVINCE_ID == b.PROVINCE_ID ? 0 : a.PROVINCE_ID > b.PROVINCE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sProvince = null;
        return suggestion.PROVINCE_NAME_TH.toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  void setAutoCompleteDistrict() {
    GlobalKey key_districe = new GlobalKey<AutoCompleteTextFieldState<ItemsListDistict>>();
    _textListDistrict = new AutoCompleteTextField<ItemsListDistict>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editDistrict,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListDistrict.textField.controller.text = item.DISTRICT_NAME_TH.toString();

          sDistrict = item;
          ItemDistrict.RESPONSE_DATA.forEach((f) {
            if (f.DISTRICT_NAME_TH.endsWith(sDistrict.DISTRICT_NAME_TH)) {
              editSubDistrict.text = "";
              sSubDistrict = null;
              _onSelectDistrict(f.DISTRICT_ID);
            }
          });
        });
        if (!mounted) return;
      },
      key: key_districe,
      suggestions: ItemDistrict.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sDistrict == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.DISTRICT_NAME_TH, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.DISTRICT_ID == b.DISTRICT_ID ? 0 : a.DISTRICT_ID > b.DISTRICT_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sDistrict = null;
        return suggestion.DISTRICT_NAME_TH.toLowerCase().contains(input.toLowerCase());
      },
    );
  }

  void setAutoCompleteSubDistrict() {
    GlobalKey key_subDistrict = new GlobalKey<AutoCompleteTextFieldState<ItemsListSubDistict>>();
    _textListSubDistrict = new AutoCompleteTextField<ItemsListSubDistict>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editSubDistrict,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListSubDistrict.textField.controller.text = item.SUB_DISTRICT_NAME_TH.toString();

          sSubDistrict = item;
        });
        if (!mounted) return;
      },
      key: key_subDistrict,
      suggestions: ItemSubDistrict.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sSubDistrict == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.SUB_DISTRICT_NAME_TH, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.SUB_DISTRICT_ID == b.SUB_DISTRICT_ID ? 0 : a.SUB_DISTRICT_ID > b.SUB_DISTRICT_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sSubDistrict = null;
        return suggestion.SUB_DISTRICT_NAME_TH.toLowerCase().contains(input.toLowerCase());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //Size Screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //TextField Style
    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: width,
      height: 1.0,
      color: Colors.grey[300],
    );

    var size = MediaQuery.of(context).size;
    final _buildContentCustom = new Center(
      child: Container(
        width: size.width,
        //color: Colors.white,
        padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                Card(
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.all(22.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              padding: paddingLabel,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "สถานที่เกิดเหตุ",
                                    style: textLabelStyle,
                                  ),
                                  Text(
                                    "*",
                                    style: textStyleStar,
                                  ),
                                ],
                              )),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestOther,
                              controller: editArrestOther,
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
                                  "จังหวัด",
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
                                  _textListProvince /*DropdownButtonHideUnderline(
                              child: ItemProvince != null ? DropdownButton<
                                  ItemsListProvince>(
                                isExpanded: true, //
                                value: sProvince,
                                onChanged: (ItemsListProvince newValue) {
                                  setState(() {
                                    sProvince = newValue;
                                    ItemProvince.RESPONSE_DATA.forEach((f) {
                                      if (f.PROVINCE_NAME_TH.endsWith(
                                          sProvince.PROVINCE_NAME_TH)) {
                                        sDistrict = null;
                                        sSubDistrict = null;
                                        _onSelectProvince(f.PROVINCE_ID);
                                      }
                                    });
                                  });
                                },
                                items: ItemProvince.RESPONSE_DATA
                                    .map<DropdownMenuItem<ItemsListProvince>>((
                                    ItemsListProvince value) {
                                  return DropdownMenuItem<ItemsListProvince>(
                                    value: value,
                                    child: Text(value.PROVINCE_NAME_TH,
                                      style: textInputStyle,),
                                  );
                                })
                                    .toList(),
                              ) : Container(),
                            ),*/
                              ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "อำเภอ/เขต",
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
                                  _textListDistrict /*DropdownButtonHideUnderline(
                              child: ItemDistrict != null ? DropdownButton<
                                  ItemsListDistict>(
                                isExpanded: true, //
                                value: sDistrict,
                                onChanged: (ItemsListDistict newValue) {
                                  setState(() {
                                    sDistrict = newValue;
                                    ItemDistrict.RESPONSE_DATA.forEach((f) {
                                      if (f.DISTRICT_NAME_TH.endsWith(
                                          sDistrict.DISTRICT_NAME_TH)) {
                                        sSubDistrict = null;
                                        _onSelectDistrict(f.DISTRICT_ID);
                                      }
                                    });
                                  });
                                },
                                items: ItemDistrict.RESPONSE_DATA
                                    .map<DropdownMenuItem<ItemsListDistict>>((
                                    ItemsListDistict value) {
                                  return DropdownMenuItem<ItemsListDistict>(
                                    value: value,
                                    child: Text(value.DISTRICT_NAME_TH,
                                      style: textInputStyle,),
                                  );
                                })
                                    .toList(),
                              ) : Container(),
                            ),*/
                              ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "ตำบล/แขวง",
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
                                  _textListSubDistrict /*DropdownButtonHideUnderline(
                              child: ItemSubDistrict != null ? DropdownButton<
                                  ItemsListSubDistict>(
                                isExpanded: true, //
                                value: sSubDistrict,
                                onChanged: (ItemsListSubDistict newValue) {
                                  setState(() {
                                    sSubDistrict = newValue;
                                  });
                                },
                                items: ItemSubDistrict.RESPONSE_DATA
                                    .map<
                                    DropdownMenuItem<ItemsListSubDistict>>((
                                    ItemsListSubDistict value) {
                                  return DropdownMenuItem<ItemsListSubDistict>(
                                    value: value,
                                    child: Text(value.SUB_DISTRICT_NAME_TH,
                                      style: textInputStyle,),
                                  );
                                })
                                    .toList(),
                              ) : Container(),
                            ),*/
                              ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ถนน",
                              style: textLabelStyle,
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestRoad,
                              controller: editArrestRoad,
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
                              "ซอย",
                              style: textLabelStyle,
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestLane,
                              controller: editArrestLane,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine,
                          /*Container(
                            padding: paddingLabel,
                            child: Text("บ้านเลขที่", style: textLabelStyle,),
                          ),*/
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "บ้านเลขที่",
                                  style: textLabelStyle,
                                ),
                                //Text("*", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestHouseNumber,
                              controller: editArrestHouseNumber,
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return Scaffold(
        backgroundColor: Colors.grey[200],
        key: homeScaffoldKey,
        appBar: AppBar(
          title: Text(
            'สถานที่เกิดเหตุ',
            style: textStyleAppbar,
          ),
          centerTitle: true,
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  widget.IsPageArrest ? _showIsPlaceAlertDialog() : _onSaved(); // จับกุม _showIsPlaceAlertDialog || ใบแจ้ง _onSaved
                  //_showIsPlaceAlertDialog();
                },
                child: Text('บันทึก', style: textStyleAppbar)),
          ],
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, "Back");
            },
          ),
        ),
        body: Stack(
          children: <Widget>[
            BackgroundContent(),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildContentCustom,
                  ),
                )
              ],
            ),
          ],
        ));
  }

  void _onSelectCountry(int COUNTRY_ID) async {
    await onLoadActionProvinceMaster(COUNTRY_ID);
  }

  void _onSelectProvince(int PROVINCE_ID) async {
    await onLoadActionDistinctMaster(PROVINCE_ID);
  }

  void _onSelectDistrict(int DISTRICT_ID) async {
    await onLoadActionSubDistinctMaster(DISTRICT_ID);
  }

  void _onSelectDataAddress(int PROVINCE_ID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionLoadDataAddressMaster(PROVINCE_ID);

    print("_addressno : " + _addressno);
    print("_road : " + _road);
    print("_lane : " + _lane.isEmpty.toString());
    itemsLocale = new ItemsListArrestLocation(
      sProvince,
      sDistrict,
      sSubDistrict,
      _road,
      _lane,
      _addressno,
      _gps,
      placeAddress,
      isPlace,
      editArrestOther.text,
    );
    Navigator.pop(context, itemsLocale);
  }

  Future<bool> onLoadActionLoadDataAddressMaster(int PROVINCE_ID) async {
    Map map = {"TEXT_SEARCH": "", "DISTRICT_ID": "", "PROVINCE_ID": PROVINCE_ID};
    await new ArrestFutureMaster().apiRequestMasDistrictgetByCon(map).then((onValue) {
      ItemDistrict = onValue;
      ItemDistrict.RESPONSE_DATA.forEach((district) {
        if (_distict.trim().endsWith(district.DISTRICT_NAME_TH.trim())) {
          setState(() {
            sSubDistrict = null;
            sDistrict = district;
            this.onLoadActionSubDistinctMaster(sDistrict.DISTRICT_ID);
          });
        }
      });
      setState(() {});
    });
    Map map_dist = {"TEXT_SEARCH": "", "SUB_DISTRICT_ID": "", "DISTRICT_ID": sDistrict.DISTRICT_ID};
    await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map_dist).then((onValue) {
      ItemSubDistrict = onValue;
      if (ItemSubDistrict != null) {
        ItemSubDistrict.RESPONSE_DATA.forEach((subdistrict) {
          if (_sub_distinct.trim().endsWith(subdistrict.SUB_DISTRICT_NAME_TH.trim())) {
            setState(() {
              sSubDistrict = subdistrict;
            });
          }
        });
      }
    });

    return true;
  }

  Future<bool> onLoadActionProvinceMaster(int COUNTRY_ID) async {
    Map map = {"TEXT_SEARCH": "", "COUNTRY_ID": COUNTRY_ID};

    await new ArrestFutureMaster().apiRequestMasProvincegetByCon(map).then((onValue) {
      ItemProvince = onValue;
      if (ItemProvince.SUCCESS && ItemProvince.RESPONSE_DATA.length > 0) {
        setAutoCompleteProvince();
      }
      ItemProvince.RESPONSE_DATA.forEach((item) {
        if (itemsLocale != null) {
          if (item.PROVINCE_ID == itemsLocale.PROVINCE.PROVINCE_ID) {
            sProvince = item;
            editProvince.text = sProvince.PROVINCE_NAME_TH.toString();
            onLoadActionDistinctMaster(sProvince.PROVINCE_ID);
          }
        }
      });
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionDistinctMaster(int PROVINCE_ID) async {
    Map map = {"TEXT_SEARCH": "", "DISTRICT_ID": "", "PROVINCE_ID": PROVINCE_ID};
    await new ArrestFutureMaster().apiRequestMasDistrictgetByCon(map).then((onValue) {
      ItemDistrict = onValue;
      if (ItemDistrict.SUCCESS && ItemDistrict.RESPONSE_DATA.length > 0) {
        setAutoCompleteDistrict();
      }
      ItemDistrict.RESPONSE_DATA.forEach((item) {
        if (itemsLocale != null) {
          if (item.DISTRICT_ID == itemsLocale.DISTICT.DISTRICT_ID) {
            sDistrict = item;
            editDistrict.text = sDistrict.DISTRICT_NAME_TH.toString();
            onLoadActionSubDistinctMaster(sDistrict.DISTRICT_ID);
          }
        }
      });
      setState(() {});
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionSubDistinctMaster(int DISTRICT_ID) async {
    Map map = {"TEXT_SEARCH": "", "SUB_DISTRICT_ID": "", "DISTRICT_ID": DISTRICT_ID};
    await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map).then((onValue) {
      ItemSubDistrict = onValue;
      if (ItemSubDistrict.SUCCESS && ItemSubDistrict.RESPONSE_DATA.length > 0) {
        setAutoCompleteSubDistrict();
      }
      ItemSubDistrict.RESPONSE_DATA.forEach((item) {
        if (itemsLocale != null) {
          if (item.SUB_DISTRICT_ID == itemsLocale.SUB_DISTICT.SUB_DISTRICT_ID) {
            sSubDistrict = item;
            editSubDistrict.text = sSubDistrict.SUB_DISTRICT_NAME_TH;
          }
        }
      });
      if (itemsLocale != null) {
        editArrestRoad.text = itemsLocale.ROAD != null ? isClearProvice ? editArrestRoad.text == "" : itemsLocale.ROAD.toString() : "";
        editArrestLane.text = itemsLocale.LANE != null ? isClearProvice ? editArrestLane.text == "" : itemsLocale.LANE.toString() : "";
        editArrestHouseNumber.text = itemsLocale.ADDRESS_NO != null ? isClearProvice ? editArrestHouseNumber.text == "" : itemsLocale.ADDRESS_NO.toString() : "";
        // editArrestOther.text = itemsLocale.Other != null ? itemsLocale.Other.toString() : "";
      }
    });
    setState(() {});
    return true;
  }
}
