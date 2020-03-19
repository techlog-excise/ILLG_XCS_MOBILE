import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/find_law/model/item_find_law_response.dart';
import 'package:prototype_app_pang/main_menu/find_law/model/item_masLawGroupSubSection.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

Color labelColor = Color(0xff087de1);
TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
TextStyle textStyleTitle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
TextStyle textInputStyleSub = Styles.textStyleData;

class FindLawScreenResultData extends StatefulWidget {
  ItemsMasLawGroupSubSection ItemsData;
  String Title;
  @override
  FindLawScreenResultData({
    Key key,
    @required this.ItemsData,
    @required this.Title,
  }) : super(key: key);
  _FindLawScreenResultData createState() => new _FindLawScreenResultData();
}

class _FindLawScreenResultData extends State<FindLawScreenResultData> {
  TextEditingController editLawsuit = new TextEditingController();
  TextEditingController editMistake = new TextEditingController();

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  ItemsMasLawGroupSubSection _itemInit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _itemInit = widget.ItemsData;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          widget.Title,
          style: styleTextAppbar,
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, "back");
            }),
      ),
      body: Stack(
        children: <Widget>[
          BackgroundContent(),
          new Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    //color: Colors.grey[200],
                    border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
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
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;
    return Container(
      height: size.height,
      decoration: BoxDecoration(
          //color: Colors.white,
          shape: BoxShape.rectangle,
          border: Border(
            top: BorderSide(color: Colors.grey[300], width: 1.0),
            bottom: BorderSide(color: Colors.grey[300], width: 1.0),
          )),
      width: size.width,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
          width: Width,
          child: _buildInput(),
        ),
      ),
    );
  }

  Widget _buildInput() {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 100) / 100;
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            'บทลงโทษมาตรา',
            style: textStyleTitle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _itemInit.MasLawGroupSubSectionRule.first.MasLawPenalty.first.SECTION_ID.toString(),
            // '101',
            style: textInputStyleSub,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            'อัตราโทษ',
            style: textStyleTitle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _itemInit.MasLawGroupSubSectionRule.first.MasLawPenalty.first.PENALTY_DESC,
            // '101',
            style: textInputStyleSub,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            'อัตราที่กำหนดให้ปรับ',
            style: textStyleTitle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _itemInit.MasLawGroupSubSectionRule.first.MasLawLawGuiltbase.first.FINE == null ? "-" : _itemInit.MasLawGroupSubSectionRule.first.MasLawLawGuiltbase.first.FINE,
            // '101',
            style: textInputStyleSub,
          ),
        ),
      ],
    );
  }
}
