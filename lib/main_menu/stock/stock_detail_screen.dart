import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'model/evidence_product_detail_list.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class StockDetailScreenFragment extends StatefulWidget {
  String Title;
  String TitleShort;
  List<ItemsEvidenceProductDetailList> itemsEvidenceProductList;
  StockDetailScreenFragment({
    Key key,
    @required this.Title,
    @required this.TitleShort,
    @required this.itemsEvidenceProductList,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<StockDetailScreenFragment> {
  final FocusNode myFocusNodeSearch = FocusNode();
  TextEditingController editSearch = new TextEditingController();

  var dateFormatDate, dateFormatTime;
  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
  }


  @override
  void dispose() {
    super.dispose();
    editSearch.dispose();
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    TextStyle textInputSubStyle = TextStyle(fontSize: 16.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(
        fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    TextStyle textLabelHeadStyle = TextStyle(
        fontSize: 18.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
    var size = MediaQuery
        .of(context)
        .size;
    return Container(
      child: ListView.builder(
        itemCount: widget.itemsEvidenceProductList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      StockDetailScreenFragment(
                        Items: widget.itemsEvidenceProductList[index],),
                  ));*/
            },
            child: Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: Container(
                  padding: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: index==0
                          ?Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                          :Border(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "เลขทะเบียนบัญชี", style: textLabelStyle,),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Icon(Icons.navigate_next),
                              ),
                            ],
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              widget.itemsEvidenceProductList[index]
                                  .EVIDENCE_IN_ITEM_CODE.toString(),
                              style: textInputStyle,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("วันที่"+widget.TitleShort.toString(), style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              _convertDate(widget.itemsEvidenceProductList[index]
                                  .EVIDENCE_IN_DATE).toString()
                                  +" "+_convertTime(widget.itemsEvidenceProductList[index]
                                  .EVIDENCE_IN_DATE).toString(),
                              style: textInputStyle,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("ของกลาง", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              widget.itemsEvidenceProductList[index]
                                  .PRODUCT_NAME.toString(),
                              style: textInputStyle,),
                          ),
                        ],
                      ),
                    ],
                    ),
                  )
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0,
        color: Color(0xff087de1),
        fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      }, child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Text(widget.Title.toString(),
            style: styleTextAppbar,
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
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
                    decoration: BoxDecoration(
                      //color: Colors.grey[200],
                        border: Border(
                          top: BorderSide(color: Colors.grey[300], width: 1.0),
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 8.0),
                              child: new Text('จำนวน ' +
                                  widget.itemsEvidenceProductList.length
                                      .toString() + ' รายการ',
                                  style: textLabelStyle),
                            ),
                          ],
                        ),
                      ],
                    )
                ),
                Expanded(
                  child: _buildContent(context),
                ),
              ],
            ),
          ),
        ],
      ),
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
}