import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';

class LawsuitSearchDynamicDialog extends StatefulWidget {
  LawsuitSearchDynamicDialog({this.Current,this.MaxDate,this.MinDate});
  final DateTime Current;
  final DateTime MaxDate;
  final DateTime MinDate;
  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}
class _DynamicDialogState extends State<LawsuitSearchDynamicDialog> {
  DateTime Current,MaxDate,MinDate;
  //DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = 'asdasdasd';
  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;
  var dateFormatDate, dateFormatTime;

  String TitleDate;

  @override
  void initState() {
    Current = widget.Current;
    MaxDate=widget.MaxDate;
    MinDate=widget.MinDate;

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');

    _currentDate2 =Current;

    List splits = dateFormatDate.format(_currentDate2).toString().split(" ");
    TitleDate = splits[0] + " " + splits[1] + " พ.ศ. " +
        (int.parse(splits[3]) + 543).toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.black,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));

        setState(() {
          Navigator.pop(context,date);
        });

      },
      weekdayTextStyle: TextStyle(color: Colors.black,fontFamily: FontStyles().FontFamily),
      weekendTextStyle: TextStyle(
          color: Colors.black,fontFamily: FontStyles().FontFamily
      ),
      locale: 'th',
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      //markedDatesMap: _markedDateMap,
      daysHaveCircularBorder: false,
      height: (height*40)/100,
      width: width,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      //markedDateIconMaxShown: 2,
      markedDateMoreShowTotal:
      false,
      // null for not showing hidden events indicator
      showHeader: false,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      dayPadding: 2.0,
      selectedDayButtonColor: Colors.blue,
      selectedDayBorderColor: Colors.blue,
      todayTextStyle: TextStyle(
          color: Colors.blue,fontFamily: FontStyles().FontFamily
      ),
      todayButtonColor: Colors.white,
      selectedDayTextStyle: TextStyle(
          color: Colors.white,fontFamily: FontStyles().FontFamily
      ),
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
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)
            )),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            //padding: EdgeInsets.all(8.0),
            height: (height*50)/100,
            width: (width*100)/100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left:8.0,right: 8.0,top: 4.0,bottom: 4.0
                  ),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                            TitleDate,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                                fontSize: 18.0,fontFamily: FontStyles().FontFamily
                            ),
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
                                Icons.keyboard_arrow_down, size: 30.0,
                                color: Colors.black54,)
                          ),
                          onTap: () {
                            setState(() {
                              _currentDate2 =
                                  _currentDate2.subtract(
                                      Duration(days: 30));
                              _currentMonth =
                                  dateFormatDate.format(_currentDate2);
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
                              child: Icon(
                                  Icons.keyboard_arrow_up, size: 30.0,
                                  color: Colors.black54)
                          ),
                          onTap: () {
                            setState(() {
                              _currentDate2 =
                                  _currentDate2.add(Duration(days: 30));
                              _currentMonth =
                                  dateFormatDate.format(_currentDate2);
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
          ),
        ),
      ),
    );
  }
}