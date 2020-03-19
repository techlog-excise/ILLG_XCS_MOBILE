

import 'package:flutter/cupertino.dart' as prefix1;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/material.dart';

import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_form_list.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:prototype_app_pang/main_menu/report/report_screen.dart';
import 'package:prototype_app_pang/main_menu/report/report_screen_map.dart';
import 'package:prototype_app_pang/main_menu/report/report_screen_map_area.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'future/report_future.dart';
import 'model/count_offense_area.dart';


class DataTableModel{
  String NAME_OFFICE;
  int COUNT_OFFEND;
  DataTableModel({this.NAME_OFFICE,this.COUNT_OFFEND});
}

class DataTableModelArea {
  String OFFNAME;
  int LAWSUIT_AMOUNT;
  double PAYMENT_FINE;
  double FINE;
  double FINE_ESTIMATE;
  double BRIBE_MONEY;
  double REWARD_MONEY;
  double TREASURY_MONEY;

  DataTableModelArea(
      this.OFFNAME,
      this.LAWSUIT_AMOUNT,
      this.PAYMENT_FINE,
      this.FINE,
      this.FINE_ESTIMATE,
      this.BRIBE_MONEY,
      this.REWARD_MONEY,
      this.TREASURY_MONEY,
      );
}


class ReportMapScreenFragment extends StatefulWidget {
  List<LinearSales> ListData;
  bool IsSearch;
  String START_DATE;
  String END_DATE;
  ReportMapScreenFragment({
    Key key,
    @required this.ListData,
    @required this.IsSearch,
    @required this.START_DATE,
    @required this.END_DATE,
  }) : super(key: key);
  _FragmentState createState() => new _FragmentState();
}
const double _kPickerSheetHeight = 216.0;
class _FragmentState extends State<ReportMapScreenFragment>  with TickerProviderStateMixin {

  TabController tabController;
  TabPageSelector _tabPageSelector;

  List<Choice> choices = <Choice>[
    Choice(title: 'จำนวนคดี'),
    Choice(title: 'รายงาน'),
  ];
  //item forms
  List<ItemsDestroyForms> itemsFormsTab = [];
TextStyle textTableStyle = TextStyle(
      fontSize: 12.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
TextStyle textAppbarStyle = TextStyle(
      fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleLaw = TextStyle(
      fontSize: 13.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputSubStyle = TextStyle(
      fontSize: 14.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyleSub = TextStyle(fontSize: 15.0,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  TextStyle textLabelStyleHeader = TextStyle(fontSize: 15.0,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyleBody = TextStyle(fontSize: 14.0,
      color: Colors.grey[700],
      fontFamily: FontStyles().FontFamily);

  final formatter = new NumberFormat("#,###");


  List<DataTableModel> itemsDataTable = [];
  var dateFormatDate;

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');

    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);


    itemsFormsTab.add(new ItemsDestroyForms("รายงานจำนวนคดี"));
    itemsFormsTab.add(new ItemsDestroyForms("ผลปราบปรามผู้กระทำผิดกฎหมายสรรพสามิต"));
    itemsFormsTab.add(new ItemsDestroyForms("รายงานรายละเอียดค่าปรับ"));
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


    return Scaffold(


      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,),
          onPressed: () => Navigator.of(context).pop(),
        ),

        title: Text("รายงานสถิติ", style: textAppbarStyle,),
        centerTitle: true,),
      body: _buildContent_tab_1(context),

    );
  }

  //************************start_tab_1*****************************

  List<TableRow> _rows(){
    List<TableRow> row=[];

    //add header
    row.add(
      new TableRow(
          children: <Widget>[
            Container(
              child: Text(
                'ลำดับ', style: textLabelStyleHeader,),
            ),
            Container(
              child: Text(
                'สรรพสามิต', style: textLabelStyleHeader,),
            ),
            Container(
              child: Text(
                'จำนวนคดี',
                style: textLabelStyleHeader,),
            ),
          ]
      ),
    );


    //add body
    int index = 0;
    itemsDataTable.forEach((item){
      index++;
      row.add(
          new TableRow(
            children: <Widget>[
              Container(
                padding: paddingInputBox,
                child: Text(
                  index.toString(),
                  style: textLabelStyleBody,),
              ),
              Container(
                padding: paddingInputBox,
                child: Text(item.NAME_OFFICE.toString(),
                  style: textLabelStyleBody,),
              ),
              Container(
                padding: paddingInputBox,
                child: Text(formatter.format(item.COUNT_OFFEND).toString(),
                  style: textLabelStyleBody,),
              ),
            ],
          )
      );
    });
    return row;
  }

  Widget _buildContent_tab_1(BuildContext mContext) {
    var size = MediaQuery
        .of(context)
        .size;

    itemsDataTable = [
      new DataTableModel(NAME_OFFICE: "สสภ.1", COUNT_OFFEND: widget.ListData[0].sales),
      new DataTableModel(NAME_OFFICE: "สสภ.2", COUNT_OFFEND: widget.ListData[1].sales),
      new DataTableModel(NAME_OFFICE: "สสภ.3", COUNT_OFFEND: widget.ListData[2].sales),
      new DataTableModel(NAME_OFFICE: "สสภ.4", COUNT_OFFEND: widget.ListData[3].sales),
      new DataTableModel(NAME_OFFICE: "สสภ.5", COUNT_OFFEND: widget.ListData[4].sales),
      new DataTableModel(NAME_OFFICE: "สสภ.6", COUNT_OFFEND: widget.ListData[5].sales),
      new DataTableModel(NAME_OFFICE: "สสภ.7", COUNT_OFFEND: widget.ListData[6].sales),
      new DataTableModel(NAME_OFFICE: "สสภ.8", COUNT_OFFEND: widget.ListData[7].sales),
      new DataTableModel(NAME_OFFICE: "สสภ.9", COUNT_OFFEND:  widget.ListData[8].sales),
      new DataTableModel(NAME_OFFICE: "สสภ.10", COUNT_OFFEND: widget.ListData[9].sales),
    ];

    itemsDataTable.sort((a, b) {
      return a.COUNT_OFFEND.compareTo(b.COUNT_OFFEND);
    });
    List<DataTableModel> _item_model=[];
    for(int i=itemsDataTable.length-1;i>=0;i--){
      _item_model.add(itemsDataTable[i]);
    }
    itemsDataTable = _item_model;

    final fmt_1 = new DateFormat('yyyy');
        
    Widget _build_chart1() {
      return Container(
        padding: EdgeInsets.all(22.0),
        decoration: BoxDecoration(
          //color: Colors.white,
            border: Border(
              //top: BorderSide(color: Colors.grey[300], width: 1.0),
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingInputBox,
              child: Text('รายงานจำนวนคดี ('+DateFormat("dd").format(DateTime.parse(widget.START_DATE))+' ม.ค. - '+DateFormat("dd").format(DateTime.parse(widget.END_DATE))+' ธ.ค. '+(int.parse(fmt_1.format(DateTime.now()))+543).toString().substring(2)+")",
                style: textLabelStyle,),
            ),
            Container(
              padding: paddingInputBox,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: paddingInputBox,
                    child: Text('ระดับ ทั่วประเทศ',
                      style: textInputSubStyle,),
                  ),
                  /* Container(
                    padding: paddingInputBox,
                    child: Text('หมวดของกลาง สุรา',
                      style: textInputSubStyle,),
                  ),*/
                ],
              ),
            ),

//*********************************************************************/ไทยทั้งแผ่น 

            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/map/map2.png',
                        width: 500.0, height: 500.0),


                  ),

                  Container(
                    //เหนือบน
                      padding: EdgeInsets.all(75),
                      child: SizedBox(
                          width: 80,
                          height: 20,
                          child: Align(

                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff087de1), width: 1.5),
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Text(
                                widget.ListData[4].sales.toString() + " คดี",
                                style: textInputStyleLaw,),
                              onPressed: () {
                                navigate_area(mContext, widget.ListData[4].title, widget.ListData[4].OFFOCDE);
                              },

                            ),
                          )
                      )
                  ),


                  Container(
                    //เหนือล่าง
                      padding: EdgeInsets.only(
                          left: 90, right: 20, bottom: 50, top: 110),
                      child: SizedBox(
                          width: 80,
                          height: 20,
                          child: Align(

                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff087de1), width: 1.5),
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Text(
                                  widget.ListData[5].sales.toString() + " คดี",
                                  style: textInputStyleLaw),
                              onPressed: () {
                                navigate_area(mContext, widget.ListData[5].title, widget.ListData[5].OFFOCDE);
                              },

                            ),
                          )
                      )
                  ),


                  Container(
                    //อีสานบน
                      padding: EdgeInsets.only(
                          left: 200, right: 20, bottom: 80, top: 90),
                      child: SizedBox(
                          width: 80,
                          height: 20,
                          child: Align(
                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff087de1), width: 1.5),
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Text(
                                  widget.ListData[3].sales.toString() + " คดี",
                                  style: textInputStyleLaw),
                              onPressed: () {
                                navigate_area(mContext, widget.ListData[3].title, widget.ListData[3].OFFOCDE);
                              },

                            ),
                          )
                      )
                  ),


                  Container(
                    //อีสานล่าง
                      padding: EdgeInsets.only(
                          left: 240, right: 20, bottom: 80, top: 150),
                      child: SizedBox(
                          width: 80,
                          height: 20,
                          child: Align(

                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff087de1), width: 1.5),
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Text(
                                  widget.ListData[2].sales.toString() + " คดี",
                                  style: textInputStyleLaw),
                              onPressed: () {
                                navigate_area(mContext, widget.ListData[2].title, widget.ListData[2].OFFOCDE);
                              },

                            ),
                          )
                      )
                  ),


                  Container(
                    //กลาง
                      padding: EdgeInsets.only(
                          left: 120, right: 20, bottom: 80, top: 162),
                      child: SizedBox(
                          width: 80,
                          height: 20,
                          child: Align(

                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff087de1), width: 1.5),
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Text(
                                  widget.ListData[0].sales.toString() + " คดี",
                                  style: textInputStyleLaw),
                              onPressed: () {
                                navigate_area(mContext, widget.ListData[0].title, widget.ListData[0].OFFOCDE);
                              },

                            ),
                          )
                      )
                  ),


                  Container(
                    //ตะวันตก
                      padding: EdgeInsets.only(
                          left: 45, right: 20, bottom: 80, top: 230),
                      child: SizedBox(
                          width: 80,
                          height: 20,
                          child: Align(

                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff087de1), width: 1.5),
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Text(
                                  widget.ListData[6].sales.toString() + " คดี",
                                  style: textInputStyleLaw),
                              onPressed: () {
                                navigate_area(mContext, widget.ListData[6].title, widget.ListData[6].OFFOCDE);
                              },

                            ),
                          )
                      )
                  ),


                  Container(
                    //ตะวันออก
                      padding: EdgeInsets.only(
                          left: 185, right: 20, bottom: 80, top: 255),
                      child: SizedBox(
                          width: 80,
                          height: 20,
                          child: Align(

                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff087de1), width: 1.5),
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Text(
                                  widget.ListData[1].sales.toString() + " คดี",
                                  style: textInputStyleLaw),
                              onPressed: () {
                                navigate_area(mContext, widget.ListData[1].title, widget.ListData[1].OFFOCDE);
                              },

                            ),
                          )
                      )
                  ),


                  Container(
                    //กทม
                      padding: EdgeInsets.only(
                          left: 115, right: 20, bottom: 80, top: 200),
                      child: SizedBox(
                          width: 80,
                          height: 20,
                          child: Align(

                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff087de1), width: 1.5),
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Text(
                                  widget.ListData[9].sales.toString() + " คดี",
                                  style: textInputStyleLaw),
                              onPressed: () {
                                navigate_area(mContext, widget.ListData[9].title, widget.ListData[9].OFFOCDE);
                              },

                            ),
                          )
                      )
                  ),


                  Container(
                    //ใต้บน
                      padding: EdgeInsets.only(
                          left: 70, right: 20, bottom: 80, top: 340),
                      child: SizedBox(
                          width: 80,
                          height: 20,
                          child: Align(

                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff087de1), width: 1.5),
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Text(
                                  widget.ListData[7].sales.toString() + " คดี",
                                  style: textInputStyleLaw),
                              onPressed: () {
                                navigate_area(mContext, widget.ListData[7].title, widget.ListData[7].OFFOCDE);
                              },

                            ),
                          )
                      )
                  ),


                  Container(
                    //ใต้ล่าง
                      padding: EdgeInsets.only(
                          left: 138, right: 20, bottom: 80, top: 447),
                      child: SizedBox(
                          width: 80,
                          height: 20,
                          child: Align(

                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Color(0xff087de1), width: 1.5),
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Text(
                                  widget.ListData[8].sales.toString() + " คดี",
                                  style: textInputStyleLaw),
                              onPressed: () {
                                navigate_area(mContext, widget.ListData[8].title, widget.ListData[8].OFFOCDE);
                              },

                            ),
                          )
                      )
                  ),


                ],
                //color: Colors.green,


              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 8,bottom: 22),
              child: Text("อันดับจำนวนคดีเรียงจากมากไปน้อย",
                style: textLabelStyle,),
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('ลำดับ', style: textLabelStyleSub,),
                Text('สรรพสามิต', style: textLabelStyleSub,),
                Text('จำนวนคดี', style: textLabelStyleSub,),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Container(
                color: Colors.black45, height: 1.5,),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: itemsDataTable.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: paddingInputBox,
                        child: Text((index + 1).toString(), style: textLabelStyleSub,),
                      ),
                      Container(
                        padding: paddingInputBox,
                        child: Text(itemsDataTable[index].NAME_OFFICE,
                          style: textLabelStyleSub,),
                      ),
                      Container(
                        padding: paddingInputBox,
                        child: Text(itemsDataTable[index].COUNT_OFFEND.toString(),
                          style: textLabelStyleSub,),
                      ),
                    ],
                  );
                }
            ),*/
            Container(
                padding: EdgeInsets.only(left:22.0,right: 22.0,bottom: 22.0),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: new Table(
                      border: new TableBorder(
                          horizontalInside: new BorderSide(color: Colors.grey[200], width: 0.5)
                      ),
                      columnWidths: new Map.from({
                        0: new FixedColumnWidth(80.0),
                        1: new FixedColumnWidth(130.0),
                        2: new FixedColumnWidth(80.0),
                      }),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: _rows(),
                    )
                )
            )

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
                /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text('ILG60_B_10_00_03_00',
                    style: textStylePageName,),
                )
              ],
            ),*/
              ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: SingleChildScrollView(
                    child:  _build_chart1(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<DataTableModelArea> _mapModelArea(String type){
    List<DataTableModelArea> _data =[];

    switch(type.trim()){
      case "สสภ.1" :
        _data = [
          new DataTableModelArea("สสพ.ชัยนาท", 0,0,0,0,0,0,0), //0
          new DataTableModelArea("สสพ.สิงห์บุรี", 0,0,0,0,0,0,0), //1
          new DataTableModelArea("สสพ.ลพบุรี", 0,0,0,0,0,0,0), //2
          new DataTableModelArea("สสพ.สระบุรี", 0,0,0,0,0,0,0), //3
          new DataTableModelArea("สสพ.อ่างทอง", 0,0,0,0,0,0,0),  //4
          new DataTableModelArea("สสพ.อยุธยา 1", 0,0,0,0,0,0,0), //5
          new DataTableModelArea("สสพ.อยุธยา 2", 0,0,0,0,0,0,0), //6
          new DataTableModelArea("สสพ.นนทบุรี", 0,0,0,0,0,0,0),  //7
          new DataTableModelArea("สสพ.ปทุมธานี 1", 0,0,0,0,0,0,0), //8
          new DataTableModelArea("สสพ.ปทุมธานี 2", 0,0,0,0,0,0,0), //9
        ];
        break;
      case "สสภ.2" :
        _data = [
          new DataTableModelArea("สสพ.นครนายก", 0,0,0,0,0,0,0), //0
          new DataTableModelArea("สสพ.ปราจีนบุรี", 0,0,0,0,0,0,0), //1
          new DataTableModelArea("สสพ.สระแก้ว", 0,0,0,0,0,0,0), //2
          new DataTableModelArea("สสพ.สมุทรปรากา 1", 0,0,0,0,0,0,0), //3
          new DataTableModelArea("สสพ.สมุทรปรากา 2", 0,0,0,0,0,0,0),  //4
          new DataTableModelArea("สสพ.ฉะเชิงเทรา", 0,0,0,0,0,0,0), //5
          new DataTableModelArea("สสพ.ชลบุรี 1", 0,0,0,0,0,0,0), //6
          new DataTableModelArea("สสพ.ชลบุรี 2", 0,0,0,0,0,0,0), //7
          new DataTableModelArea("สสพ.ระยอง 1", 0,0,0,0,0,0,0), //8
          new DataTableModelArea("สสพ.ระยอง 2", 0,0,0,0,0,0,0), //9
          new DataTableModelArea("สสพ.จันทบุรี", 0,0,0,0,0,0,0), //10
          new DataTableModelArea("สสพ.ตราด", 0,0,0,0,0,0,0), //11
        ];
        break;
      case "สสภ.3" :
        _data = [
          new DataTableModelArea("สสพ.ชัยภูมิ", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.นครราชสีมา", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.บุรีรัมย์", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.สุรินทร์", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.ร้อยเอ็ด", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.ยโสธร", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.อำนาจเจริญ", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.อุบลราชธานี", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.ศรีสะเกษ", 0,0,0,0,0,0,0),
        ];
        break;
      case "สสภ.4" :
        _data = [
          new DataTableModelArea("สสพ.เลย", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.หนองบัวลำภู", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.บึงกาฬ", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.หนองคาย", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.ขอนแก่น", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.อุดรธานี", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.มหาสารคาม", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.กาฬสินธ์", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.มุกดาหาร", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.นครพนม", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.สกลนคร", 0,0,0,0,0,0,0)
        ];
        break;
      case "สสภ.5" :
        _data = [
          new DataTableModelArea("สสพ.แม่ฮ่องสอน", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.เชียงใหม่", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.เชียงราย", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.พะเยา", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.ลำพูน", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.ลำปาง", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.น่าน", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.แพร่", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.อุตรดิสถ์", 0,0,0,0,0,0,0),
        ];
        break;
      case "สสภ.6" :
        _data = [
          new DataTableModelArea("สสพ.ตาก", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.สุโขทัย", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.พิษณุโลก", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.เพชรบูรณ์", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.กำแพงเพชร", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.อุทัยธานี", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.พิจิตร", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.นครสวรรค์", 0,0,0,0,0,0,0),
        ];
        break;
      case "สสภ.7" :
        _data = [
          new DataTableModelArea("สสพ.กาญจนบุรี", 0,0,0,0,0,0,0), //00
          new DataTableModelArea("สสพ.สุพรรณบุรี", 0,0,0,0,0,0,0), //1
          new DataTableModelArea("สสพ.นครปฐม 1", 0,0,0,0,0,0,0), //2
          new DataTableModelArea("สสพ.นครปฐม 2", 0,0,0,0,0,0,0), //3
          new DataTableModelArea("สสพ.ราชบุรี", 0,0,0,0,0,0,0), //4
          new DataTableModelArea("สสพ.สมุทรสาคร", 0,0,0,0,0,0,0), //5
          new DataTableModelArea("สสพ.สมุทรสงคราม", 0,0,0,0,0,0,0), //6
          new DataTableModelArea("สสพ.เพชรบุรี", 0,0,0,0,0,0,0), //7
          new DataTableModelArea("สสพ.ประจวบคีรีขันธ์", 0,0,0,0,0,0,0), //8
        ];
        break;
      case "สสภ.8" :
        _data = [
          new DataTableModelArea("สสพ.ชุมพร", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.ระนอง", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.สุราษฎ์ธานี", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.พังงา", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.กระบี่", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.นครศรีธรรมราช", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.ภูเก็ต", 0,0,0,0,0,0,0),
        ];
        break;
      case "สสภ.9" :
        _data = [
          new DataTableModelArea("สสพ.ตรัง", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.พัทลุง", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.สตูล", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.สงขลา", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.ปัตตานี", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.ยะลา", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.นราธิวาส", 0,0,0,0,0,0,0),
        ];
        break;
      case "สสภ.10" :
        _data = [
          new DataTableModelArea("สสพ.กทม.1", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.กทม.2", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.กทม.3", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.กทม.4", 0,0,0,0,0,0,0),
          new DataTableModelArea("สสพ.กทม.5", 0,0,0,0,0,0,0),
        ];
        break;
    }
    return _data;
  }

  List<DataTableModelArea> itemsOffenseArea=[];
  Future<bool> onLoadAction(OFFICE_CODE,TYPE) async {
    final fmt = new DateFormat('yyyy-MM-dd');
    final fmt_1 = new DateFormat('yyyy');
    String first_day = fmt.format(DateTime.parse(fmt_1.format(DateTime.now())+"01-01")).toString();
    String last_day = fmt.format(DateTime.parse(fmt_1.format(DateTime.now())+"12-31")).toString();

    Map map={
      "LAWSUIT_DATE_FROM": widget.IsSearch?widget.START_DATE:first_day,
      "LAWSUIT_DATE_TO": widget.IsSearch?widget.END_DATE:last_day,
      "SUPOFFCODE": OFFICE_CODE
    };
    print(map);

    await new ReportFuture().apiRequestCountOffenseOfAreaByZone(map).then((onValue) {

      print(TYPE);
      List<DataTableModelArea> data_base = _mapModelArea(TYPE);


      print(onValue.length);
      onValue.forEach((item){
        for(int i=0;i<data_base.length;i++) {
          print(("สสพ." + item.OFFNAME.substring(24, item.OFFNAME.length).trim()).trim()+", "+data_base[i].OFFNAME);
          if (("สสพ." + (item.OFFNAME.substring(24, item.OFFNAME.length).trim()).trim())
              .endsWith(data_base[i].OFFNAME)) {
            data_base[i] = new DataTableModelArea(
                "สสพ."+item.OFFNAME.substring(24, item.OFFNAME.length).trim(),
              item.LAWSUIT_AMOUNT,
              item.PAYMENT_FINE,
              item.FINE,
              item.FINE_ESTIMATE,
              item.BRIBE_MONEY,
              item.REWARD_MONEY,
              item.TREASURY_MONEY,
            );
            break;
          }
        }
      });

      itemsOffenseArea = data_base;
    });
    setState(() {});
    return true;
  }

  navigate_area(mContext,sTitle,OFFICE_CODE) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadAction(OFFICE_CODE, sTitle);
    Navigator.pop(context);

    if (itemsOffenseArea.length > 0) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            ReportMapAreaFragment(
              Title: sTitle,
              itemsOffenseArea: itemsOffenseArea,
              START_DATE: widget.START_DATE,
              END_DATE: widget.END_DATE,
            )),
      );
    }
  }

//************************end_tab_1*******************************

//************************start_tab_3*****************************
  Widget _buildContent_tab_2() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            itemCount: itemsFormsTab.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                //padding: EdgeInsets.only(top: 2, bottom: 2),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      //color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: ListTile(
                      leading: Padding(padding: paddingLabel,
                        child: Text((index + 1).toString() + '. ',
                          style: textInputStyleTitle,),),
                      title: Padding(padding: paddingLabel,
                        child: Text(itemsFormsTab[index].FormsName,
                          style: textInputStyleTitle,),),
                      trailing: Icon(
                        Icons.arrow_forward_ios, color: Colors.grey[400],
                        size: 18.0,),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                TabScreenArrest8Dowload(
                                  Title: itemsFormsTab[index].FormsName,),
                            ));
                      }
                  ),
                ),
              );
            }
        ),
      );
    }
    //data result when search data
    return Scaffold(
        backgroundColor: Colors.grey[200],
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
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey[300], width: 1.0),
                          //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )
                    ),
                    /*child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text(
                      'ILG60_B_10_00_07_00', style: textStylePageName,),
                  )
                ],
              ),*/
                  ),
                  SingleChildScrollView(
                    child: _buildContent(),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }


//************************end_tab_3*******************************
}