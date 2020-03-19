import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/model/lawsuit_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/model/lawsuit_list.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/server/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'dart:io';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'analysis_screen.dart';
import 'future/person_net_future.dart';
import 'model/person_net_analysis_main.dart';
import 'model/person_net_arrest_lawbreaker_relationship.dart';
import 'model/person_net_arrest_person.dart';
import 'model/person_net_lawbreaker_detail.dart';
import 'model/person_net_main.dart';
import 'package:intl/intl.dart';

class AnalysisRecognitionSearchScreenFragment extends StatefulWidget {

  Future<File> ImageFile;
  List ItemsPerson;

  AnalysisRecognitionSearchScreenFragment({
    Key key,
    @required this.ImageFile,
    @required this.ItemsPerson,
  }) : super(key: key);
  @override
  _SearchResultCameraState createState() => new _SearchResultCameraState();
}
class _SearchResultCameraState extends State<AnalysisRecognitionSearchScreenFragment> {

  //item data
  List<ItemsLawsuitList> itemsLawsuit = [];
  ItemsLawsuitArrestMain lawsuitMain;
  List _itemsInit = [];

  final formatter = new NumberFormat("#,##0.00");

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
              margin: const EdgeInsets.only(top: 22.0, bottom: 22.0),
              padding: const EdgeInsets.all(3.0),
              child: ClipOval(
                child: Image.file(snapshot.data, fit: BoxFit.cover),
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
        fontSize: 16.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    TextStyle textInputStyleSubTitle = TextStyle(
        fontSize: 15.0,
        color: Colors.grey[400],
        fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: _itemsInit.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Map map={
              "PERSON_ID" : _itemsInit[index].PERSON_ID//21
            };
            _navigatePreview(context,map,_itemsInit[index].PERSON_ID,_itemsInit[index].REF_CODE);
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
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0))
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
                              child: Text(_itemsInit[index].TITLE_SHORT_NAME_TH.toString() + ' ' +
                                  _itemsInit[index].FIRST_NAME.toString()+" "+
                                  _itemsInit[index].LAST_NAME.toString(),
                                style: textInputStyleTitle,),
                            ),
                            /*Container(
                              padding: paddingLabel,
                              child: Text("ความแน่ใจ : "+formatter.format(_itemsInit[index].CONFIDENCE).toString()+"%",
                                style: textInputStyleSubTitle,),
                            ),*/
                          ],
                        )
                      ),
                      Center(
                        child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.navigate_next,size: 28,color: Colors.grey[400],)

                        ),
                      ),
                    ],
                  ),

                  _itemsInit[index].IsCheck?Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Center(
                          child: InkWell(
                            onTap: () {
                              Map map={
                                "PERSON_ID" : _itemsInit[index].PERSON_ID
                              };
                              _navigatePreview(context,map,_itemsInit[index].PERSON_ID,_itemsInit[index].REF_CODE);
                            },

                          )
                      ),
                    ],
                  ):Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ItemsListPersonNetAnalysisMain itemsListPersonNetMain;
  ItemsListPersonNetMain itemsListPersonNetHead;
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

    setState(() {

    });
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
      print(result);

    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);
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
          body: Center(
            child: Stack(
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
                      ),
                      Center(
                        child: _buildImage(context),
                      ),

              _itemsInit.length>0
                  ?Container(
                        padding: EdgeInsets.only(bottom: 22.0),
                        child: _buildContent(),
                      ) :Container(
                  child: Center(
                    child: Text('ไม่พบข้อมูลผู้ต้องหา',style: textStyleEmpty,),
                  )
              ),

                      /*_itemsInit.length>0
                          ?Container(
                        child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _itemsInit.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(

                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(2),
                              ),
                              RaisedButton(
                                onPressed: () =>
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              NetPerson2(),
                                        )),
                                color: Colors.white,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(12),
                                        child: CircleAvatar(
                                          backgroundImage:
                                          ExactAssetImage(''),
                                          minRadius: 20,
                                          maxRadius: 30,
                                        ),
                                      ),
                                      *//*Text(
                                        groupname[index] + "    " +
                                            "$selection" + "%",
                                        style: textdetail,
                                        textAlign: TextAlign.left,

                                      ),*//*

                                      Icon(Icons.navigate_next)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                      )
                          :Container(
                        child: Center(
                          child: Text('ไม่พบข้อมูลผู้ต้องหา',style: textStyleEmpty,),
                        )
                      )*/
                    ],
                  ),
                ),
              ],
            )
          ),
        )
    );
  }
}