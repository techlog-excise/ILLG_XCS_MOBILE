import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_create.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class TabScreenArrest4Suspect extends StatefulWidget {
  ItemsListArrestPerson ItemsSuspect;
  TabScreenArrest4Suspect({
    Key key,
    @required this.ItemsSuspect,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<TabScreenArrest4Suspect> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ItemsMasterTitleResponse itemsTitle;
  ItemsMasterCountryResponse itemsCountry;
  //on show dialog
  Future<bool> onLoadActionCountryMaster() async {
    Map map_title = {"TEXT_SEARCH": ""};
    await new ArrestFutureMaster().apiRequestMasTitlegetByCon(map_title).then((onValue) {
      itemsTitle = onValue;
    });
    Map map_country = {"TEXT_SEARCH": ""};
    await new ArrestFutureMaster().apiRequestMasCountrygetByCon(map_country).then((onValue) {
      itemsCountry = onValue;
    });

    setState(() {});
    return true;
  }

  _navigateCreaet(BuildContext mContext) async {
    /*final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest4Create(
        ItemTitle: itemsTitle,
        ItemCountry: itemsCountry,
        IsUpdate: false,
        ItemsPerson: null,)),
    );
    Navigator.pop(context, result);*/
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionCountryMaster();
    Navigator.pop(context);

    if (itemsCountry != null) {
      final result = await Navigator.push(
        mContext,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest4Create(
                  ItemTitle: itemsTitle,
                  ItemCountry: itemsCountry,
                  IsUpdate: true,
                  ItemsPerson: widget.ItemsSuspect,
                  Title: widget.ItemsSuspect.TITLE_SHORT_NAME_TH.toString() + widget.ItemsSuspect.FIRST_NAME + " " + widget.ItemsSuspect.LAST_NAME,
                )),
      );
      if (result.toString() != "back") {
        Navigator.pop(context, result);
      }
    }
  }

  Widget _buildContent() {
    var size = MediaQuery.of(context).size;
    TextStyle textStyleLabel = Styles.textStyleLabel;
    TextStyle textStyleData = Styles.textStyleData;
    TextStyle textLabelEditStyle = TextStyle(fontSize: 16.0, color: Colors.red[200], fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
          decoration: BoxDecoration(
              //color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: paddingLabel,
                      child: Text(
                        "ชื่อผู้ต้องหา",
                        style: textStyleLabel,
                      ),
                    ),
                  ),
                  Center(
                      child: InkWell(
                    onTap: () {
                      _navigateCreaet(context);
                    },
                    child: Container(
                        child: Text(
                      "แก้ไข",
                      style: textLabelEditStyle,
                    )),
                  )),
                ],
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsSuspect.TITLE_SHORT_NAME_TH + widget.ItemsSuspect.FIRST_NAME + " " + widget.ItemsSuspect.LAST_NAME,
                  style: textStyleData,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "ประเภทผู้ต้องหา",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsSuspect.PERSON_TYPE == 0 ? "คนไทย" : "ต่างชาติ",
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "ประเภทบุคคล",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsSuspect.ENTITY_TYPE == 0 ? "บุคคลธรรมดา" : "นิติบุคคล",
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "เลขที่บัตรประชาชน",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsSuspect.ID_CARD == null ? "-" : widget.ItemsSuspect.ID_CARD,
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "ที่อยู่",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  widget.ItemsSuspect.ID_CARD == null ? "-" : widget.ItemsSuspect.ID_CARD,
                  style: textStyleData,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
            padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
            child: ListTile(
              onTap: () {
                /*Navigator.of(context)
                    .push(
                    new MaterialPageRoute(
                        builder: (context) => CompareOffenseListScreenFragment(ItemsOffense: widget.ItemsSuspect.Offenses)));*/
              },
              title: Text(
                "จำนวนครั้งที่กระทำผิด",
                style: textStyleLabel,
              ),
              subtitle: Text(widget.ItemsSuspect.MISTREAT_NO.toString() + ' ครั้ง', style: textStyleData),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400], fontFamily: FontStyles().FontFamily, fontSize: 12.0);
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Text(
              "ประวัติผู้ต้องหา",
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
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                //height: 34.0,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )),
                /*child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_01_00_15_00', style: textStylePageName,),
                    )
                  ],
                ),*/
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
