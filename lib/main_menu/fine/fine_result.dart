import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/find_law/find_law_screen_result_data.dart';
import 'package:prototype_app_pang/main_menu/find_law/model/item_find_law_response.dart';
import 'package:prototype_app_pang/main_menu/find_law/model/item_masLawGroupSubSection.dart';
import 'package:prototype_app_pang/main_menu/fine/fine_result_data.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

Color labelColor = Color(0xff087de1);
TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
TextStyle textStyleTitle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
TextStyle textInputStyleSub = Styles.textStyleData;

class FineScreenResult extends StatefulWidget {
  List<ItemsFindLawResponse> ItemSearch;
  FineScreenResult({
    Key key,
    @required this.ItemSearch,
  }) : super(key: key);
  @override
  _FineScreenResult createState() => new _FineScreenResult();
}

class _FineScreenResult extends State<FineScreenResult> {
  TextEditingController editLawsuit = new TextEditingController();
  TextEditingController editMistake = new TextEditingController();

  List<ItemsFindLawResponse> _searchResult = [];
  List listGuiltBaseName = [];
  List listSubSection = [];

  List itemSubSection = [];
  List<ItemsMasLawGroupSubSection> _tempItemSubSection = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchResult = widget.ItemSearch;

    for (var i = 0; i < _searchResult.length; i++) {
      List item = [];
      List<ItemsMasLawGroupSubSection> _tempListSubsection;
      String itemSubSectionName = "";

      itemSubSection = _searchResult[i].MasLawGroupSubSection;
      _tempListSubsection = _searchResult[i].MasLawGroupSubSection;
      _tempItemSubSection += _tempListSubsection;

      for (var j = 0; j < itemSubSection.length; j++) {
        itemSubSectionName = itemSubSection[j].SUBSECTION_NAME;
        listSubSection.add(itemSubSectionName);
        item = itemSubSection[j].MasLawGroupSubSectionRule[0].MasLawLawGuiltbase;

        String itemGuiltBaseName = "";
        for (var j = 0; j < item.length; j++) {
          // print('itemGuiltBaseName: ${item[j].GUILTBASE_NAME}');
          itemGuiltBaseName += '- ' + item[j].GUILTBASE_NAME + '\n';
        }
        listGuiltBaseName.add(itemGuiltBaseName);
      }
    }
  }

  _navigateSelection(BuildContext context, String title, ItemsMasLawGroupSubSection item) async {
    // Navigator.pop(context); // ถ้ามีคือการ pop stack ออก 1 หน้า เราก้จะข้ามหน้านี้ไปหน้าค้นหาเลย
    int _tempFineType = 0;
    _tempFineType = item.MasLawGroupSubSectionRule[0].FINE_TYPE;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FineScreenResultData(
          ItemsData: item,
          Title: title,
          FineType: _tempFineType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'ค้นหามาตราฐานความผิด',
            style: styleTextAppbar,
          ),
          centerTitle: true,
          // elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, "back");
              }),
        ),
        body: Stack(
          children: <Widget>[
            BackgroundContent(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _searchResult.length != 0 ? _buildSearchResults() : new Container(),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: listSubSection.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            _navigateSelection(context, 'มาตรา ' + listSubSection[index], _tempItemSubSection[index]);
          },
          child: Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
              padding: EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
              child: buildDataContent(index),
            ),
          ),
        );
      },
    );
  }

  buildDataContent(index) {
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    return Stack(
      children: <Widget>[
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'มาตรา',
                style: textStyleTitle,
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(
                  listSubSection[index],
                  // '101',
                  style: textInputStyleSub,
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'ฐานความผิด',
                style: textStyleTitle,
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(
                  listGuiltBaseName[index],
                  // '...',
                  style: textInputStyleSub,
                ),
              ),
            ],
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[300],
            size: 20.0,
          ),
        ),
      ],
    );
  }
}
