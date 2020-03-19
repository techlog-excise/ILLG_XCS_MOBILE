import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';

class ArrestDynamicDialog extends StatefulWidget {
  ArrestDynamicDialog({this.Current, this.MaxDate, this.MinDate});
  final DateTime Current;
  final DateTime MaxDate;
  final DateTime MinDate;
  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<ArrestDynamicDialog> {
  DateTime Current, MaxDate, MinDate;

  //DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = 'asdasdasd';
  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;
  var dateFormatDate, dateFormatTime;

  String TitleDate;

  int _selectedYear = 0, _selectedDay = 0, _selectedMonth = 0;
  var date_now = new DateTime.now();
  var date;
  int date_count;
  List<String> month_init = ["มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม"];
  List<String> month_array = [];
  List<String> day_array = [];
  List<int> year_array = [];
  DateFormat _dateFormat = DateFormat("yyyy");

  @override
  void initState() {
    Current = widget.Current;
    MaxDate = widget.MaxDate;
    MinDate = widget.MinDate;

    //date =  new DateTime(date_now.year,date_now.month,0);
    if (MinDate == null) {
      date = MaxDate;
      _setMonth(0, MaxDate.month);
      _setDay(1, MaxDate.day);
    } else {
      date = MinDate;
      print(MinDate.month.toString() + "," + MaxDate.month.toString());
      _setMonth(MinDate.month, MaxDate.month);
      _setDay(MinDate.day, MaxDate.day);
    }
    date_count = date.day;
    _selectedDay = date_now.day;
    print(int.parse(_dateFormat.format(DateTime.now())) + 543);

    int k = 0;
    for (int i = (date_now.year + 543) - 1; i < (date_now.year + 543) + 1; i++) {
      year_array.add(i);
      if (int.parse(_dateFormat.format(DateTime.now())) + 543 == i) {
        _selectedYear = k;
      }
      k++;
    }
    _selectedMonth = date_now.month - 1;

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');

    _currentDate2 = Current;

    List splits = dateFormatDate.format(_currentDate2).toString().split(" ");
    TitleDate = splits[0] + " " + splits[1] + " พ.ศ. " + (int.parse(splits[3]) + 543).toString();

    super.initState();
  }

  void _setMonth(int start, int end) {
    for (int i = start; i < end; i++) {
      print(month_init[i]);
      month_array.add(month_init[i]);
    }
  }

  void _setDay(int start, int end) {
    for (int i = start; i <= end; i++) {
      print(i);
      day_array.add(i.toString());
      //month_array.add(month_init[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    TextStyle textTitleStyle = TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily, fontWeight: FontWeight.w600);
    TextStyle textDataStyle = TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily, color: Colors.black54);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.black,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));

        setState(() {
          Navigator.pop(context, date);
        });
      },
      weekdayTextStyle: TextStyle(color: Colors.black, fontFamily: FontStyles().FontFamily),
      weekendTextStyle: TextStyle(color: Colors.black, fontFamily: FontStyles().FontFamily),
      locale: 'th',
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      //markedDatesMap: _markedDateMap,
      daysHaveCircularBorder: false,
      height: (height * 40) / 100,
      width: width,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      //markedDateIconMaxShown: 2,
      markedDateMoreShowTotal: false,
      // null for not showing hidden events indicator
      showHeader: false,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      dayPadding: 2.0,
      selectedDayButtonColor: Colors.blue,
      selectedDayBorderColor: Colors.blue,
      todayTextStyle: TextStyle(color: Colors.blue, fontFamily: FontStyles().FontFamily),
      todayButtonColor: Colors.white,
      selectedDayTextStyle: TextStyle(color: Colors.white, fontFamily: FontStyles().FontFamily),
      minSelectedDate: MinDate,
      maxSelectedDate: MaxDate,
//      inactiveDateColor: Colors.black12,
      onCalendarChanged: (DateTime date) {
        setState(() {
          _currentMonth = dateFormatDate.format(date);
        });
        //this.setState(() => _currentMonth = dateFormatDate.format(date));
      },
    );
    return AlertDialog(
      content: Container(
        decoration: ShapeDecoration(color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            //padding: EdgeInsets.all(8.0),
            height: (height * 50) / 100,
            width: (width * 100) / 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        TitleDate,
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: FontStyles().FontFamily),
                      )),
                      Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: GestureDetector(
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.transparent,
                                border: Border.all(color: Colors.black26),
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 30.0,
                                color: Colors.black54,
                              )),
                          onTap: () {
                            setState(() {
                              _currentDate2 = _currentDate2.subtract(Duration(days: 30));
                              _currentMonth = dateFormatDate.format(_currentDate2);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: GestureDetector(
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.transparent,
                                border: Border.all(color: Colors.black26),
                              ),
                              child: Icon(Icons.keyboard_arrow_up, size: 30.0, color: Colors.black54)),
                          onTap: () {
                            setState(() {
                              _currentDate2 = _currentDate2.add(Duration(days: 30));
                              _currentMonth = dateFormatDate.format(_currentDate2);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: _calendarCarouselNoHeader,
                ), //
              ],
            ),
            /*Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: paddingInputBox,
                    child: Text(TitleDate, style: textTitleStyle,),
                  ),
                  Container(
                    padding: paddingInputBox,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('ปี', style: textLabelStyle,),
                        Text('เดือน', style: textLabelStyle,),
                        Text('วัน', style: textLabelStyle,),
                      ],
                    ),
                  ),
                  */ /*Container(
                  height: 216,
                  child: CupertinoDatePicker(
                    minimumYear: date.year,
                    maximumDate: DateTime.now(),
                    minimumDate: MinDate,
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (newDateTime) {
                      setState(() {
                        _currentDate2 = newDateTime;
                        _currentMonth =
                            dateFormatDate.format(_currentDate2);
                      });
                    },
                  ),
                ),*/ /*
                  Container(
                    height: 200.0,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: CupertinoPicker(
                              scrollController:
                              new FixedExtentScrollController(
                                initialItem: _selectedYear,
                              ),
                              itemExtent: 32.0,
                              backgroundColor: Colors.white,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  _selectedYear = index + 1;
                                  print(_selectedYear);
                                  String month = "";
                                  if ((_selectedMonth + 1)
                                      .toString()
                                      .length == 2) {
                                    month = (_selectedMonth + 1).toString();
                                  } else {
                                    month =
                                        "0" + (_selectedMonth + 1).toString();
                                  }
                                  DateTime _dt = DateTime.parse(
                                      (year_array[_selectedYear] - 543)
                                          .toString() + "-" + month + "-" +
                                          _selectedDay.toString());
                                  List splits = dateFormatDate.format(_dt)
                                      .toString()
                                      .split(" ");
                                  TitleDate =
                                      splits[0] + " " + splits[1] + " พ.ศ. " +
                                          (int.parse(splits[3]) + 543)
                                              .toString();
                                });
                              },
                              children: new List<Widget>.generate(
                                  year_array.length,
                                      (int index) {
                                    return new Center(
                                      child: new Text(
                                          '${year_array[index].toString()}',
                                          style: textDataStyle),
                                    );
                                  })),
                        ),
                        Expanded(
                          child: CupertinoPicker(
                              scrollController:
                              new FixedExtentScrollController(
                                initialItem: _selectedMonth,
                              ),
                              itemExtent: 32.0,
                              backgroundColor: Colors.white,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  _selectedMonth = index + 1;
                                  String month = "";
                                  if ((_selectedMonth + 1)
                                      .toString()
                                      .length == 2) {
                                    month = (_selectedMonth + 1).toString();
                                  } else {
                                    month =
                                        "0" + (_selectedMonth + 1).toString();
                                  }
                                  DateTime _dt = DateTime.parse(
                                      (year_array[_selectedYear] - 543)
                                          .toString() + "-" + month + "-" +
                                          (_selectedDay+1).toString());
                                  List splits = dateFormatDate.format(_dt)
                                      .toString()
                                      .split(" ");
                                  TitleDate =
                                      splits[0] + " " + splits[1] + " พ.ศ. " +
                                          (int.parse(splits[3]) + 543)
                                              .toString();
                                });
                              },
                              children: new List<Widget>.generate(
                                  month_array.length,
                                      (int index) {
                                    return new Center(
                                      child: new Text('${month_array[index]}',
                                        style: textDataStyle,),
                                    );
                                  })),
                        ),
                        Expanded(
                          child: CupertinoPicker(
                              scrollController:
                              new FixedExtentScrollController(
                                initialItem: _selectedDay ,
                              ),
                              itemExtent: 32.0,
                              backgroundColor: Colors.white,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  _selectedDay = index;
                                  String month = "";
                                  if ((_selectedMonth+1)
                                      .toString()
                                      .length == 2) {
                                    month = (_selectedMonth+1).toString();
                                  } else {
                                    month = "0" + (_selectedMonth+1).toString();
                                  }
                                  DateTime _dt = DateTime.parse(
                                      (year_array[_selectedYear] - 543)
                                          .toString() + "-" + month + "-" +
                                          (_selectedDay+1).toString());
                                  List splits = dateFormatDate.format(_dt)
                                      .toString()
                                      .split(" ");
                                  TitleDate =
                                      splits[0] + " " + splits[1] + " พ.ศ. " +
                                          (int.parse(splits[3]) + 543)
                                              .toString();
                                });
                              },
                              children: new List<Widget>.generate(day_array.length,
                                      (int index) {
                                    return new Center(
                                      child: new Text(
                                          '${day_array[index]}', style: textDataStyle),
                                    );
                                  })),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Card(
                          shape: new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: labelColor, width: 1.5),
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          elevation: 0.0,
                          child: Container(
                            width: 100.0,
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  String month = "";
                                  if ((_selectedMonth+1)
                                      .toString()
                                      .length == 2) {
                                    month = (_selectedMonth+1).toString();
                                  } else {
                                    month = "0" + (_selectedMonth+1).toString();
                                  }
                                  DateTime _dt = DateTime.parse(
                                      (year_array[_selectedYear] - 543)
                                          .toString() + "-" + month + "-" +
                                          (_selectedDay+1).toString());

                                  _currentDate2 = _dt;
                                  print(_currentDate2.toString());
                                  Navigator.pop(context, _currentDate2);
                                });
                              },
                              splashColor: Colors.grey,
                              child: Center(
                                child: Text("ตกลง", style: textLabelStyle,),),
                            ),
                          )
                      ),
                    ],
                  )
                ],
              )*/
          ),
        ),
      ),
    );
  }
}
