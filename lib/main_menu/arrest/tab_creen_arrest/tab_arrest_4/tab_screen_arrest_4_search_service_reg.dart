import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_create.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_suspect.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_suspect2.dart';
import 'package:prototype_app_pang/main_menu/future/item_service_uat100.dart';
import 'package:prototype_app_pang/main_menu/future/item_service_uat200.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/zan/future/person_net_future.dart';
import 'package:prototype_app_pang/zan/model/person_net_main.dart';

class TabScreenArrest4SearchServiceReg extends StatefulWidget {
  List<ItemsListFactoryInfo100> ItemsDataGet;
  TabScreenArrest4SearchServiceReg({
    Key key,
    @required this.ItemsDataGet,
  }) : super(key: key);
  @override
  _TabScreenArrest4SearchState createState() => new _TabScreenArrest4SearchState();
}
class _TabScreenArrest4SearchState extends State<TabScreenArrest4SearchServiceReg> {
  List<ItemsListFactoryInfo100> _itemsInit = [];
  int _countItem = 0;
  List<ItemsListFactoryInfo100> _itemsData = [];
  List<bool> _value = [];
  bool isCheckAll=false;


  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleSub = TextStyle(fontSize: 14.0, color: Colors.grey[500],fontFamily: FontStyles().FontFamily);
  TextStyle textPreviewStyle = TextStyle(fontSize: 14.0, color: Color(0xff2e76bc),fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0,fontFamily: FontStyles().FontFamily);
  TextStyle textCheckAllStyle = TextStyle(fontSize: 16.0, color: Color(0xff2e76bc),fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      fontSize: 12.0, color: Colors.grey[400],fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);


  bool Success=false;
  ItemsListPersonNetMain itemsListPersonNetMain=null;
  @override
  void initState() {
    super.initState();
    _itemsInit=widget.ItemsDataGet;
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _itemsInit.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            setState(() {
              _itemsInit[index].IsCheck =
              !_itemsInit[index].IsCheck;
              int count = 0;
              _itemsInit.forEach((item) {
                if (item.IsCheck) {
                  count++;
                }
              });
              count == _itemsInit.length
                  ? isCheckAll = true
                  : isCheckAll = false;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
              padding: EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                //color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: index==0
                      ?Border(
                    top: BorderSide(color: Colors.grey[300], width: 1.0),
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
                      :Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
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
                            (_itemsInit[index].Name != null
                                ? _itemsInit[index].Name.toString()
                                :""),
                            style: textInputStyleTitle,),
                        ),
                      ),
                      Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _itemsInit[index].IsCheck =
                                !_itemsInit[index].IsCheck;
                                int count = 0;
                                _itemsInit.forEach((item) {
                                  if (item.IsCheck) {
                                    count++;
                                  }
                                });
                                count == _itemsInit.length
                                    ? isCheckAll = true
                                    : isCheckAll = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: _itemsInit[index].IsCheck
                                    ? Color(0xff3b69f3)
                                    : Colors.white,
                                border: _itemsInit[index].IsCheck
                                    ? Border.all(
                                    color: Color(0xff3b69f3), width: 2)
                                    : Border.all(
                                    color: Colors.grey[400], width: 2),
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
                                  )
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      "เลขทะเบียนสรรพสามิต : "+_itemsInit[index].NewregId,
                      style: textInputStyleSub,),
                  ),
                  /*_itemsInit[index].IsCheck ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Center(
                        child: InkWell(
                          onTap: () {
                            Map map = {
                              "SystemId":"WSS",
                              "UserName":"wss001",
                              "Password":"123456",
                              "IpAddress":"10.1.1.1",
                              "requestData":{
                                "RegId":_itemsInit[index].NewregId
                              }
                            };
                            _navigatePreview(context, map);
                          },
                          child: Container(
                              child: Text("ดูประวัติผู้ต้องหา...",
                                style: textPreviewStyle,)
                          ),
                        )
                    ),
                  ],
                ) : Container(),*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ItemsListFactoryInfo itemsListFactoryInfo;
  List<ItemsListArrestLawbreaker> itemSearch=[];
  //on show dialog
  Future<bool> onLoadActionSerReg(List<ItemsListFactoryInfo100> itemsFactory) async {
    for(int i=0;i<itemsFactory.length;i++) {
      if (itemsFactory[i].IsCheck) {
        Map map = {
          "SystemId": "WSS",
          "UserName": "wss001",
          "Password": "123456",
          "IpAddress": "10.1.1.1",
          "requestData": {
            "RegId": itemsFactory[i].NewregId
          }
        };
        print(map);
        await new TransectionFuture().apiRequestEDRestServicesUAT200(map).then((
            onValue) {
          itemsListFactoryInfo = onValue.ResponseData;
        });

        if (itemsListFactoryInfo != null) {
          List<Map> map_adress = [];
          itemsListFactoryInfo.Address.forEach((item) {
            map_adress.add({
              "PERSON_ADDRESS_ID": "",
              "PERSON_ID": "",
              "SUB_DISTRICT_ID": item.SubDistrictCode,
              "GPS": "",
              "ADDRESS_NO": "",
              "VILLAGE_NO": item.MooIdentifier,
              "BUILDING_NAME": item.BuildingName,
              "ROOM_NO": item.RoomIdentifier,
              "FLOOR": item.FloorIdentifier,
              "VILLAGE_NAME": item.VillageName,
              "ALLEY": "",
              "LANE": item.SoiName,
              "ROAD": item.StreetName,
              "ADDRESS_TYPE": 4,
              "ADDRESS_DESC": "",
              "ADDRESS_STATUS": 0,
              "IS_ACTIVE": 1
            });
          });

          map = {
            "PERSON_ID": "",
            "COUNTRY_ID": 1,
            "NATIONALITY_ID": 1,
            "RACE_ID": 1,
            "RELIGION_ID": 1,
            "TITLE_ID": "",
            "PERSON_TYPE": 0,
            "ENTITY_TYPE": 1,
            "TITLE_NAME_TH": " ",
            "TITLE_NAME_EN": "",
            "TITLE_SHORT_NAME_TH": " ",
            "TITLE_SHORT_NAME_EN": "",
            "FIRST_NAME": itemsListFactoryInfo.FirstName,
            "MIDDLE_NAME": "",
            "LAST_NAME": " ",
            "OTHER_NAME": "",
            "COMPANY_NAME": itemsListFactoryInfo.Name,
            "COMPANY_REGISTRATION_NO": itemsListFactoryInfo.Pin,
            "COMPANY_FOUND_DATE": "",
            "COMPANY_LICENSE_NO": "",
            "COMPANY_LICENSE_DATE_FROM": "",
            "COMPANY_LICENSE_DATE_TO": "",
            "EXCISE_REGISTRATION_NO": "",
            "GENDER_TYPE": 0,
            "ID_CARD": "",
            "BIRTH_DATE": "",
            "BLOOD_TYPE": "",
            "PASSPORT_NO": "",
            "VISA_TYPE": "",
            "PASSPORT_DATE_IN": "",
            "PASSPORT_DATE_OUT": "",
            "MARITAL_STATUS": 0,
            "CAREER": "",
            "PERSON_DESC": "",
            "EMAIL": "",
            "TEL_NO": "",
            "MISTREAT_NO": 1,
            "IS_ILLEGAL": 1,
            "IS_ACTIVE": 1,
            "MAS_PERSON_ADDRESS": map_adress
          };

          int PERSON_ID;
          await new ArrestFutureMaster().apiRequestMasPersoninsAll(map).then((
              onValue) {
            PERSON_ID = onValue.RESPONSE_DATA;
          });

          if (PERSON_ID != null) {
            Map map_person = {
              "TEXT_SEARCH": "",
              "PERSON_ID": PERSON_ID
            };
            print(map_person.toString());
            await new ArrestFutureMaster().apiRequestMasPersongetByCon(
                map_person).then((onValue) {
              onValue.RESPONSE_DATA.forEach((f) {
                f.IsCreate = true;
              });
              itemSearch.add(onValue.RESPONSE_DATA.first);
              //Navigator.pop(context);
            });
          }
        }
      }
    }

    setState(() {});
    return true;
  }

  _navigate_search_reg(BuildContext mContext,List<ItemsListFactoryInfo100> itemsFactory)async{
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionSerReg(itemsFactory);
    Navigator.pop(context);

    if(itemSearch.length>0){
      Navigator.pop(mContext, itemSearch);
    }
  }



  Widget _buildBottom(BuildContext mContext) {
    var size = MediaQuery
        .of(mContext)
        .size;
    bool isCheck = false;
    _countItem = 0;
    _itemsInit.forEach((item) {
      if (item.IsCheck)
        setState(() {
          isCheck = item.IsCheck;
          _countItem++;
        });
    });
    return isCheck ? Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {

          _itemsInit.forEach((item) {
            if (item.IsCheck)
              _itemsData.add(item);
          });
          _navigate_search_reg(mContext,_itemsData);

        },
        child: Center(
          child: Text('เลือก (${_countItem})', style: textStyleButton,),
        ),
      ),
    ) : null;
  }

  //on show dialog
  Future<bool> onLoadAction(BuildContext context,Map map) async {
    await new PersonNetFuture().apiRequestPersonDetailgetByPersonId(map).then((onValue) {
      itemsListPersonNetMain = onValue;
    });


    setState(() {});
    return true;
  }
  _navigatePreview(BuildContext context,Map map) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadAction(context,map);
    Navigator.pop(context);

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest4Suspect2(itemsListPersonNetMain: itemsListPersonNetMain,)),
    );
    print(result);
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
              child: new Text("ค้นหาผู้ต้องหา",
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
                        )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 22.0,right: 22.0,bottom: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: Text("เลือกผู้ต้องหาทั้งหมด",
                            style: textCheckAllStyle,),
                          padding: EdgeInsets.all(8.0),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isCheckAll =
                              !isCheckAll;
                              if(isCheckAll){
                                _itemsInit.forEach((item) {
                                  item.IsCheck=true;
                                });
                              }else{
                                _itemsInit.forEach((item) {
                                  item.IsCheck=false;
                                });
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: isCheckAll
                                  ? Color(0xff3b69f3)
                                  : Colors.grey[200],
                              border: isCheckAll
                                  ?Border.all(color: Color(0xff3b69f3),width: 2)
                                  :Border.all(color: Colors.grey[400],width: 2),
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
                                )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: _buildSearchResults(),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottom(context),
      ),
    );
  }
}