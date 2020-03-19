import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/server/server.dart';
import 'package:prototype_app_pang/zan/analysis_screen.dart';
import 'package:prototype_app_pang/zan/future/person_net_future.dart';
import 'package:prototype_app_pang/zan/model/person_net_analysis_main.dart';
import 'package:prototype_app_pang/zan/model/person_net_arrest_lawbreaker_relationship.dart';
import 'package:prototype_app_pang/zan/model/person_net_arrest_person.dart';
import 'package:prototype_app_pang/zan/model/person_net_lawbreaker_detail.dart';
import 'package:prototype_app_pang/zan/model/person_net_main.dart';

class NetworkMainScreenFragmentSearchResult extends StatefulWidget {
  List ItemsDataGet;
  ItemsMasterTitleResponse itemsTitle;
  NetworkMainScreenFragmentSearchResult({
    Key key,
    @required this.ItemsDataGet,
    @required this.itemsTitle,
  }) : super(key: key);
  @override
  _NetworkMainScreenFragmentSearchResultState createState() => new _NetworkMainScreenFragmentSearchResultState();
}
class _NetworkMainScreenFragmentSearchResultState extends State<NetworkMainScreenFragmentSearchResult> {
  List _itemsInit = [];
  int _countItem = 0;
  List _itemsData = [];
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
  ItemsListPersonNetAnalysisMain itemsListPersonNetMain;
  ItemsListPersonNetMain itemsListPersonNetHead;

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
          onTap: () {
            Map map = {
              "PERSON_ID": _itemsInit[index].PERSON_ID //21
            };
            _navigatePreview(context, map, _itemsInit[index].PERSON_ID,
                _itemsInit[index].REF_CODE);
          },

          child: Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
              padding: EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    //top: BorderSide(color: Colors.grey[300], width: 1.0),
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 18.0),
                        child: Container(
                          width: 70.0,
                          height: 70.0,

                          decoration: BoxDecoration(

                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white30),
                          ),
                          //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                          padding: const EdgeInsets.all(3.0),
                          child: ClipOval(
                            child: _itemsInit[index].REF_CODE != null
                                ? /*new Image.network(
                                new Server().IPAddress+"/getImage.html/"+_itemsInit[index].REF_CODE.toString()
                              ,fit: BoxFit.cover,)*/
                            CachedNetworkImage(
                              imageUrl: new Server().IPAddressDocument+"/getImage.html/"+_itemsInit[index].REF_CODE.toString(),
                              placeholder: (context,
                                  url) => new CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                            )
                                : Image(
                                fit: BoxFit.cover,
                                image: new AssetImage(
                                    'assets/images/avatar.png')),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: paddingLabel,
                          child: Text(
                            _itemsInit[index].TITLE_SHORT_NAME_TH.toString() +
                                ' ' +
                                _itemsInit[index].FIRST_NAME.toString() + " " +
                                _itemsInit[index].LAST_NAME.toString(),
                            style: textInputStyleTitle,),
                        ),
                      ),
                      Center(
                        child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.navigate_next, size: 28,
                              color: Colors.grey[400],)

                        ),
                      ),
                    ],
                  ),

                  _itemsInit[index].IsCheck ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Center(
                          child: InkWell(
                            onTap: () {
                              Map map = {
                                "PERSON_ID": _itemsInit[index].PERSON_ID
                              };
                              _navigatePreview(
                                  context, map, _itemsInit[index].PERSON_ID,
                                  _itemsInit[index].REF_CODE);
                            },

                          )
                      ),
                    ],
                  ) : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottom() {
    var size = MediaQuery
        .of(context)
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
          Navigator.pop(context, _itemsData);
        },
      
      ),
    ) : null;
  }

  ItemsMasterCountryResponse itemsCountry;
  //on show dialog
  Future<bool> onLoadActionCountryMaster() async {
    Map map_title = {
      "TEXT_SEARCH": ""
    };
    Map map_country = {
      "TEXT_SEARCH": ""
    };
    await new ArrestFutureMaster()
        .apiRequestMasCountrygetByCon(map_country)
        .then((onValue) {
      itemsCountry = onValue;
    });
  }
  _navigateCreate(BuildContext mContext) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionCountryMaster();
    Navigator.pop(context);
  }

  //on show dialog
  Future<bool> onLoadAction(BuildContext context,Map map,int person_id,int REF_CODE) async {
    itemsListPersonNetMain=null;
    itemsListPersonNetHead=null;
    await new PersonNetFuture().apiRequestPersonDetailgetByPersonId(map).then((onValue) {
      itemsListPersonNetHead = onValue;
    });
    itemsListPersonNetHead.PERSON_INFO.REF_CODE = REF_CODE;





    //dupicate lawsuit
    List<int> _ids_law = [];
    itemsListPersonNetHead.ARREST_LAWBREAKER_DETAILS.forEach((item){
      _ids_law.add(item.LAWSUIT_ID);
    });
    var distinctIds = _ids_law.toSet().toList();
    List<ItemsListPersonNetLawbreakerDetail> itemLawDetail=[];
    distinctIds.forEach((item){
      for(int i=0;i<itemsListPersonNetHead.ARREST_LAWBREAKER_DETAILS.length;i++){
        if(item == itemsListPersonNetHead.ARREST_LAWBREAKER_DETAILS[i].LAWSUIT_ID){
          itemLawDetail.add(itemsListPersonNetHead.ARREST_LAWBREAKER_DETAILS[i]);
          break;
        }
      }
    });
    itemsListPersonNetHead.ARREST_LAWBREAKER_DETAILS = itemLawDetail;





    //get ARREST_CODE
    List<ItemsListPersonNetArrestPerson> _items=[];
    List<int> _ids = [];
    await new PersonNetFuture().apiRequestArrestgetByPersonId(map).then((onValue) {
      List itms = onValue;
      itms.forEach((item){
        _ids.add(item.ARREST_ID);
      });
      var distinctIds = _ids.toSet().toList();
      distinctIds.forEach((item){
        for(int i=0;i<itms.length;i++){
          if(item==itms[i].ARREST_ID){
            _items.add(itms[i]);
            break;
          }
        }
      });
    });

    print("_items : "+_items.length.toString());

    //get Lawbreaker RelationShip
    List<ItemsListPersonNetLawbreakerRelationShip> _items_data=[];
    for(int i=0;i<_items.length;i++){
      List<int> _ids = [];
      Map map = {
        "ARREST_CODE": _items[i].ARREST_CODE
      };
      await new PersonNetFuture().apiRequestLawbreakerRelationshipgetByPersonId(map).then((onValue) {
        onValue.forEach((item){
          _ids.add(item.LAWBREAKER_ID);
        });
        var distinctIds = _ids.toSet().toList();
        distinctIds.forEach((item){
          for(int i=0;i<onValue.length;i++){
            if(item==onValue[i].LAWBREAKER_ID){
              _items_data.add(onValue[i]);
              break;
            }
          }
        });
      });
    }


    //Map RefCode
    for(int i=0;i<_items_data.length;i++){
      Map map = {
        "DOCUMENT_TYPE": 3,
        "REFERENCE_CODE": _items_data[i].PERSON_ID,
      };
      await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
        print(onValue.length);
        if(onValue.length>0){
          _items_data[i].REF_CODE = onValue.first.DOCUMENT_ID;
        }
      });
    }

    //แยก person กับ lawbreaker
    List<ItemsListPersonNetLawbreakerRelationShip> _items1=[];
    List<ItemsListPersonNetLawbreakerRelationShip> _items2=[];
    _items_data.forEach((item){
      if(person_id == item.PERSON_ID) {
        _items1.add(item);
      }else{
        _items2.add(item);
      }
    });

    //แยกตามใบจับกุม Arrest Code



    print("person : "+_items1.toString());

    if(_items1.length>0) {
      _items1.forEach((item) {
        itemsListPersonNetMain = new ItemsListPersonNetAnalysisMain(
          LAWBREAKER_ID: item.LAWBREAKER_ID,
          PERSON_ID: item.PERSON_ID,
          ARREST_LAWBREAKER_NAME: item.ARREST_LAWBREAKER_NAME,
          ARREST_CODE: item.ARREST_CODE,
          DOCUMENT_ID: item.DOCUMENT_ID,
          REF_CODE: REF_CODE,
          LawbreakerRelationShip: _items2,
        );
      });
    }else{
      //ไม่พบผู้ต้องหาในใบงานจับกุมเดียวกัน
      _items.forEach((item){
        itemsListPersonNetMain = new ItemsListPersonNetAnalysisMain(
          LAWBREAKER_ID: item.LAWBREAKER_ID,
          PERSON_ID: item.PERSON_ID,
          ARREST_LAWBREAKER_NAME: item.ARREST_LAWBREAKER_NAME,
          ARREST_CODE: item.ARREST_CODE,
          DOCUMENT_ID: item.DOCUMENT_ID,
          REF_CODE: REF_CODE,
          LawbreakerRelationShip: _items2,
        );
      });
    }


    setState(() {});
    return true;
  }
  _navigatePreview(BuildContext context,Map map,int PERSON_ID,int REF_CODE) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadAction(context,map,PERSON_ID,REF_CODE);
    Navigator.pop(context);

    if(itemsListPersonNetHead!=null){
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AnalysisMainScreenFragment(
          itemsListPersonNetMain: itemsListPersonNetMain,
          itemsPersonNetHead: itemsListPersonNetHead,
          PERSON_ID: PERSON_ID,
        )),
      );
      _itemsData=result;

      if(result.toString()!="Back") {
        Navigator.pop(context, _itemsData);
      }
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
              child: new Text("วิเคราะห์ข้อมูลผู้ต้องหา",
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
                        color: Colors.grey[200],
                        border: Border(
                          top: BorderSide(color: Colors.grey[300], width: 1.0),
                        )
                    ),
                    /*child: Column(
                    children: <Widget>[Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: new Text('ILG60_B_01_00_13_00',
                            style: textStylePageName,),
                        ),
                      ],
                    ),
                    ],
                  )*/
                  ),


                  Expanded(
                    child: _buildSearchResults(),
                  ),
                ],
              ),
            ),
          ],
        )
    
      ),
    );
  }
}