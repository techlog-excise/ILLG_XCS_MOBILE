import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_8.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_suspect2.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_form_list.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/server/server.dart';

import 'model/person_net_analysis_lawbreaker.dart';
import 'model/person_net_analysis_main.dart';
import 'model/person_net_arrest_lawbreaker_relationship.dart';
import 'model/person_net_main.dart';

class AnalysisMainScreenFragment extends StatefulWidget {
  final ItemsListPersonNetMain itemsPersonNetHead;
  final ItemsListPersonNetAnalysisMain itemsListPersonNetMain;
  final int PERSON_ID;
  AnalysisMainScreenFragment({
    Key key,
    @required this.itemsPersonNetHead,
    @required this.itemsListPersonNetMain,
    @required this.PERSON_ID,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
const double _kPickerSheetHeight = 216.0;
class _FragmentState extends State<AnalysisMainScreenFragment>  with TickerProviderStateMixin {


  TextStyle textAppbarStyle = TextStyle(
      fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputSubStyle = TextStyle(
      fontSize: 14.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputNotPerson = TextStyle(
      fontSize: 16.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);


  ItemsListPersonNetMain itemsListPersonNetHead;
  ItemsListPersonNetAnalysisMain itemsListPersonNetMain;

  @override
  void initState() {
    super.initState();
    itemsListPersonNetMain = widget.itemsListPersonNetMain;
    itemsListPersonNetHead = widget.itemsPersonNetHead;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle tabStyle = TextStyle(fontSize: 16.0,
        color: Colors.black54,
        fontFamily: FontStyles().FontFamily);
    TextStyle appBarStyle = TextStyle(fontSize: 18.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);
    TextStyle appBarStylePay = TextStyle(fontSize: 16.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);

    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;


    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        appBar: AppBar(
          primary: true,
          centerTitle: true,
          title: Text("วิเคราะห์ข้อมุลผู้ต้องหา", style: appBarStyle,),
          leading: FlatButton(
            onPressed: () {
              Navigator.pop(context,"Back");
            },
            padding: EdgeInsets.all(10.0),
            child: new Icon(Icons.arrow_back_ios, color: Colors.white,),
          ),
          automaticallyImplyLeading: false,
        ),
        body: _buildContent_tab_1(),
      ),
    );
  }

  _navigatePreviewIndicmentDetail(BuildContext context, Map map) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          TabScreenArrest4Suspect2(
            itemsListPersonNetMain: itemsListPersonNetHead,)),
    );
  }

  Widget _buildBlock1() {
    return Container(
        padding: EdgeInsets.all(22.0),
        child: GestureDetector(
          child: Column(
            children: <Widget>[
              Container(
                child: Container(
                  width: 120.0,
                  height: 120.0,

                  decoration: BoxDecoration(

                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white30),
                  ),
                  //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                  padding: const EdgeInsets.all(3.0),
                  child: ClipOval(
                    child: itemsListPersonNetHead.PERSON_INFO.REF_CODE != null
                        ? CachedNetworkImage(
                      imageUrl: new Server().IPAddressDocument + "/getImage.html/" +
                          itemsListPersonNetHead.PERSON_INFO.REF_CODE
                              .toString(),
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
              Container(
                padding: paddingInputBox,
                child: Text(
                  itemsListPersonNetHead.PERSON_INFO.TITLE_NAME_TH.toString() +
                      itemsListPersonNetHead.PERSON_INFO.FIRST_NAME.toString() +
                      " " +
                      itemsListPersonNetHead.PERSON_INFO.LAST_NAME.toString(),
                  style: textInputStyle,),
              )
            ],
          ),
          onTap: () {
            Map map = {
              "TEXT_SEARCH": "",
              "PERSON_ID": widget.PERSON_ID
            };
            _navigatePreviewIndicmentDetail(context, map);
          },
        )
    );
  }

  Widget _buildBlock2() {

    List<String> _ids = [];
    List<ItemsListPersonNetAnalysisLawbreaker> _items = [];

    if(itemsListPersonNetMain!=null) {
      itemsListPersonNetMain.LawbreakerRelationShip.forEach((item) {
        _ids.add(item.ARREST_CODE);
      });
    }
    var arrest_codes = _ids.toSet().toList();

    arrest_codes.forEach((item){
      List<ItemsListPersonNetLawbreakerRelationShip> item_law=[];
      for(int i=0;i<itemsListPersonNetMain.LawbreakerRelationShip.length;i++){
        if(item.endsWith(itemsListPersonNetMain.LawbreakerRelationShip[i].ARREST_CODE)){
          item_law.add(itemsListPersonNetMain.LawbreakerRelationShip[i]);
        }
      }
      _items.add(new ItemsListPersonNetAnalysisLawbreaker(
        ARREST_CODE: item,
        LawbreakerRelationShip: item_law,
      ));
    });


    return Container(
        padding: EdgeInsets.only(left: 22.0, right: 22.0, bottom: 22.0),
        child: Column(
          children: <Widget>[
            Container(
              //padding: EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text('ใบงานจับกุมเดียวกัน', style: textLabelStyle,),
                  ),
                ],
              ),
            ),
            Container(
              padding: paddingInputBox,
              child: _items.length>0
                  ?ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: _items.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(_items[index].ARREST_CODE,
                              style: textLabelStyle,),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 12.0),
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.all(0.0),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,),
                              itemBuilder: (BuildContext context, int j) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        width: 80.0,
                                        height: 80.0,

                                        decoration: BoxDecoration(

                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white30),
                                        ),
                                        //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipOval(
                                          child: _items[index].LawbreakerRelationShip[j].REF_CODE != null
                                              ? CachedNetworkImage(
                                            imageUrl: new Server().IPAddressDocument + "/getImage.html/" +
                                                _items[index].LawbreakerRelationShip[j].REF_CODE.toString(),
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
                                        padding: paddingInputBox,
                                        child: Text(_items[index].LawbreakerRelationShip[j].ARREST_LAWBREAKER_NAME,
                                          style: textInputStyle,),
                                      ),
                                    )
                                  ],
                                );
                              },
                              itemCount: _items[index].LawbreakerRelationShip.length,
                            ),
                          )
                        ],
                      ),
                    );
                },
              ): Container(
                padding: paddingInputBox,
                child: Text('ไม่พบผู้ต้องหา',style: textInputNotPerson,),
              ),
            ),

            /*Column(
            children: <Widget>[
              Container(
                child: Container(
                  width: 100.0,
                height: 100.0,

                  decoration: BoxDecoration(

                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white30),
                  ),
                  //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                  padding: const EdgeInsets.all(3.0),
                  child: ClipOval(
                    child: new Image(
                        fit: BoxFit.cover,
                        image: new AssetImage(
                            'assets/images/avatar.png')),
                  ),
                ),
              ),
              Container(
                padding: paddingInputBox,
                child: Text('Person 1',style: textInputStyle,),
              )
            ],
          ),*/
          ],
        )
    );
  }

  Widget _buildBlock3() {
    return Container(
        padding: EdgeInsets.only(left: 22.0, right: 22.0, bottom: 22.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text('เครือญาติ', style: textLabelStyle,),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 12.0),
              child: itemsListPersonNetHead.PERSON_RELATIONSHIPS
                  .length > 0
                  ? GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: itemsListPersonNetHead.PERSON_RELATIONSHIPS
                      .length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    String name = itemsListPersonNetHead
                        .PERSON_RELATIONSHIPS[index].TITLE_NAME_TH.toString() +
                        " " +
                        itemsListPersonNetHead
                            .PERSON_RELATIONSHIPS[index].FIRST_NAME.toString() +
                        " " +
                        itemsListPersonNetHead
                            .PERSON_RELATIONSHIPS[index].LAST_NAME.toString();

                    return Container(
                      padding: paddingLabel,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Container(
                              width: 80.0,
                              height: 80.0,

                              decoration: BoxDecoration(

                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white30),
                              ),
                              //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                              padding: const EdgeInsets.all(3.0),
                              child: ClipOval(
                                child: Image(
                                    fit: BoxFit.cover,
                                    image: new AssetImage(
                                        'assets/images/avatar.png')),
                              ),
                            ),
                          ),
                          Container(
                            padding: paddingInputBox,
                            child: Text(name, style: textInputStyle,),
                          )
                        ],
                      ),
                    );
                  }
              )
                  : Container(
                padding: paddingInputBox,
                child: Text('ไม่พบผู้ต้องหา',style: textInputNotPerson,),
              ),
            )
          ],
        )
    );
  }

  Widget _buildBlock4() {
    return Container(
        padding: EdgeInsets.only(left: 22.0, right: 22.0, bottom: 22.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text('ที่อยู่ เดียวกัน', style: textLabelStyle,),
                ),
              ],
            ),
            /*Container(
                padding: EdgeInsets.only(top: 12.0),
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: itemsListPersonNetMain.PERSON_ADDRESSES
                        .length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      String name = itemsListPersonNetMain
                          .PERSON_ADDRESSES[index].TITLE_NAME_TH
                          .toString() +
                          " " +
                          itemsListPersonNetMain
                              .PERSON_ADDRESSES[index].FIRST_NAME
                              .toString() +
                          " " +
                          itemsListPersonNetMain
                              .PERSON_ADDRESSES[index].LAST_NAME.toString();

                      return Container(
                        padding: paddingLabel,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Container(
                                width: 100.0,
                height: 100.0,

                                decoration: BoxDecoration(

                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white30),
                                ),
                                //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                                padding: const EdgeInsets.all(3.0),
                                child: ClipOval(
                                  child: new Image(
                                      fit: BoxFit.cover,
                                      image: new AssetImage(
                                          'assets/images/avatar.png')),
                                ),
                              ),
                            ),
                            Container(
                              padding: paddingInputBox,
                              child: Text('Person 1', style: textInputStyle,),
                            )
                          ],
                        ),
                      );
                    }
                )
            ),*/
          ],
        )
    );
  }


  Widget _buildContent_tab_1() {
    var size = MediaQuery
        .of(context)
        .size;

    Widget _buildContent(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildBlock1(),
            _buildBlock2(),
            _buildBlock3(),
            //_buildBlock4()
          ],
        ),
      );
    }

    return Stack(
      children: <Widget>[
        BackgroundContent(),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                //height: 34.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
              ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: SingleChildScrollView(
                    child: _buildContent(
                        context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//************************end_tab_1*******************************

