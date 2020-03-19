import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_create.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_suspect2.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/server/server.dart';
import 'package:prototype_app_pang/zan/future/person_net_future.dart';
import 'package:prototype_app_pang/zan/model/person_net_main.dart';

class TabScreenArrest4SearchFace extends StatefulWidget {
  ItemsMasterTitleResponse itemsTitle;
  bool IsNotice;
  Future<File> ImageFile;
  List ItemsPerson;
  TabScreenArrest4SearchFace({
    Key key,
    @required this.ImageFile,
    @required this.IsNotice,
    @required this.ItemsPerson,
    @required this.itemsTitle,
  }) : super(key: key);
  @override
  _TabScreenArrest4SearchFaceState createState() => new _TabScreenArrest4SearchFaceState();
}
class _TabScreenArrest4SearchFaceState extends State<TabScreenArrest4SearchFace> {

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
  ItemsListPersonNetMain itemsListPersonNetMain=null;

  @override
  void initState() {
    super.initState();
    _itemsInit = widget.ItemsPerson;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildImage(BuildContext context) {
    return FutureBuilder<File>(
        future: widget.ImageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white30),
              ),
              margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
              padding: const EdgeInsets.all(3.0),
              child: ClipOval(
                child: Image.file(snapshot.data,fit: BoxFit.cover),
              ),
            );
          } else if (snapshot.error != null) {
            return const Text(
              'Error picking image.',
              textAlign: TextAlign.center,
            );
          } else {
            return const Text(
              'You have not yet picked an image.',
              textAlign: TextAlign.center,
            );
          }
        });
  }
  Widget _buildContent() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;
    TextStyle textInputStyleTitle = TextStyle(
    fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
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
                            child: _itemsInit[index].REF_CODE!=null
                                ?new Image.network(
                              new Server().IPAddressDocument+"/getImage.html/"+_itemsInit[index].REF_CODE.toString()
                              ,fit: BoxFit.cover,)
                                :Image(
                                fit: BoxFit.cover,
                                image: new AssetImage(
                                    'assets/images/avatar.png')),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  (_itemsInit[index].TITLE_SHORT_NAME_TH != null
                                      ? _itemsInit[index].TITLE_SHORT_NAME_TH.toString()
                                      : _itemsInit[index].TITLE_NAME_TH.toString()) + '' +
                                      _itemsInit[index].FIRST_NAME.toString() + " " +
                                      _itemsInit[index].LAST_NAME.toString(),
                                  style: textInputStyleTitle,),
                              ),
                              _itemsInit[index].MISTREAT_NO != 0
                                  ? Padding(
                                padding: paddingInputBox,
                                child: Text(
                                  "จำนวนครั้งการกระทำผิด " +
                                      _itemsInit[index].MISTREAT_NO
                                          .toString() +
                                      " ครั้ง",
                                  style: textInputStyleSub,),
                              )
                                  : Padding(
                                padding: paddingInputBox,
                                child: Text(
                                  "ไม่พบการกระทำผิด",
                                  style: textInputStyleSub,),
                              ),
                            ],
                          )
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
                  _itemsInit[index].IsCheck ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Center(
                          child: InkWell(
                            onTap: () {
                              Map map = {
                                "TEXT_SEARCH": "",
                                "PERSON_ID": _itemsInit[index].PERSON_ID
                              };
                              _navigatePreview(context, map);
                            },
                            child: Container(
                                child: Text(widget.IsNotice?"ดูประวัติผู้ต้องสงสัย...":"ดูประวัติผู้ต้องหา...",
                                  style: textPreviewStyle,)
                            ),
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
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionCountryMaster();
    Navigator.pop(context);

    if(itemsCountry!=null){
      final result = await Navigator.push(
        mContext,
        MaterialPageRoute(builder: (context) => TabScreenArrest4Create(
          ItemTitle: widget.itemsTitle,
          ItemCountry: itemsCountry,
          IsUpdate: false,
          ItemsPerson: null,
          Title: widget.IsNotice?"สร้างผู้ต้องสงสัย":"สร้างผู้ต้องหา",
        )),
      );
      if(result.toString()!="back"){
        _itemsData=result;
        Navigator.pop(mContext,_itemsData);
      }
    }
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
          Navigator.pop(mContext, _itemsData);
        },
        child: Center(
          child: Text('เลือก (${_countItem})', style: textStyleButton,),
        ),
      ),
    ) : null;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
    TextStyle textStylePageName = TextStyle(
        fontSize: 12.0, color: Colors.grey[400],fontFamily: FontStyles().FontFamily);
    TextStyle textStyleEmpty = TextStyle(
        fontSize: 20.0,
        color: Colors.grey[500],
        fontFamily: FontStyles().FontFamily);
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
              child: new Text(widget.IsNotice?"วิเคราะห์ข้อมูลผู้ต้องสงสัย":"วิเคราะห์ข้อมูลผู้ต้องหา",
                style: styleTextAppbar,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context,"back");
                }),
            actions: <Widget>[
              new FlatButton(
                onPressed: (){
                  _navigateCreate(context);
                },
                child: Text("สร้าง",
                  style: styleTextAppbar,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            BackgroundContent(),
            SingleChildScrollView(
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
                          child: new Text('ILG60_B_01_00_06_00',
                            style: textStylePageName,),
                        ),
                      ],
                    ),
                    ],
                  )*/
                  ),
                  Center(
                    child: _buildImage(context),
                  ),
                  _itemsInit.length>0
                      ?Container(
                    padding: EdgeInsets.only(left: 22.0,right: 22.0,bottom: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: Text(widget.IsNotice?"เลือกผู้ต้องสงสัย":"เลือกผู้ต้องหาทั้งหมด",
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
                  )
                      :Container(),
                  _itemsInit.length>0
                      ?Container(
                    padding: EdgeInsets.only(bottom: 22.0),
                    child: _buildContent(),
                  ) :Container(
                      child: Center(
                        child: Text(widget.IsNotice?"ไม่พบข้อมูลผู้ต้องสงสัย":'ไม่พบข้อมูลผู้ต้องหา',style: textStyleEmpty,),
                      )
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: _buildBottom(context),
      ),
    );
  }
}