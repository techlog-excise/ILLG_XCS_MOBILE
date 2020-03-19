import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_location.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_distinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_province.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_subdistinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_1/tab_screen_arrest_1_map_custom.dart';

import 'package:flutter_google_places/flutter_google_places.dart';

class TabScreenArrest1Map extends StatefulWidget {
  ItemsListArrestLocation itemsLocale;
  TabScreenArrest1Map({
    Key key,
    @required this.itemsLocale,
  }) : super(key: key);
  @override
  _TabScreenArrest1MapState createState() => new _TabScreenArrest1MapState();
}

const kGoogleApiKey = "AIzaSyDV1zb4rCLMbE2epqclI2Nc7Llnq0EEz4U";

class _TabScreenArrest1MapState extends State<TabScreenArrest1Map> {
  TabController tabController;
  bool _value1 = false;
  bool _value2 = false;

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

  String _placeName = "", _addressno = "", _province = "", _distict = "", _sub_distinct = "", _alley = "", _gps = "", _pos = "", _country = "", _road = "";
  String placeAddress = "";

  TextEditingController controller = new TextEditingController();

  //textfield
  final FocusNode myFocusNodeArrestRoad = FocusNode();
  final FocusNode myFocusNodeArrestAlley = FocusNode();
  final FocusNode myFocusNodeArrestHouseNumber = FocusNode();
  final FocusNode myFocusNodeArrestOther = FocusNode();

  TextEditingController editArrestRoad = new TextEditingController();
  TextEditingController editArrestAlley = new TextEditingController();
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

  //dialog
  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    _value1 = true;
    initPlatformState();
    itemsLocale = widget.itemsLocale;
    if (itemsLocale != null) {
      print("not null");
      /*editArrestRoad.text = itemsLocale.ROAD;
      editArrestAlley.text = itemsLocale.ALLEY;
      editArrestHouseNumber.text = itemsLocale.ADDRESS_NO;
      List splits = itemsLocale.GPS.split(",");
      double lat = double.parse(splits[0]);
      double lon = double.parse(splits[1]);
      getPlaceAddress(lat,lon);*/
    }
    _onSelectCountry(1);
  }

  onSearchTextSubmitted(text) {
    byPlaceAddress(text);
  }

  byPlaceAddress(String text) async {
    var addresses = await Geocoder.local.findAddressesFromQuery(text);
    var place = addresses.first;
    getPlaceAddress(place.coordinates.latitude, place.coordinates.longitude);
  }

  Future<void> _goToTheLake(lat, lon) async {
    CameraPosition _kLake = CameraPosition(
      target: LatLng(lat, lon),
      bearing: 0.0,
      tilt: 30.0,
      zoom: 17.0,
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNodeArrestRoad.dispose();
    myFocusNodeArrestAlley.dispose();
    myFocusNodeArrestHouseNumber.dispose();
    myFocusNodeArrestOther.dispose();
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

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void _setMarker(placeName, lat, lon) {
    final String markerIdVal = placeName;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        //icon: BitmapDescriptor.fromAsset('assets/icons/marker.png',),
        position: LatLng(lat, lon),
        infoWindow: InfoWindow(
          title: markerIdVal, /*snippet: '*'*/
        ),
        onTap: () {
          /*ItemProvince.RESPONSE_DATA.forEach((province) {
          if (_province.trim().endsWith(
              province.PROVINCE_NAME_TH.trim())) {
            sProvince = province;
            _onSelectDataAddress(sProvince.PROVINCE_ID);
          }
        });*/
        });

    setState(() {
      markers = <MarkerId, Marker>{};
      markers[markerId] = marker;
    });
  }

  _navigateMap(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest1MapCustom(
                itemsLocale: itemsLocale,
                IsPageArrest: true,
              )),
    );
    if (result.toString() != "Back") {
      Navigator.pop(context, result);
    }
  }

  void getPlaceAddress(latitude, longitude) async {
    _initDataAddress();
    final coordinates = new Coordinates(latitude, longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var place = addresses.first;
    _placeName = place.featureName /*+ " " + place.thoroughfare!=null?place.thoroughfare.toString():""*/;
    _addressno = place.subThoroughfare != null ? place.subThoroughfare : "";
    _province = place.adminArea;
    _country = place.countryName;
    _pos = place.postalCode;
    _gps = place.coordinates.latitude.toString() + "," + coordinates.longitude.toString();

    placeAddress = place.addressLine;
    _setMarker(place.addressLine, latitude, longitude);
    _goToTheLake(place.coordinates.latitude, place.coordinates.longitude);

    /* print("featureName " + place.featureName);
    print("adminArea " + place.adminArea);
    print("subLocality " + place.subLocality.toString());
    print("locality " + place.locality.toString());
    print("subAdminArea " + place.subAdminArea.toString());
    print("coordinates " + place.coordinates.toString());
    print("thoroughfare " + place.thoroughfare.toString());
    print("subThoroughfare " + place.subThoroughfare.toString());
    print("postalCode " + place.postalCode.toString());
    print("addressLine "+place.addressLine.toString());
    print("countryCode "+place.countryCode.toString());
    print("countryName "+place.countryName.toString());*/

    if (place.subLocality != null) {
      if (place.subLocality.contains("เขต")) {
        List splits = place.subLocality.split(" ");
        _distict = splits[1];
      }
    } else {
      if (place.subAdminArea.contains("อำเภอ")) {
        List splits = place.subAdminArea.split("อำเภอ");
        print(splits.length);
        _distict = splits[1];
      }
    }

    List addressLine = place.addressLine.split(" ");
    for (int i = 0; i < addressLine.length; i++) {
      if (addressLine[i].toString().endsWith("ซอย")) {
        _alley = addressLine[i + 1];
      } else if (addressLine[i].toString().endsWith("ถนน")) {
        _road = addressLine[i + 1];
      } else if (addressLine[i].toString().endsWith("แขวง") || addressLine[i].toString().endsWith("ตำบล")) {
        _sub_distinct = addressLine[i + 1];
      }
    }

    //print(_province+","+_distict+","+_sub_distinct);

    setState(() {});
  }

  _initDataAddress() {
    _placeName = "";
    _addressno = "";
    _province = "";
    _country = "";
    _pos = "";
    _gps = "";
    placeAddress = "";
    _alley = "";
    _road = "";
    _sub_distinct = "";
    _distict = "";
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
          getPlaceAddress(location.latitude, location.longitude);
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

  Widget _buildContentGoogleMap(width, height) {
    if (_startLocation != null) {
      return Container(
          height: MediaQuery.of(context).size.height,
          child: Container(
              width: width,
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    //myLocationEnabled: true,
                    //mapType: MapType.hybrid,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_startLocation.latitude, _startLocation.longitude),
                      bearing: 0.0,
                      tilt: 30.0,
                      zoom: 17.0,
                    ),
                    markers: Set<Marker>.of(markers.values),
                    onTap: ((location) {
                      getPlaceAddress(location.latitude, location.longitude);
                      //print(location.latitude.toString()+","+location.longitude.toString());
                    }),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          /* border: Border.all(
                          color: Colors.grey.withOpacity(0.5), width: 1.0),
                      color: Colors.white*/
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                //width: itemWidth,
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: new Card(
                                    color: Colors.white,
                                    child: new ListTile(
                                      leading: new Icon(Icons.search),
                                      title:
                                          /*new TextField(
                                    controller: controller,
                                    keyboardType: TextInputType.text,
                                    textCapitalization: TextCapitalization.words,
                                    decoration: new InputDecoration(
                                        hintText: 'ค้นหาสถานที่', border: InputBorder.none),
                                    onSubmitted: onSearchTextSubmitted,
                                    onTap: (){
                                      _navigateSearchPlace(context);
                                    },
                                  ),*/
                                          new PlacesAutocompleteField(
                                        apiKey: kGoogleApiKey,
                                        controller: controller,
                                        onChanged: onSearchTextSubmitted,
                                        inputDecoration: new InputDecoration(hintText: 'ค้นหาสถานที่', border: InputBorder.none, hintStyle: textInputStyle, labelStyle: textLabelStyle),
                                      ),
                                      /*trailing: new IconButton(
                                    icon: new Icon(Icons.cancel),
                                    onPressed: () {
                                      controller.clear();
                                    },
                                  ),*/
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )));
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    //Size Screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //TextField Style

    final _buildChoice = new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  if (!_value1) {
                    _value1 = !_value1;
                    _value2 = !_value2;
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _value1 ? Colors.blue : Colors.white,
                  border: Border.all(color: Colors.black12),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: _value1
                        ? Icon(
                            Icons.check,
                            size: 30.0,
                            color: Colors.white,
                          )
                        : Container(
                            height: 30.0,
                            width: 30.0,
                            color: Colors.transparent,
                          )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Google Map',
                style: _value1 ? textStyleSelect : textStyleUnselect,
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  if (!_value2) {
                    _value2 = !_value2;
                    _value1 = !_value1;
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _value2 ? Colors.blue : Colors.white,
                  border: Border.all(color: Colors.black12),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: _value2
                        ? Icon(
                            Icons.check,
                            size: 30.0,
                            color: Colors.white,
                          )
                        : Container(
                            height: 30.0,
                            width: 30.0,
                            color: Colors.transparent,
                          )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'ระบุเอง',
                style: _value2 ? textStyleSelect : textStyleUnselect,
              ),
            )
          ],
        )
      ],
    );
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
        color: Colors.white,
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
                          /*Container(
                            padding: paddingLabel,
                            child: Text(
                              "จังหวัด", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestProvince,
                              controller: editArrestProvince,
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
                              "อำเภอ/เขต", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestDistinct,
                              controller: editArrestDistinct,
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
                            child: Text("ตำบล/แขวง", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestSubDistinct,
                              controller: editArrestSubDistinct,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine,*/
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "จังหวัด",
                              style: textLabelStyle,
                            ),
                          ),
                          Container(
                            width: size.width,
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: ItemProvince != null
                                  ? DropdownButton<ItemsListProvince>(
                                      isExpanded: true, //
                                      value: sProvince,
                                      onChanged: (ItemsListProvince newValue) {
                                        setState(() {
                                          sProvince = newValue;
                                          ItemProvince.RESPONSE_DATA.forEach((f) {
                                            if (f.PROVINCE_NAME_TH.endsWith(sProvince.PROVINCE_NAME_TH)) {
                                              sDistrict = null;
                                              sSubDistrict = null;
                                              _onSelectProvince(f.PROVINCE_ID);
                                            }
                                          });
                                        });
                                      },
                                      items: ItemProvince.RESPONSE_DATA.map<DropdownMenuItem<ItemsListProvince>>((ItemsListProvince value) {
                                        return DropdownMenuItem<ItemsListProvince>(
                                          value: value,
                                          child: Text(
                                            value.PROVINCE_NAME_TH,
                                            style: textInputStyle,
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  : Container(),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "อำเภอ/เขต",
                              style: textLabelStyle,
                            ),
                          ),
                          Container(
                            width: size.width,
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: ItemDistrict != null
                                  ? DropdownButton<ItemsListDistict>(
                                      isExpanded: true, //
                                      value: sDistrict,
                                      onChanged: (ItemsListDistict newValue) {
                                        setState(() {
                                          sDistrict = newValue;
                                          ItemDistrict.RESPONSE_DATA.forEach((f) {
                                            if (f.DISTRICT_NAME_TH.endsWith(sDistrict.DISTRICT_NAME_TH)) {
                                              sSubDistrict = null;
                                              _onSelectDistrict(f.DISTRICT_ID);
                                            }
                                          });
                                        });
                                      },
                                      items: ItemDistrict.RESPONSE_DATA.map<DropdownMenuItem<ItemsListDistict>>((ItemsListDistict value) {
                                        return DropdownMenuItem<ItemsListDistict>(
                                          value: value,
                                          child: Text(
                                            value.DISTRICT_NAME_TH,
                                            style: textInputStyle,
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  : Container(),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ตำบล/แขวง",
                              style: textLabelStyle,
                            ),
                          ),
                          Container(
                            width: size.width,
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: ItemSubDistrict != null
                                  ? DropdownButton<ItemsListSubDistict>(
                                      isExpanded: true, //
                                      value: sSubDistrict,
                                      onChanged: (ItemsListSubDistict newValue) {
                                        setState(() {
                                          sSubDistrict = newValue;
                                        });
                                      },
                                      items: ItemSubDistrict.RESPONSE_DATA.map<DropdownMenuItem<ItemsListSubDistict>>((ItemsListSubDistict value) {
                                        return DropdownMenuItem<ItemsListSubDistict>(
                                          value: value,
                                          child: Text(
                                            value.SUB_DISTRICT_NAME_TH,
                                            style: textInputStyle,
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  : Container(),
                            ),
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
                              focusNode: myFocusNodeArrestAlley,
                              controller: editArrestAlley,
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
                              "บ้านเลขที่",
                              style: textLabelStyle,
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestHouseNumber,
                              controller: editArrestHouseNumber,
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
                            child: Text(
                              "ระบุเพิ่มเติม",
                              style: textLabelStyle,
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeArrestOther,
                              controller: editArrestOther,
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return Scaffold(
        backgroundColor: Colors.white,
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
                  //_showIsPlaceAlertDialog();
                  if (ItemProvince != null) {
                    for (int i = 0; i < ItemProvince.RESPONSE_DATA.length; i++) {
                      if (_province.trim().endsWith(ItemProvince.RESPONSE_DATA[i].PROVINCE_NAME_TH.trim())) {
                        sProvince = ItemProvince.RESPONSE_DATA[i];
                        _onSelectDataAddress(sProvince.PROVINCE_ID);
                        break;
                      }
                    }
                  } else {
                    print("error");
                  }
                },
                child: Text('ตกลง', style: textStyleAppbar)),
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
            _value1 ? _buildContentGoogleMap(width, height) : _buildContentCustom,
          ],
        ),
        bottomNavigationBar: Container(
            height: (size.height * 20) / 100,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: width,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey[300], width: 1.0),
                        )),
                    child: Text(
                      _placeName,
                      style: textStylePlaceName,
                    ),
                  ),
                  Container(
                    width: width,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey[300], width: 1.0),
                        )),
                    child: Text(
                      placeAddress,
                      style: textStylePlaceAddress,
                    ),
                  ),
                ],
              ),
            )));
  }

  void _onSelectCountry(int COUNTRY_ID) async {
    await onLoadActionProvinceMaster(COUNTRY_ID);
  }

  void _onSelectProvince(int PROVINCE_ID) async {
    await _onSelectDataAddress(PROVINCE_ID);
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
    Navigator.pop(context);

    print("_addressno : " + _addressno.toString());
    print("_road : " + _road.toString());
    print("_alley : " + _alley.isEmpty.toString());
    setState(() {
      itemsLocale = new ItemsListArrestLocation(sProvince, sDistrict, sSubDistrict, _road, _alley, _addressno, _gps, placeAddress, false, "");
    });
    _navigateMap(context);
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
            //print("District : "+sDistrict.DISTRICT_ID.toString());
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
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionDistinctMaster(int PROVINCE_ID) async {
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
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionSubDistinctMaster(int DISTRICT_ID) async {
    Map map = {"TEXT_SEARCH": "", "SUB_DISTRICT_ID": "", "DISTRICT_ID": DISTRICT_ID};
    await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map).then((onValue) {
      ItemSubDistrict = onValue;
      if (ItemSubDistrict != null) {
        ItemSubDistrict.RESPONSE_DATA.forEach((subdistrict) {
          if (_sub_distinct.trim().endsWith(subdistrict.SUB_DISTRICT_NAME_TH.trim())) {
            setState(() {
              sSubDistrict = subdistrict;
              //print("sSubDistrict : "+sSubDistrict.SUB_DISTRICT_ID.toString());
            });
          }
        });
      }
    });
    setState(() {});
    return true;
  }
}
