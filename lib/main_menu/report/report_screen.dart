import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_8.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_form_list.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:prototype_app_pang/main_menu/report/report_screen_map.dart';
import 'package:prototype_app_pang/model/test/Background.dart';


import 'future/report_future.dart';
import 'model/count_offense.dart';

class ReportMainScreenFragment extends StatefulWidget {
  final String START_DATE;
  final String END_DATE;
  ReportMainScreenFragment({
    Key key,
    @required this.START_DATE,
    @required this.END_DATE,
  }) : super(key: key);

  static List<charts.Series<LinearSales, String>> _createSampleData() {
    List<LinearSales> data = [
      new LinearSales("สสภ.1", 0,""),
      new LinearSales("สสภ.2", 1,""),
      new LinearSales("สสภ.3", 1,""),
      new LinearSales("สสภ.4", 1,""),
      new LinearSales("สสภ.5", 10,""),
      new LinearSales("สสภ.6", 1,""),
      new LinearSales("สสภ.7", 1,""),
      new LinearSales("สสภ.8", 2,""),
      new LinearSales("สสภ.9", 5,""),
      new LinearSales("สสภ.10", 50,"")
    ];


    return [
      new charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.title,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        labelAccessorFn: (LinearSales row, _) => '${row.title} : ${row
            .sales}',
      )
    ];
  }

  /// Create series list with single series
  static List<charts.Series<OrdinalSales, DateTime>> _createSampleData1() {
    final globalSalesData = [
      new OrdinalSales(new DateTime(2018, 1, 1), 45),
      new OrdinalSales(new DateTime.now(), 85),
    ];

    return [
      new charts.Series<OrdinalSales, DateTime>(
        id: 'Global Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: globalSalesData,
        //colorFn: (OrdinalSales sales, _) => charts.Color.fromHex(code: '#5887f9'),
      ),
    ];

  }
  static List<charts.Series<OrdinalSales, DateTime>> _createSampleData2() {
    final globalSalesData = [
      new OrdinalSales(new DateTime(2018, 1, 1), 95),
      new OrdinalSales(new DateTime.now(), 80),
    ];

    return [
      new charts.Series<OrdinalSales, DateTime>(
        id: 'Global Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: globalSalesData,
        //colorFn: (OrdinalSales sales, _) => charts.Color.fromHex(code: '#5887f9'),
      ),
    ];

  }
  _FragmentState createState() => new _FragmentState(_createSampleData(),_createSampleData1(),_createSampleData2(), animate: true,);
}
const double _kPickerSheetHeight = 216.0;
class _FragmentState extends State<ReportMainScreenFragment>  with TickerProviderStateMixin {
  List<charts.Series> seriesList;
  List<charts.Series> seriesList1;
  List<charts.Series> seriesList2;
  bool animate;
  _FragmentState(this.seriesList,this.seriesList1,this.seriesList2, {this.animate});


  TabController tabController;
  TabPageSelector _tabPageSelector;

  List<Choice> choices = <Choice>[
    Choice(title: 'จำนวนคดี'),
    Choice(title: 'รายงาน'),
  ];
  //item forms
  List<ItemsListArrest8> itemsFormsTab = [];

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
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);


  List<ItemsCountOffense> itemMain = [];
  List<LinearSales> data_init = [];

  /// Create one series with sample hard coded data.
  List<charts.Series<LinearSales, String>> _createSampleData(List<LinearSales> data) {
    /*List<LinearSales> data = [
      new LinearSales("สสภ.1", 50),
      new LinearSales("สสภ.2", 1),
      new LinearSales("สสภ.3", 1),
      new LinearSales("สสภ.4", 1),
      new LinearSales("สสภ.5", 10),
      new LinearSales("สสภ.6", 1),
      new LinearSales("สสภ.7", 1),
      new LinearSales("สสภ.8", 2),
      new LinearSales("สสภ.9", 5),
      new LinearSales("สสภ.10", 0)
    ];*/

    return [
      new charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.title,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        labelAccessorFn: (LinearSales row, _) => '${row.title} : ${row.sales}',
      )
    ];
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);


    itemsFormsTab.add(new ItemsListArrest8("รายงานจำนวนคดี",""));
    itemsFormsTab.add(new ItemsListArrest8("ผลปราบปรามผู้กระทำผิดกฎหมายสรรพสามิต",""));
    itemsFormsTab.add(new ItemsListArrest8("รายงานรายละเอียดค่าปรับ",""));
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
      onWillPop: () {
      },
      child: Scaffold(
        body: _buildContent_tab_1(),
      ),
    );
  }

  //************************start_tab_1*****************************

  Widget _buildContent_tab_1() {
    var size = MediaQuery
        .of(context)
        .size;

    final fmt_1 = new DateFormat('yyyy');

    Widget _build_chart1() {
      return Container(
        padding: EdgeInsets.all(22.0),
        decoration: BoxDecoration(
          //color: Colors.white,
            border: Border(
              //top: BorderSide(color: Colors.grey[300], width: 1.0),
              //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingInputBox,
              child: Text('รายงานจำนวนคดี (1 ม.ค. - 31 ธ.ค. '+(int.parse(fmt_1.format(DateTime.now()))+543).toString().substring(2)+")",
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
                  /*Container(
                    padding: paddingInputBox,
                    child: Text('หมวดของกลาง สุรา',
                      style: textInputSubStyle,),
                  ),*/
                ],
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height / 2,
              child: Container(
                //color: Colors.green,
                child: new charts.BarChart(
                  _createSampleData(data_init),
                  animate: animate,
                  vertical: false,
                )/*new charts.PieChart(
                  //seriesList,
                  _createSampleData(data_init),
                  animate: animate,
                  defaultRenderer: new charts.ArcRendererConfig(
                      arcWidth: 60,
                      arcRendererDecorators: [
                        new charts.ArcLabelDecorator(
                          labelPosition: charts.ArcLabelPosition.auto,
                        ),
                      ]
                  ),
                  behaviors: [
                    new charts.DatumLegend(
                      position: charts.BehaviorPosition.end,
                      horizontalFirst: false,
                      cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                      showMeasures: true,
                      measureFormatter: (num value) {
                        return value == null ? '-' : '${value}k';
                      },
                    ),
                  ],
                ),*/

              ),


            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                child: Text("ดูแบบแผนที่..", style: textLabelStyle,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        ReportMapScreenFragment(
                          ListData: data_init,
                          IsSearch: false,
                          START_DATE: DateFormat('yyyy').format(DateTime.now())+'01-01',
                          END_DATE: DateFormat('yyyy').format(DateTime.now())+'12-31',
                        )),
                  );
                },
              ),

            ),

          ],
        ),
      );
    }
    Widget _build_chart2() {
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
              child: Text('รายงานจำนวนเงินค่าปรับ (1 ม.ค. - 31 ธ.ค.)',
                style: textLabelStyle,),
            ),
            SizedBox(
              width: size.width,
              height: size.height / 2,
              child: Container(
                  child: new charts.BarChart(
                    seriesList,
                    animate: animate,
                    vertical: false,
                  )
              ),
            )

          ],
        ),
      );
    }
    Widget _build_chart3() {
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
              child: Text('รายงานจำนวนคดีย้อนหลัง ( 1 ม.ค. - 31 ธ.ค.)',
                style: textLabelStyle,),
            ),
            SizedBox(
              width: size.width,
              height: size.height / 2,
              child: Container(
                  child: /*new charts.BarChart(
                    seriesList1,
                    animate: animate,
                    defaultRenderer: new charts.BarRendererConfig(
                        cornerStrategy: const charts.ConstCornerStrategy(30)),
                  )*/
                  new charts.TimeSeriesChart(
                      seriesList1,
                      animate: animate,
                      defaultRenderer: new charts.LineRendererConfig(
                          includePoints: true),
                      behaviors: [
                        new charts.RangeAnnotation([
                          new charts.RangeAnnotationSegment(
                              new DateTime(2018, 12, 31),
                              new DateTime(2019, 12, 31),
                              charts.RangeAnnotationAxisType.domain
                          ),
                        ]),
                      ])
              ),
            )

          ],
        ),
      );
    }

    Widget _build_chart4() {
      return Container(
        padding: EdgeInsets.all(22.0),
        decoration: BoxDecoration(
            //color: Colors.white,
            border: Border(
              //top: BorderSide(color: Colors.grey[300], width: 1.0),
              //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingInputBox,
              child: Text('รายงานเงินค่าปรับย้อนหลัง (1 ม.ค. - 31 ธ.ค.)',
                style: textLabelStyle,),
            ),
            SizedBox(
              width: size.width,
              height: size.height / 2,
              child: Container(
                  child: /*new charts.OrdinalComboChart(
                  seriesList1,
                  animate: animate,
                  defaultRenderer: new charts.BarRendererConfig(
                    cornerStrategy: const charts.ConstCornerStrategy(30),
                  ),
                ),*/
                  new charts.TimeSeriesChart(
                      seriesList2,
                      animate: animate,
                      defaultRenderer: new charts.LineRendererConfig(
                          includePoints: true),
                      behaviors: [
                        new charts.RangeAnnotation([
                          new charts.RangeAnnotationSegment(
                              new DateTime(2018, 12, 31),
                              new DateTime(2019, 12, 31),
                              charts.RangeAnnotationAxisType.domain
                          ),
                        ]),
                      ])
              ),
            )
          ],
        ),
      );
    }

    Widget _buildContent(BuildContext context) {
      final fmt = new DateFormat('yyyy');
      final fmt_1 = new DateFormat('yyyy-MM-dd');
      String first_day = fmt.format(DateTime.now()).toString()+"-01-01";
      String last_day = fmt.format(DateTime.now()).toString()+"-12-31";

      Map map;
      if(widget.START_DATE!=null&&widget.END_DATE!=null) {
        map = {
          "LAWSUIT_DATE_FROM": first_day,
          "LAWSUIT_DATE_TO": last_day
        };
        print('start : '+map.toString());
      }else{
        map = {
          "LAWSUIT_DATE_FROM": widget.START_DATE,
          "LAWSUIT_DATE_TO": widget.END_DATE
        };
        print('serch : '+map.toString());
      }

      print("map : "+map.toString());
      return FutureBuilder<List<ItemsCountOffense>>(
        future: new ReportFuture().apiRequestCountOffenseOfZoneByTime(map),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            itemMain = snapshot.data;

            List<LinearSales> data_base = [
              new LinearSales("สสภ.1", 0,""),
              new LinearSales("สสภ.2", 0,""),
              new LinearSales("สสภ.3", 0,""),
              new LinearSales("สสภ.4", 0,""),
              new LinearSales("สสภ.5", 0,""),
              new LinearSales("สสภ.6", 0,""),
              new LinearSales("สสภ.7", 0,""),
              new LinearSales("สสภ.8", 0,""),
              new LinearSales("สสภ.9", 0,""),
              new LinearSales("สสภ.10", 0,"")
            ];

            print(itemMain.length);
            itemMain.forEach((item){
              for(int i=0;i<data_base.length;i++){

                if(item.SHORT_NAME==null){
                  if(item.ZONE_SHORT_NAME.trim().endsWith(data_base[i].title)){
                    data_base[i] =  new LinearSales(item.ZONE_SHORT_NAME, item.COUNT,item.ZONE_OFFCODE);
                    break;
                  }
                }else{
                  if(item.SHORT_NAME.trim().endsWith(data_base[i].title)){
                    data_base[i] =  new LinearSales(item.SHORT_NAME, item.COUNT,item.OFFCODE);
                    break;
                  }
                }

              }
            });
           data_init = data_base;

            return Container(
              padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
              child: Column(
                children: <Widget>[
                  _build_chart1(),
                  /*_build_chart2(),
                  _build_chart3(),
            _build_chart4(),*/
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: CupertinoActivityIndicator(
                ),
              )
            ],
          );
        },
      );
       /* Container(
          padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
          child: Column(
            children: <Widget>[
              _build_chart1(),
              *//*_build_chart2(),
                  _build_chart3(),
            _build_chart4(),*//*
            ],
          ),
        );*/
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
                                  Title: itemsFormsTab[index].FormsName,
                                  FILE_PATH: itemsFormsTab[index].FormsCode,
                                ),
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
class LinearSales {
  final String title;
  final int sales;
  final String OFFOCDE;

  LinearSales(this.title, this.sales,this.OFFOCDE);
}
/// Sample ordinal data type.
class OrdinalSales {
  final DateTime  year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
