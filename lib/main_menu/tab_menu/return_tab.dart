import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/auction/auction_screen.dart';
import 'package:prototype_app_pang/main_menu/destroy/destroy_screen.dart';
import 'package:prototype_app_pang/main_menu/return/return_body/return_screen.dart';
import 'package:prototype_app_pang/main_menu/musuim/musuim_screen.dart';
import 'package:prototype_app_pang/main_menu/return/return_body/return_screen.dart';
import 'package:prototype_app_pang/main_menu/transfer/transfer_screen.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class ReturnFragment extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ReturnFragment({
    Key key,
    @required this.ItemsPerson,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<ReturnFragment> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        BackgroundContent(),
        new Center(
            child: new Container(
          padding: EdgeInsets.only(top: size.height / 4.5),
          child: new Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*new SizedBox(
                      height: (size.width*50)/100,
                      width: (size.width*50)/100,
                      child: new IconButton(
                        padding: new EdgeInsets.all(0.0),
                        color: Colors.white,
                        icon: new Icon(
                            Icons.add_circle, color: Color(0xff087de1),
                            size: (size.width*50)/100),
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) => ReturnMainScreenFragment(
                                    ItemsexportMain: null,
                                    IsPreview: false,
                                    IsCreate: true,
                                    IsUpdate: false,
                                    //ItemsMain: widget.ItemsData,
                                  )));
                        },
                      )
                  ),*/
              new SizedBox(
                height: (size.width * 40) / 100,
                width: (size.width * 40) / 100,
                child: new RawMaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => ReturnMainScreenFragment(
                              //ItemsexportMain: null,
                              ItemsPerson: widget.ItemsPerson,
                              IsPreview: false,
                              IsCreate: true,
                              IsUpdate: false,
                              //ItemsMain: widget.ItemsData,
                            )));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(28.0),
                    child: Image(
                      image: AssetImage("assets/icons/landing/return_landing.png"),
                      fit: BoxFit.contain,
                      color: Colors.white,
                    ),
                  ),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Color(0xff087de1),
                  padding: const EdgeInsets.all(12.0),
                ),
              ),
              new Padding(
                  padding: EdgeInsets.only(top: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "สร้างงานคืนของกลาง",
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily),
                      ),
                      Text(
                        "ภายใน / ภายนอก",
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily),
                      ),
                    ],
                  ))
            ],
          ),
        ))
      ],
    ));
  }
}
