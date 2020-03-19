import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_detail_screen.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/tracking_list_arrest_items.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class TrackingDetailType1ScreenFragment extends StatefulWidget {
  int Type;
  var Data;
  String Title;
  TrackingDetailType1ScreenFragment({
    Key key,
    @required this.Type,
    @required this.Data,
    @required this.Title,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<TrackingDetailType1ScreenFragment> {

  TextStyle textInputStyle = TextStyle(fontSize: 16.0,
      color: Colors.black,
      fontFamily: FontStyles().FontFamily);
  TextStyle textInputSubStyle = TextStyle(fontSize: 16.0,
      color: Colors.black,
      fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(
      fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textLabelHeadStyle = TextStyle(
      fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 8.0);

  String text_action="";
  var dateFormatDate,dateFormatTime;
  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');

    if(widget.Type==1){
      text_action="รับคดี";
    }else if(widget.Type==2) {
      text_action="คำพิพากษา";
    }else{
      text_action="";
    }

    print(widget.Type);
  }


  @override
  void dispose() {
    super.dispose();
  }

  void onActionClick(type){
    print(type);
  }

  Widget _buildContentData(BuildContext context) {
    String label_title1, label_title2, label_title3;

    String track_code;
    String track_date;
    String track_person;

    if (widget.Type == 1) {
      label_title1 = "เลขใบงานจับกุม";
      label_title2 = "วันที่เกิดเหตุ";
      label_title3 = "ผู้ต้องหา";

      track_code = widget.Data.ARREST_CODE;
      track_date = _convertDate(widget.Data.OCCURRENCE_DATE)+" "+_convertTime(widget.Data.OCCURRENCE_DATE);

      String law_name = "";
      widget.Data.LawbreakerList.forEach((law){
        law_name += law.ARREST_LAWBREAKER_NAME+"\n";
      });
      track_person = law_name;
    } else if (widget.Type == 2) {
      label_title1 = "เลขใบงานจับกุม";
      label_title2 = "วันที่เกิดเหตุ";
      label_title3 = "ผู้กล่าวหา";

      track_code = widget.Data.ARREST_CODE;
      track_date = _convertDate(widget.Data.OCCURRENCE_DATE)+" "+_convertTime(widget.Data.OCCURRENCE_DATE);

      String law_name = "";
      widget.Data.LawbreakerList.forEach((law){
        law_name += law.ARREST_LAWBREAKER_NAME+"\n";
      });
      track_person = law_name;
    } else if (widget.Type == 2) {

    } else {
      label_title1 = "";
      label_title2 = "";
      label_title3 = "";
      track_code = "";
      track_date="";
      track_person="";
    }

    return Padding(
      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
      child: Container(
          padding: EdgeInsets.all(0.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border(
                //top: BorderSide(color: Colors.grey[300], width: 1.0),
                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )
          ),
          child: Container(
            padding: EdgeInsets.only(
                left: 22.0, right: 22.0, top: 12.0, bottom: 12.0),
            child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      label_title1, style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      track_code,
                      style: textInputStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(label_title2, style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      track_date,
                      style: textInputStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(label_title3, style: textLabelStyle,),
                  ),
                  ListView.builder(
                    itemCount: 1,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: paddingInputBox,
                        child: Text(
                          track_person.toString(),
                          style: textInputStyle,),
                      );
                    },
                  ),
                ],
              ),
            ],
            ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      }, child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Text(widget.Title,
            style: styleTextAppbar,
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          /*actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  onActionClick(widget.Type);
                },
                child: Text(text_action, style: styleTextAppbar))
            *//*IconButton(icon: Icon(Icons.search), onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      StockBookSearchScreenFragment(),
                  ));
            })*//*
          ],*/
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
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  /*child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
                          child: new Text('ILG60_B_13_00_04_00',
                            style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
                        ),
                      ],
                    ),
                  ],
                )*/
                ),
                Expanded(
                  child: _buildContentData(context),
                ),
              ],
            ),
          ),
        ],
      )
    ),
    );
  }


  String _convertDate(String sDate) {
    String result;
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    result = splits[0] +
        " " +
        splits[1] +
        " " +
        (int.parse(splits[3]) + 543).toString();

    return result;
  }
  String _convertTime(String sDate) {
    DateTime dt = DateTime.parse(sDate);
    String result = "เวลา " + dateFormatTime.format(dt).toString();
    return result;
  }

  String _convertYear(String sDate) {
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    String year = (int.parse(splits[3]) + 543).toString();
    return year;
  }

}