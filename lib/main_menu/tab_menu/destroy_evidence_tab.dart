import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/destroy/destroy_screen.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class DestroyFragment extends StatefulWidget {
  // ItemsPersonInformation ItemsData;
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  DestroyFragment({
    Key key,
    // @required this.ItemsData,
    @required this.ItemsPerson,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<DestroyFragment> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        BackgroundContent(),
        /*IconButton(
                         padding: EdgeInsets.only(left: 370,bottom: 150,top: 20),
            icon: Icon(Icons.notifications,color: Colors.blue,size: 30,),
            onPressed: (){}
            ,
          ),*/
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
                                  builder: (context) => DestroyMainScreenFragment(
                                    ItemsdestroyMain: null,
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
                        builder: (context) => DestroyMainScreenFragment(
                              ItemsdestroyMain: null,
                              IsPreview: false,
                              IsCreate: true,
                              IsUpdate: false,
                              ItemsPerson: widget.ItemsPerson,
                              //ItemsMain: widget.ItemsData,
                            )));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(28.0),
                    child: Image(
                      image: AssetImage("assets/icons/landing/destroy_landing.png"),
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
                child: Text(
                  "สร้างงานทำลายของกลาง",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily),
                ),
              )
            ],
          ),
        ))
      ],
    ));
  }
}
