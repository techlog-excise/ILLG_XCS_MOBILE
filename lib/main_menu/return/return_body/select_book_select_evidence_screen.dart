import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_evidence.dart';

class SelectExportBookScreenFragment extends StatefulWidget {
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<SelectExportBookScreenFragment> {
  TabController tabController;

  FocusNode myFocusNodeFineValueDouble= new FocusNode();
  TextEditingController editFineValueDouble = new TextEditingController();
  ExpandableController expController = new ExpandableController();

  TextEditingController editTaxValue= new TextEditingController();

  List<ItemsDestroyEvidence> _itemsInit = [
    new ItemsDestroyEvidence(
        "สุรา",
        "สราแช่",
        "ชนิดเบียร์",
        "4.4",
        "ดีกรี",
        "hoegaarden",
        "",
        "SADLER S PEAKY BLINDER",
        0,
        "ลิตร",
        0,
        "",
        0,
        "",
        false,
        null,
        false,
        new ItemsCheckEvidenceDetailController(
            new ExpandableController(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            "ขวด",
            "ลิตร",
            ['ขวด','ลัง'],
            ['ลิตร'])
    ),
    new ItemsDestroyEvidence(
        "สุรา",
        "สราแช่",
        "ชนิดเบียร์",
        "4.5",
        "ดีกรี",
        "รวงข้าว",
        "",
        "40 Degree",
        0,
        "ลิตร",
        0,
        "",
        0,
        "",
        false,
        null,
        false,
        new ItemsCheckEvidenceDetailController(
            new ExpandableController(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new FocusNode(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            new TextEditingController(),
            "ขวด",
            "ลิตร",
            ['ขวด','ลัง'],
            ['ลิตร'])
    )
  ];
  ItemsDestroyEvidence _itemsData;
  int _countItem = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildSearchResults() {
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor,fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 8.0);
    return ListView.builder(
      itemCount: _itemsInit.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Container(
            padding: EdgeInsets.all(22.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text("เลขทะเบียนบัญชี", style: textLabelStyle,),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: Text("IN00107016200008", style: textInputStyle,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("ของกลาง", style: textLabelStyle,),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: Text(_itemsInit[index].ProductGroup+"/"+_itemsInit[index].ProductType+"/"+_itemsInit[index].MainBrand, style: textInputStyle,),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _itemsInit[index].IsCkecked =
                        !_itemsInit[index].IsCkecked;

                        for (int i = 0; i < _itemsInit.length; i++) {
                          if (i != index) {
                            _itemsInit[i].IsCkecked = false;
                          }
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _itemsInit[index].IsCkecked
                            ? Color(0xff3b69f3)
                            : Colors.white,
                        border: _itemsInit[index].IsCkecked
                            ? Border.all(
                            color: Color(0xff3b69f3), width: 2)
                            : Border.all(
                            color: Colors.grey[400], width: 2),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: _itemsInit[index].IsCkecked
                              ? Icon(
                            Icons.check,
                            size: 18.0,
                            color: Colors.white,
                          )
                              : Container(
                            height: 18.0,
                            width: 18.0,
                            color: Colors.transparent,
                          )
                      ),
                    ),
                  )
                )
              ],
            )
          ),
        );
      },
    );
  }

  Widget _buildBottom() {
    var size = MediaQuery
        .of(context)
        .size;
    TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0,fontFamily: FontStyles().FontFamily);
    bool isCheck = false;
    _countItem = 0;
    _itemsInit.forEach((item) {
      if (item.IsCkecked)
        setState(() {
          isCheck = item.IsCkecked;
          _countItem++;
        });
    });
    return isCheck ? Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {
          _itemsInit.forEach((item) {
            if (item.IsCkecked)
              _itemsData = item;
          });
          Navigator.pop(context, _itemsData);
        },
        child: Center(
          child: Text('เลือก', style: textStyleButton,),
        ),
      ),
    ) : null;
  }

  _navigateCreaet(BuildContext context) async {
    /*final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest5Create(ItemsData: _itemsData,)),
    );
    if(result.toString()!="back"){
      _itemsData = result;
      Navigator.pop(context,result);
    }*/
  }


  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      }, child: Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Text("ค้นหาหนังสือนำส่ง",
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              //height: 34.0,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                /*child: Column(
                  children: <Widget>[Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_10_00_06_00',
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
                child: _buildSearchResults(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottom(),
    ),
    );
  }
}