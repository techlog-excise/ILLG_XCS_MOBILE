import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/report/report_screen_from_search.dart';
import 'package:prototype_app_pang/main_menu/report/report_screen_map.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';
import 'package:prototype_app_pang/picker/date_picker_lawsuit_search.dart';

import 'future/report_future.dart';
import 'model/count_offense.dart';
import 'model/count_offense_area.dart';

class ReportMapAreaFragment extends StatefulWidget {
  List<DataTableModelArea> itemsOffenseArea;
  String Title;
  String START_DATE;
  String END_DATE;
  ReportMapAreaFragment({
    Key key,
    @required this.itemsOffenseArea,
    @required this.Title,
    @required this.START_DATE,
    @required this.END_DATE,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<ReportMapAreaFragment> {
  final FocusNode myFocusNodeDepartmentLevel = FocusNode();
  final FocusNode myFocusNodeProductCate = FocusNode();
  final FocusNode myFocusNodeReportDateStart = FocusNode();
  final FocusNode myFocusNodeReportDateEnd = FocusNode();

  TextEditingController editDepartmentLevel = new TextEditingController();
  TextEditingController editProductCate = new TextEditingController();
  TextEditingController editReportDateStart = new TextEditingController();
  TextEditingController editReportDateEnd = new TextEditingController();

  String _currentDateReportStart, _currentDateReportEnd;
  DateTime _dtDateReportStart, _dtDateReportEnd;
  var dateFormatDate;

  DateTime _dtMaxDate;
  List<ItemsCountOffense> _searchResult = [];

  TextStyle textTableStyle = TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textAppbarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleLaw = TextStyle(fontSize: 13.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputSubStyle = TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyleHeader = TextStyle(fontSize: 15.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyleBody = TextStyle(fontSize: 14.0, color: Colors.grey[700], fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  final formatter = new NumberFormat("#,##0.00");

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
    _currentDateReportStart = date;
    _currentDateReportEnd = date;
    _dtDateReportStart = DateTime.now();
    _dtDateReportEnd = DateTime.now();

    _dtMaxDate = DateTime.now();
  }

  CupertinoAlertDialog _cupertinoSearchEmpty(mContext) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            "ไม่พบข้อมูล.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
                /*editDepartmentLevel.clear();
                editProductCate.clear();
                editReportDateStart.clear();
                editReportDateEnd.clear();*/
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void _showSearchEmptyAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoSearchEmpty(context);
      },
    );
  }

  String first_day, last_day;
  //on show dialog
  Future<bool> onLoadAction() async {
    final fmt = new DateFormat('yyyy-MM-dd');
    final fmt_1 = new DateFormat('yyyy');
    first_day = fmt.format(_dtDateReportStart).toString();
    last_day = fmt.format(_dtDateReportEnd).toString();
    //last_day = fmt_1.format(DateTime.now()).toString()+"-12-31";

    Map map = {"LAWSUIT_DATE_FROM": first_day, "LAWSUIT_DATE_TO": last_day};

    await new ReportFuture().apiRequestCountOffenseOfZoneByTime(map).then((onValue) {
      _searchResult = onValue;
      print(onValue.length);
    });
    setState(() {});
    return true;
  }

  onSearchTextSubmitted(mContext) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadAction();
    Navigator.pop(context);
    if (_searchResult.length == 0) {
      _showSearchEmptyAlertDialog(mContext);
    } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReportMainFromSearchScreenFragment(
                  START_DATE: first_day,
                  END_DATE: last_day,
                )),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    editReportDateStart.dispose();
    editReportDateEnd.dispose();
    editProductCate.dispose();
    editDepartmentLevel.dispose();
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;

    final fmt_1 = new DateFormat('yyyy');

    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
              top: BorderSide(color: Colors.grey[300], width: 1.0),
              //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        width: size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
            width: Width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 22),
                  child: Text(
                    'รายงานจำนวนคดี (' + DateFormat("dd").format(DateTime.parse(widget.START_DATE)) + ' ม.ค. - ' + DateFormat("dd").format(DateTime.parse(widget.END_DATE)) + ' ธ.ค. ' + (int.parse(fmt_1.format(DateTime.now())) + 543).toString().substring(2) + ")",
                    style: textLabelStyle,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: paddingInputBox,
                        child: Text(
                          'ระดับ ทั่วประเทศ',
                          style: textInputSubStyle,
                        ),
                      ),
                      /* Container(
                    padding: paddingInputBox,
                    child: Text('หมวดของกลาง สุรา',
                      style: textInputSubStyle,),
                  ),*/
                    ],
                  ),
                ),
                _buildContentData(),
                Container(
                    padding: EdgeInsets.only(bottom: 22.0, top: 22.0),
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: new Table(
                          border: new TableBorder(horizontalInside: new BorderSide(color: Colors.grey[200], width: 0.5)),
                          columnWidths: new Map.from({
                            0: new FixedColumnWidth(150.0), //สรรพสามิต
                            1: new FixedColumnWidth(100.0), //จำนวนคกี
                            2: new FixedColumnWidth(150.0), //เปรียบเทียบปรับ
                            3: new FixedColumnWidth(100.0), //ศาลปรับ
                            4: new FixedColumnWidth(145.0), //พนักงานสอบสวน
                            5: new FixedColumnWidth(120.0), //ค่าปรับนวม
                            6: new FixedColumnWidth(145.0), //เงินสินบน(รวม)
                            7: new FixedColumnWidth(145.0), //เงินางวัล(รวม)
                            8: new FixedColumnWidth(145.0), //เงินส่งคลัง(รวม)
                          }),
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: _rows(),
                        )))
              ],
            ),
          ),
        ));
  }

  Widget _buildContentData() {
    Widget _content;
    switch (widget.Title.trim()) {
      case "สสภ.1":
        _content = _buildmapS1();
        break;
      case "สสภ.2":
        _content = _buildmapS2();
        break;
      case "สสภ.3":
        _content = _buildmapS3();
        break;
      case "สสภ.4":
        _content = _buildmapS4();
        break;
      case "สสภ.5":
        _content = _buildmapS5();
        break;
      case "สสภ.6":
        _content = _buildmapS6();
        break;
      case "สสภ.7":
        _content = _buildmapS7();
        break;
      case "สสภ.8":
        _content = _buildmapS8();
        break;
      case "สสภ.9":
        _content = _buildmapS9();
        break;
      case "สสภ.10":
        _content = _buildmapS10();
        break;
      default:
        _content = Container();
    }
    return _content;
  }

  List<TableRow> _rows() {
    List<TableRow> row = [];

    //add header
    row.add(
      new TableRow(children: <Widget>[
        Container(
          child: Text(
            'สรรพสามิต',
            style: textLabelStyleHeader,
          ),
        ),
        Container(
          child: Text(
            'จำนวนคดี',
            style: textLabelStyleHeader,
          ),
        ),
        Container(
          child: Text(
            'ค่าปรับเปรียบเทียบ',
            style: textLabelStyleHeader,
          ),
        ),
        Container(
          child: Text(
            'ศาลปรับ',
            style: textLabelStyleHeader,
          ),
        ),
        Container(
          child: Text(
            'พนักงานสอบสวน',
            style: textLabelStyleHeader,
          ),
        ),
        Container(
          child: Text(
            'ค่าปรับรวม',
            style: textLabelStyleHeader,
          ),
        ),
        Container(
          child: Text(
            'เงินสินบน(รวม)',
            style: textLabelStyleHeader,
          ),
        ),
        Container(
          child: Text(
            'เงินรางวัล(รวม)',
            style: textLabelStyleHeader,
          ),
        ),
        Container(
          child: Text(
            'เงินส่งคลัง(รวม)',
            style: textLabelStyleHeader,
          ),
        ),
      ]),
    );

    //add body
    widget.itemsOffenseArea.forEach((item) {
      row.add(new TableRow(
        children: <Widget>[
          Container(
            padding: paddingInputBox,
            child: Text(
              item.OFFNAME,
              style: textLabelStyleBody,
            ),
          ),
          Container(
            padding: paddingInputBox,
            child: Text(
              item.LAWSUIT_AMOUNT.toString(),
              style: textLabelStyleBody,
            ),
          ),
          Container(
            padding: paddingInputBox,
            child: Text(
              formatter.format(item.PAYMENT_FINE).toString(),
              style: textLabelStyleBody,
            ),
          ),
          Container(
            padding: paddingInputBox,
            child: Text(
              formatter.format(item.FINE).toString(),
              style: textLabelStyleBody,
            ),
          ),
          Container(
            padding: paddingInputBox,
            child: Text(
              formatter.format(item.FINE_ESTIMATE).toString(),
              style: textLabelStyleBody,
            ),
          ),
          Container(
            padding: paddingInputBox,
            child: Text(
              formatter.format(0.00).toString(),
              style: textLabelStyleBody,
            ),
          ),
          Container(
            padding: paddingInputBox,
            child: Text(
              formatter.format(item.BRIBE_MONEY).toString(),
              style: textLabelStyleBody,
            ),
          ),
          Container(
            padding: paddingInputBox,
            child: Text(
              formatter.format(item.REWARD_MONEY).toString(),
              style: textLabelStyleBody,
            ),
          ),
          Container(
            padding: paddingInputBox,
            child: Text(
              formatter.format(item.TREASURY_MONEY).toString(),
              style: textLabelStyleBody,
            ),
          ),
        ],
      ));
    });
    return row;
  }

  //***********************************************ภาค1********************************************************************** */
  Widget _buildmapS1() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/map/S1_1.png',
              ),
              padding: EdgeInsets.only(top: 22.0),
            ),
            //ชัยนาท
            Container(
                padding: EdgeInsets.only(left: 15, right: 20, top: 120),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[0].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //สิงห์บุรี
                padding: EdgeInsets.only(left: 90, right: 20, bottom: 50, top: 150),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[1].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ลพบุรี
                padding: EdgeInsets.only(left: 200, right: 20, bottom: 80, top: 130),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[2].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //สระบุรี
                padding: EdgeInsets.only(left: 255, right: 20, bottom: 80, top: 220),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[3].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //อ่างทอง
                padding: EdgeInsets.only(left: 80, right: 20, bottom: 80, top: 210),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[4].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //พระนครศรีอยุธยา1
                padding: EdgeInsets.only(left: 160, right: 20, bottom: 80, top: 250),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[5].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //พระนครศรีอยุธยา2
                padding: EdgeInsets.only(left: 60, right: 20, bottom: 80, top: 270),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[6].LAWSUIT_AMOUNT.toString() + "คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //นนทบุรี
                padding: EdgeInsets.only(left: 130, right: 20, bottom: 80, top: 355),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[7].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ปทุมธานี1
                padding: EdgeInsets.only(left: 200, right: 20, bottom: 80, top: 315),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[8].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ปทุมธานี2
                padding: EdgeInsets.only(left: 80, right: 20, bottom: 80, top: 320),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[9].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
          ],
        ),
      ),
    ]));
  }

  //***********************************************ภาค2********************************************************************** */

  Widget _buildmapS2() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/map/S2_1.png',
              ),
              padding: EdgeInsets.only(top: 22.0),
            ),
            //นครนายก
            Container(
                padding: EdgeInsets.only(left: 35, right: 20, top: 70),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[0].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //ปราจีนบุรี
                padding: EdgeInsets.only(left: 150, right: 20, bottom: 50, top: 85),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[1].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //สระแก้ว
                padding: EdgeInsets.only(left: 230, right: 20, bottom: 80, top: 120),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[2].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //สมุทรปราการ1
                padding: EdgeInsets.only(left: 0, right: 20, bottom: 80, top: 100),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[3].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //สมุทรปราการ2
                padding: EdgeInsets.only(left: 0, right: 20, bottom: 80, top: 160),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[4].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ฉะเชิงเทรา
                padding: EdgeInsets.only(left: 150, right: 20, bottom: 80, top: 142),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[5].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ชลบุรี1
                padding: EdgeInsets.only(left: 90, right: 20, bottom: 80, top: 160),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[6].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ชลบุรี2
                padding: EdgeInsets.only(left: 10, right: 20, bottom: 80, top: 250),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[7].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ระยอง1
                padding: EdgeInsets.only(left: 150, right: 20, bottom: 80, top: 255),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[8].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ระยอง2
                padding: EdgeInsets.only(left: 90, right: 20, bottom: 80, top: 210),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[9].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //จันทบุรี
                padding: EdgeInsets.only(left: 230, right: 20, bottom: 80, top: 240),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[10].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ตราด
                padding: EdgeInsets.only(left: 255, right: 20, bottom: 80, top: 315),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[11].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
          ],
        ),
      ),
    ]));
  }

  //***********************************************ภาค3********************************************************************** */

  Widget _buildmapS3() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 22),
              child: Image.asset(
                'assets/images/map/S3_1.png',
              ),
            ),
            //ชัยภูมิ
            Container(
                padding: EdgeInsets.only(left: 15, right: 20, top: 90),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[0].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //นครราชสีมา
                padding: EdgeInsets.only(left: 30, right: 20, bottom: 50, top: 170),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[1].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //บุรีรัมย์
                padding: EdgeInsets.only(left: 100, right: 20, bottom: 80, top: 190),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[2].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //สุรินทร์
                padding: EdgeInsets.only(left: 160, right: 20, bottom: 80, top: 140),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[3].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ร้อยเอ็ด
                padding: EdgeInsets.only(left: 160, right: 20, bottom: 80, top: 100),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[4].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //ยโสธร
                padding: EdgeInsets.only(left: 220, right: 20, bottom: 80, top: 42),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[5].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //อำนาจเจริญ
                padding: EdgeInsets.only(left: 260, right: 20, bottom: 80, top: 100),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[6].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //อุบลราชธานี
                padding: EdgeInsets.only(left: 255, right: 20, bottom: 80, top: 120),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[7].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //ศรีสะเกษ
                padding: EdgeInsets.only(left: 220, right: 20, bottom: 80, top: 180),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[8].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
          ],
        ),
      ),
    ]));
  }

  //***********************************************ภาค4********************************************************************** */

  Widget _buildmapS4() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 22),
              child: Image.asset(
                'assets/images/map/S4_1.png',
              ),
            ),
            //เลย
            Container(
                padding: EdgeInsets.only(left: 25, right: 20, top: 75),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[0].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //หนองบัวลำภู
                padding: EdgeInsets.only(left: 100, right: 20, bottom: 50, top: 145),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[1].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //บึงกาฬ
                padding: EdgeInsets.only(left: 210, right: 20, bottom: 80, top: 15),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[2].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //หนองคาย
                padding: EdgeInsets.only(left: 120, right: 20, bottom: 80, top: 40),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[3].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ขอนแก่น
                padding: EdgeInsets.only(left: 110, right: 20, bottom: 80, top: 190),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[4].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //อุดรธานี
                padding: EdgeInsets.only(left: 130, right: 20, bottom: 80, top: 85),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[5].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //มหาสารคาม
                padding: EdgeInsets.only(left: 180, right: 20, bottom: 80, top: 240),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[6].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //กาฬสินธิ์
                padding: EdgeInsets.only(left: 200, right: 20, bottom: 80, top: 140),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[7].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //มุกดาหาร
                padding: EdgeInsets.only(left: 250, right: 20, bottom: 80, top: 180),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[8].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //นครพนม
                padding: EdgeInsets.only(left: 240, right: 20, bottom: 80, top: 70),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[9].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //สกลนคร
                padding: EdgeInsets.only(left: 220, right: 20, bottom: 80, top: 120),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(widget.itemsOffenseArea[10].LAWSUIT_AMOUNT.toString() + " คดี", style: textInputStyleLaw),
                        onPressed: () {},
                      ),
                    ))),
          ],
        ),
      ),
    ]));
  }

  //***********************************************ภาค5********************************************************************** */

  Widget _buildmapS5() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/map/S5_1.png',
              ),
              padding: EdgeInsets.only(top: 22.0),
            ),
            //แม่ฮ่องสอน
            Container(
                padding: EdgeInsets.only(left: 25, right: 20, top: 100),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[0].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //เชียงใหม่
                padding: EdgeInsets.only(left: 75, right: 20, bottom: 50, top: 180),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[1].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //เชียงราย
                padding: EdgeInsets.only(left: 200, right: 20, bottom: 80, top: 45),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(widget.itemsOffenseArea[2].LAWSUIT_AMOUNT.toString() + " คดี", style: textInputStyleLaw),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //พะเยา
                padding: EdgeInsets.only(left: 210, right: 20, bottom: 80, top: 95),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(widget.itemsOffenseArea[3].LAWSUIT_AMOUNT.toString() + " คดี", style: textInputStyleLaw),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //ลำพูน
                padding: EdgeInsets.only(left: 90, right: 20, bottom: 80, top: 220),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(widget.itemsOffenseArea[4].LAWSUIT_AMOUNT.toString() + " คดี", style: textInputStyleLaw),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //ลำปาง
                padding: EdgeInsets.only(left: 170, right: 20, bottom: 80, top: 155),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(widget.itemsOffenseArea[5].LAWSUIT_AMOUNT.toString() + " คดี", style: textInputStyleLaw),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //น่าน
                padding: EdgeInsets.only(left: 250, right: 20, bottom: 80, top: 180),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(widget.itemsOffenseArea[6].LAWSUIT_AMOUNT.toString() + " คดี", style: textInputStyleLaw),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //แพร่
                padding: EdgeInsets.only(left: 210, right: 20, bottom: 80, top: 200),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[7].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //อุตรดิตถ์
                padding: EdgeInsets.only(left: 210, right: 20, bottom: 80, top: 270),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[8].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
          ],
        ),
      ),
    ]));
  }

//***********************************************ภาค6********************************************************************** */

  Widget _buildmapS6() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/map/S6_1.png',
              ),
              padding: EdgeInsets.only(top: 22.0),
            ),
            //ตาก
            Container(
                padding: EdgeInsets.only(left: 35, right: 20, top: 120),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[0].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //สุโขทัย
                padding: EdgeInsets.only(left: 130, right: 20, bottom: 50, top: 55),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[1].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //พิษณุโลก
                padding: EdgeInsets.only(left: 230, right: 20, bottom: 80, top: 75),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[2].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //เพชรบูรณ์
                padding: EdgeInsets.only(left: 240, right: 20, bottom: 80, top: 160),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[3].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //กำแพงเพชร
                padding: EdgeInsets.only(left: 110, right: 20, bottom: 80, top: 135),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[4].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //อุทัยธานี
                padding: EdgeInsets.only(left: 100, right: 20, bottom: 80, top: 220),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[5].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //พิจิตร
                padding: EdgeInsets.only(left: 180, right: 20, bottom: 80, top: 138),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[6].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
            Container(
                //นครสวรรค์
                padding: EdgeInsets.only(left: 185, right: 20, bottom: 80, top: 190),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[7].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
          ],
        ),
      ),
    ]));
  }

  //***********************************************ภาค7********************************************************************** */

  Widget _buildmapS7() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/map/S7_1.png',
              ),
              padding: EdgeInsets.only(top: 22.0),
            ),
            //กาญจนบุรี
            Container(
                padding: EdgeInsets.only(left: 55, right: 20, top: 130),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[0].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //สุพรรณบุรี
                padding: EdgeInsets.only(left: 240, right: 20, bottom: 50, top: 170),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[1].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //นครปฐม1
                padding: EdgeInsets.only(left: 190, right: 20, bottom: 80, top: 225),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[2].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //นครปฐม2
                padding: EdgeInsets.only(left: 240, right: 20, bottom: 80, top: 245),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[3].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ราชบุรี
                padding: EdgeInsets.only(left: 130, right: 20, bottom: 80, top: 290),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[4].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //สมุทรสาคร
                padding: EdgeInsets.only(left: 235, right: 20, bottom: 80, top: 280),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[5].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //สมุทรสงคราม
                padding: EdgeInsets.only(left: 240, right: 20, bottom: 80, top: 320),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[6].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //เพชรบุรี
                padding: EdgeInsets.only(left: 170, right: 20, bottom: 80, top: 370),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[7].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ประจวบคีรีขันธ์
                padding: EdgeInsets.only(left: 190, right: 20, bottom: 80, top: 450),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[8].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
          ],
        ),
      ),
    ]));
  }

  //***********************************************ภาค8********************************************************************** */

  Widget _buildmapS8() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/map/S8_1.png',
              ),
              padding: EdgeInsets.only(top: 22.0),
            ),
            //ชุมพร
            Container(
                padding: EdgeInsets.only(left: 145, right: 20, top: 90),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[0].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ระนอง
                padding: EdgeInsets.only(left: 50, right: 20, bottom: 50, top: 180),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[1].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //สุราษฏ์ธานี
                padding: EdgeInsets.only(left: 120, right: 20, bottom: 80, top: 310),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[2].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //พังงา
                padding: EdgeInsets.only(left: 40, right: 20, bottom: 80, top: 370),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[3].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //กระบี่
                padding: EdgeInsets.only(left: 110, right: 20, bottom: 80, top: 420),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[4].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //นครศรีธรรมราช
                padding: EdgeInsets.only(left: 220, right: 20, bottom: 80, top: 400),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[5].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ภูเก็ต
                padding: EdgeInsets.only(left: 30, right: 20, bottom: 80, top: 450),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[6].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
          ],
        ),
      ),
    ]));
  }

  //***********************************************ภาค9********************************************************************** */

  Widget _buildmapS9() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/map/S9_1.png',
              ),
              padding: EdgeInsets.only(top: 22.0),
            ),
            //ตรัง
            Container(
                padding: EdgeInsets.only(left: 0, right: 20, top: 90),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[0].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //พัทลุง
                padding: EdgeInsets.only(left: 75, right: 20, bottom: 50, top: 75),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[1].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //สตูล
                padding: EdgeInsets.only(left: 10, right: 20, bottom: 80, top: 160),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[2].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //สงขลา
                padding: EdgeInsets.only(left: 120, right: 20, bottom: 80, top: 130),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[3].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ปัตตานี
                padding: EdgeInsets.only(left: 240, right: 20, bottom: 80, top: 150),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[4].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //ยะลา
                padding: EdgeInsets.only(left: 180, right: 20, bottom: 80, top: 225),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[5].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //นราธิวาส
                padding: EdgeInsets.only(left: 240, right: 20, bottom: 80, top: 250),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[6].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
          ],
        ),
      ),
    ]));
  }

  //***********************************************ภาค10********************************************************************** */

  Widget _buildmapS10() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/map/S10_1.png',
              ),
              padding: EdgeInsets.only(top: 22.0),
            ),
            //กทม.1
            Container(
                padding: EdgeInsets.only(left: 30, right: 20, top: 130),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[0].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //กทม.2
                padding: EdgeInsets.only(left: 120, right: 20, bottom: 50, top: 165),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[1].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //กทม.3
                padding: EdgeInsets.only(left: 120, right: 20, bottom: 80, top: 100),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[2].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //กทม.4
                padding: EdgeInsets.only(left: 175, right: 20, bottom: 80, top: 145),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[3].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),

            Container(
                //กทม.5
                padding: EdgeInsets.only(left: 220, right: 20, bottom: 80, top: 65),
                child: SizedBox(
                    width: 70,
                    height: 20,
                    child: Align(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          widget.itemsOffenseArea[4].LAWSUIT_AMOUNT.toString() + " คดี",
                          style: textInputStyleLaw,
                        ),
                        onPressed: () {},
                      ),
                    ))),
          ],
        ),
      ),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              title: new Text(
                widget.Title,
                style: styleTextAppbar,
              ),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context, "Back");
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
                          border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
                      /*child: Column(
                  children: <Widget>[Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_02_00_02_00',
                          style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
                      ),
                    ],
                  ),
                  ],
                )*/
                    ),
                    Expanded(
                      child: new ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: SingleChildScrollView(
                            child: _buildContent(context),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
