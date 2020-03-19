import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

import 'model/evidence_item.dart';

class SelectDeliveryBookScreenFragment extends StatefulWidget {
  List<ItemsEvidenceInItem> itemsEvidenceItem;
  bool IsUpdate;
  //ItemsArrestResponseGetOffice itemsOffice;
  SelectDeliveryBookScreenFragment({
    Key key,
    @required this.itemsEvidenceItem,
    @required this.IsUpdate,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<SelectDeliveryBookScreenFragment> {
  TabController tabController;

  FocusNode myFocusNodeFineValueDouble= new FocusNode();
  TextEditingController editFineValueDouble = new TextEditingController();
  ExpandableController expController = new ExpandableController();

  TextEditingController editTaxValue= new TextEditingController();

  List<ItemsEvidenceInItem> _itemsInit = [];
  List<ItemsEvidenceInItem> _itemsData = [];
  int _countItem = 0;

  @override
  void initState() {
    super.initState();
    _itemsInit = widget.itemsEvidenceItem;
  }

  String _setItemName(ItemsEvidenceInItem item){
    String name="";
    if(item.PRODUCT_GROUP_NAME!=null){
      name+=item.PRODUCT_GROUP_NAME+" ";
    }
    if(item.PRODUCT_CATEGORY_NAME!=null){
      name+=item.PRODUCT_CATEGORY_NAME+" ";
    }
    if(item.PRODUCT_TYPE_NAME!=null){
      name+=item.PRODUCT_TYPE_NAME+" ";
    }
    if(item.PRODUCT_BRAND_NAME_TH!=null){
      name+=item.PRODUCT_BRAND_NAME_TH+" ";
    }
    return name;
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
                //color: Colors.white,
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
                      child: Text(_itemsInit[index].EVIDENCE_IN_ITEM_CODE, style: textInputStyle,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("ของกลาง", style: textLabelStyle,),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: Text(_setItemName(_itemsInit[index]), style: textInputStyle,),
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

                        if(widget.IsUpdate){
                          for (int i = 0; i < _itemsInit.length; i++) {
                          if (i != index) {
                            _itemsInit[i].IsCkecked = false;
                          }
                        }
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        shape: widget.IsUpdate?BoxShape.circle:BoxShape.rectangle,
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
              _itemsData.add(item);
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
      //backgroundColor: Colors.grey[200],
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
                    //color: Colors.grey[200],
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
                        child: new Text('ILG60_B_05_00_14_00',
                          style: TextStyle(color: Colors.grey[400],fontSize: 12.0,fontFamily: FontStyles().FontFamily),),
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
        ],
      ),
      bottomNavigationBar: _buildBottom(),
    ),
    );
  }
}