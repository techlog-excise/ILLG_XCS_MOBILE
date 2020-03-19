import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_detail_screen.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/tracking_list_arrest_items.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

import 'model/timeline_list.dart';

class TrackingDetailType2ScreenFragment extends StatefulWidget {
  int Type;
  List Items;
  String Title;
  TrackingDetailType2ScreenFragment({
    Key key,
    @required this.Type,
    @required this.Items,
    @required this.Title,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<TrackingDetailType2ScreenFragment> {
  final FocusNode myFocusNodeSearch = FocusNode();
  TextEditingController editSearch = new TextEditingController();

  String text_action="";

  @override
  void initState() {
    super.initState();

    if(widget.Type==1){
      text_action="รับคดี";
    }else if(widget.Type==2) {
      text_action="คำพิพากษา";
    }else if(widget.Type==3) {
      text_action="พิสูจน์";
    }else if(widget.Type==4) {
      text_action="เปรียบเทียบ";
    }else if(widget.Type==5) {
      text_action="ชำระค่าปรับ";
    }else{
      text_action="";
    }
  }


  @override
  void dispose() {
    super.dispose();
    editSearch.dispose();
  }

  void onActionClick(type){
    print(type);
  }

  Widget _buildContentList(BuildContext context) {
    return timelineModel(TimelinePosition.Left);
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
    lineColor: Color(0xff63d8d9),
      lineWidth: 1,
      itemBuilder: centerTimelineBuilder,
      itemCount: widget.Items.length,
      physics: position == TimelinePosition.Left
          ? ClampingScrollPhysics()
          : BouncingScrollPhysics(),
      position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    Widget content = Container();
    if (widget.Type==1) {
      content = content_arrest(i);
    } else if (widget.Type == 2) {
      content = content_lawsuit(i);
    } else {
      content = content_lawsuit(i);
    }

    return TimelineModel(
        content,
        position:
        i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == widget.Items.length,
        iconBackground: widget.Items.length > 1 ? (i ==
            widget.Items.length - 1
            ? Color(0xfff18488)
            : Color(0xff63d8d9))
            : Color(0xff63d8d9)
    );
  }

  Widget content_arrest(index) {
    return new TaskRow(
      index: index,
      task: widget.Items[index],
      type_list: "arrest",
      color: widget.Items.length > 1 ? (index ==
          widget.Items.length - 1
          ? Color(0xfff18488)
          : Color(0xff63d8d9))
          : Color(0xff63d8d9),
    );
  }

  Widget content_lawsuit(index) {
    return new TaskRow(
      index: index,
      task: widget.Items[index],
      type_list: "lawsuit",
      color: widget.Items.length > 1 ? (index ==
          widget.Items.length - 1
          ? Color(0xfff18488)
          : Color(0xff63d8d9))
          : Color(0xff63d8d9),
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
                ),
                Expanded(
                  child: _buildContentList(context),
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
class TaskRow extends StatefulWidget {
  final ItemsTimeLineList task;
  final index;
  final color;
  final type_list;
  final double dotSize = 28.0;

  const TaskRow({Key key, this.task,this.index,this.color,this.type_list}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    var _state;
    if(type_list=="arrest"){
      _state = new TaskArrestRowState();
    }else if(type_list=="lawsuit"){
      _state = new TaskLawsuitRowState();
    }
    return _state;
  }
}

class TaskArrestRowState extends State<TaskRow> {

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
  TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2),fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 8.0);

  Widget _build_content(){
    var size = MediaQuery
        .of(context)
        .size;
    /*String label_title1, label_title2, label_title3;
    label_title1 = "เลขใบงานจับกุม";
    label_title2 = "วันที่เกิดเหตุ";
    label_title3 = "ผู้ต้องหา";*/


    buildCollapsed() {
      return Row(
        children: <Widget>[
          /*new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 32.0 - widget.dotSize / 2),
            child: new Container(
              height: widget.dotSize,
              width: widget.dotSize,
              decoration: new BoxDecoration(shape: BoxShape.circle, color: widget.color),
            ),
          ),*/
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  widget.task.TimeLineLabelNumber,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.task.TimeLineNumber,
                  style: textInputStyle,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  widget.task.TimeLineLabelDate,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.task.TimeLineDate,
                  style: textInputStyle,),
              ),
            ],
          ),
        ],
      );
    }

    Widget ListLawbreaker(index) {
      List<Widget> _list = [];
      //for (int i = 0; i < widget.task.Detail.length; i++) {
        _list.add(
            Padding(
              padding: paddingInputBox,
              child: Text(
                widget.task.TimeLinePerson.toString(),
                style: textInputStyle,),
            )
        );
      //}

      return Container(
        child: Column(
          children: _list,
        ),
      );
    }

    buildExpanded() {
      return Row(
        children: <Widget>[
          /*new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 32.0 - widget.dotSize / 2),
            child: new Container(
              height: widget.dotSize,
              width: widget.dotSize,
              decoration: new BoxDecoration(shape: BoxShape.circle, color: widget.color),
            ),
          ),*/
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  widget.task.TimeLineLabelNumber,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.task.TimeLineNumber,
                  style: textInputStyle,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  widget.task.TimeLineLabelDate,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.task.TimeLineDate,
                  style: textInputStyle,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  widget.task.TimeLineLabelPerson,
                  style: textLabelStyle,),
              ),
              ListLawbreaker(widget.index),
            ],
          ),
        ],
      );
    }

    return Container(
        padding: EdgeInsets.only(top: 0.0, bottom: 12.0),
        child: Container(
          //key: stickyKey,
          //height: size.height / 3,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border(
                top: BorderSide(color: Colors.grey[300], width: 1.0),
                bottom: BorderSide(
                    color: Colors.grey[300], width: 1.0),
              )
          ),
          child: Container(
            padding: EdgeInsets.only(
                top: 12.0, bottom: 12.0, right: 12.0),
            child: Stack(children: <Widget>[
              ExpandableNotifier(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expandable(
                      collapsed: buildCollapsed(),
                      expanded: buildExpanded(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Builder(
                          builder: (context) {
                            var exp = ExpandableController.of(context);
                            return FlatButton(
                                onPressed: () {
                                  exp.toggle();
                                },
                                child: Text(
                                  exp.expanded ? "ย่อ..." : "ดูเพิ่มเติม...",
                                  style: textStyleLink,
                                )
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
            ),
          ),
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 32.0 - widget.dotSize / 2),
            child: new Container(
              height: widget.dotSize,
              width: widget.dotSize,
              decoration: new BoxDecoration(shape: BoxShape.circle,
                  color: widget.color),
            ),
          ),
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.task.TimeLineNumber,
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  widget.task.TimeLineDate,
                  style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                )
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: new Text(
              widget.task.TimeLineNumber,
              style: new TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
    _build_content();
  }
}
class TaskLawsuitRowState extends State<TaskRow> {

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
  TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2),fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 8.0);

  Widget _build_content() {
    var size = MediaQuery
        .of(context)
        .size;
    /*String label_title1, label_title2, label_title3, label_title4;
    if (widget.task.Type == 2) {
      label_title1 = "เลขรับคำกล่าวโทษ";
      label_title2 = "วันที่รับคำกล่าวโทษ";
      label_title3 = "ผู้ต้องหา";
      label_title4 = "หมายเลขคดีดำ";
    } else if (widget.task.Type == 3) {
      label_title1 = "เลขรับคำกล่าวโทษ";
      label_title2 = "วันที่รับคำกล่าวโทษ";
      label_title3 = "ชื่อผู้ต้องหาคดีส่งฟ้องศาล";
      label_title4 = "ชื่อผู้ต้องหาคดีเปรียบเทียบ";
    } else if (widget.task.Type == 4) {
      label_title1 = "ทะเบียนตรวจพิสูจน์";
      label_title2 = "วันที่พิสูจน์ของกลาง";
      label_title3 = "ชื่อผู้ต้องหาคดีส่งฟ้องศาล";
      label_title4 = "ชื่อผู้ต้องหาคดีเปรียบเทียบ";
    } else if (widget.task.Type == 5) {
      label_title1 = "เลขเปรียบเทียบคดี";
      label_title2 = "วันที่เปรียบเทียบ";
      label_title3 = "ชื่อผู้ต้องหาคดีส่งฟ้องศาล";
      label_title4 = "ชื่อผู้ต้องหาคดีเปรียบเทียบ";
    } else if (widget.task.Type == 6) {
      label_title1 = "เลขที่ใบเสร็จ/เล่มที่ใบเสร็จ";
      label_title2 = "วันที่ชำระค่าปรับ";
      label_title3 = "ชื่อผู้ต้องหาคดีส่งฟ้องศาล";
      label_title4 = "ชื่อผู้ต้องหาคดีเปรียบเทียบ";
    } else if (widget.task.Type == 7) {
      label_title1 = "เลขที่นำส่งเงิน";
      label_title2 = "วันที่นำส่ง";
      label_title3 = "ชื่อผู้ต้องหาคดีส่งฟ้องศาล";
      label_title4 = "ชื่อผู้ต้องหาคดีเปรียบเทียบ";
    }*/


    Widget ListLawbreaker(index) {
      List<Widget> _list = [];
      //for (int i = 0; i < widget.task.Detail.length; i++) {
        _list.add(
            Padding(
              padding: paddingInputBox,
              child: Text(
                widget.task.TimeLinePerson.toString(),
                style: textInputStyle,),
            )
        );
      //}

      return Container(
        child: Column(
          children: _list,
        ),
      );
    }

    buildCollapsed() {
      return Row(
        children: <Widget>[
          /*new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 32.0 - widget.dotSize / 2),
            child: new Container(
              padding: EdgeInsets.all(22.0),
              height: widget.dotSize,
              width: widget.dotSize,
              decoration: new BoxDecoration(shape: BoxShape.circle, color: widget.color),
            ),
          ),*/
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  widget.task.TimeLineLabelNumber,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.task.TimeLineNumber,
                  style: textInputStyle,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  widget.task.TimeLineLabelDate,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.task.TimeLineDate,
                  style: textInputStyle,),
              ),
            ],
          ),
        ],
      );
    }

    buildExpanded() {
      return Row(
        children: <Widget>[
          /*new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 32.0 - widget.dotSize / 2),
            child: new Container(
              padding: EdgeInsets.all(22.0),
              height: widget.dotSize,
              width: widget.dotSize,
              decoration: new BoxDecoration(shape: BoxShape.circle, color: widget.color),
            ),
          ),*/
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  widget.task.TimeLineLabelNumber,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.task.TimeLineNumber,
                  style: textInputStyle,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  widget.task.TimeLineLabelDate,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.task.TimeLineDate,
                  style: textInputStyle,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  widget.task.TimeLineLabelPerson,
                  style: textLabelStyle,),
              ),
              ListLawbreaker(widget.index),
              /*Container(
                padding: paddingLabel,
                child: Text(
                  "label_title4",
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text("widget.task.UndecidedNumber",
                  style: textInputStyle,),
              ),*/
            ],
          ),
        ],
      );
    }
    return Container(
        padding: EdgeInsets.only(top: 0.0, bottom: 2.0),
        child: Container(
          //height: size.height / 3,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: widget.index==0
                  ?Border(
                top: BorderSide(color: Colors.grey[300], width: 1.0),
                bottom: BorderSide(
                    color: Colors.grey[300], width: 1.0),
              )
                  :Border(
                bottom: BorderSide(
                    color: Colors.grey[300], width: 1.0),
              )
          ),
          child: Container(
            padding: EdgeInsets.only(
                top: 12.0, bottom: 12.0, right: 12.0),
            child: Stack(children: <Widget>[
              ExpandableNotifier(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expandable(
                      collapsed: buildCollapsed(),
                      expanded: buildExpanded(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Builder(
                          builder: (context) {
                            var exp = ExpandableController.of(context);
                            return FlatButton(
                                onPressed: () {
                                  exp.toggle();
                                },
                                child: Text(
                                  exp.expanded
                                      ? "ย่อ..."
                                      : "ดูเพิ่มเติม...",
                                  style: textStyleLink,
                                )
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
            ),
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return /*new Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 32.0 - widget.dotSize / 2),
            child: new Container(
              height: widget.dotSize,
              width: widget.dotSize,
              decoration: new BoxDecoration(shape: BoxShape.circle,
                  color: widget.color),
            ),
          ),
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.task.Number,
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  widget.task.Number,
                  style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                )
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: new Text(
              widget.task.Number,
              style: new TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ),
        ],
      ),
    );*/
    _build_content();
  }
}