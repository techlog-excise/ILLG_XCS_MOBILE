import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_add_service_reg.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_search_face.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_create.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_search.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/server/server.dart';

class TabScreenArrest4Add extends StatefulWidget {
  bool IsNotice;
  ItemsMasterTitleResponse itemsTitle;
  TabScreenArrest4Add({
    Key key,
    @required this.IsNotice,
    @required this.itemsTitle,
  }) : super(key: key);
  @override
  TabScreenArrest4AddState createState() => new TabScreenArrest4AddState();
}

class TabScreenArrest4AddState extends State<TabScreenArrest4Add> {
  List itemLaw = [];
  List<ItemsListArrestLawbreaker> itemLawbreaker = [];
  FaceRecognitionMainResponse itemSearch; //class อยู่ที่ transection_future บรรทัดที่ 664

  //node type1
  final FocusNode myFocusNodeIdentifyNumber = FocusNode();
  final FocusNode myFocusCompanyRegistationNo = FocusNode();
  final FocusNode myFocusPassportNo = FocusNode();
  final FocusNode myFocusNodeNameSus = FocusNode();
  final FocusNode myFocusAgentName = FocusNode();

  final FocusNode myFocusNodeNameFather_1 = FocusNode();
  final FocusNode myFocusNodeNameMother_1 = FocusNode();
  final FocusNode myFocusNodePlace = FocusNode();

  //node type1
  TextEditingController editIdentifyNumber = new TextEditingController();
  TextEditingController editCompanyRegistationNo = new TextEditingController();
  TextEditingController editPassportNo = new TextEditingController();
  TextEditingController editAgentName = new TextEditingController();

  TextEditingController editNameSus = new TextEditingController();
  TextEditingController editFather = new TextEditingController();
  TextEditingController editMother = new TextEditingController();
  TextEditingController editPlace = new TextEditingController();

  //node type2
  final FocusNode myFocusNodeEntityNumber = FocusNode();
  final FocusNode myFocusNodeCompanyName = FocusNode();
  final FocusNode myFocusNodeExciseRegistrationNumber = FocusNode();
  final FocusNode myFocusNodeCompanyNameTitle = FocusNode();
  final FocusNode myFocusNodeCompanyHeadName = FocusNode();
  final FocusNode myFocusNodeNameFather_2 = FocusNode();
  final FocusNode myFocusNodeNameMother_2 = FocusNode();

  //node type2
  TextEditingController editEntityNumber = new TextEditingController();
  TextEditingController editCompanyName = new TextEditingController();
  TextEditingController editExciseRegistrationNumber = new TextEditingController();
  TextEditingController editCompanyNameTitle = new TextEditingController();
  TextEditingController editCompanyHeadName = new TextEditingController();
  TextEditingController editNameFather_2 = new TextEditingController();
  TextEditingController editNameMother_2 = new TextEditingController();

  bool _suspectType1 = false; // Thai
  bool _suspectType2 = false; // Organize
  bool _suspectType3 = false; // Foreigner

  List _itemsData = [];

  Future<File> _imageFile;
  VoidCallback listener;

  TextStyle textSearchByImgStyle = TextStyle(fontSize: 16.0, color: Colors.blue.shade400, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textStyleSelect = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  void _onImageButtonPressed(ImageSource source, mContext) async {
    var image = await ImagePicker.pickImage(source: source);
    //compare image
    var dir = await getTemporaryDirectory();
    List splits = image.path.split("/");
    var targetPath = dir.absolute.path + "/" + splits.last;
    _imageFile = testCompressAndGetFile(image, targetPath);
    setState(() {
      _imageFile.then((f) {
        List splits = f.path.split("/");
        print(splits[splits.length - 1]);
        //_navigateSearchFace(context,_imageFile);

        onSetDataRequest(mContext, f);
      });
      Navigator.pop(mContext);
    });
  }

  void onSetDataRequest(BuildContext mContext, File _file) async {
    String base64Image = base64Encode(_file.absolute.readAsBytesSync());

    Map map = {"DATA_SOURCE": "", "DOCUMENT_ID": "", "DOCUMENT_NAME": "UserUpload.jpg", "DOCUMENT_OLD_NAME": _file.path, "DOCUMENT_TYPE": "3", "FILE_TYPE": "jpg", "FOLDER": "person", "IS_ACTIVE": "1", "REFERENCE_CODE": 0, "CONTENT": base64Image};

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        });
    await onLoadActionSearchFace(map, _file);
    Navigator.pop(context);

    _navigateSearchFace(mContext, _imageFile);
  }

  //on show dialog
  Future<bool> onLoadActionSearchFace(Map map, File image) async {
    itemLaw = [];
    itemLawbreaker = [];
    int user_upd;
    String path_upd;
    List<ItemsListDocument> list_dataset = [];
    await new TransectionFuture().apiRequestDocumentinsAll(map, image).then((onValue) {
      print(onValue.DOCUMENT_ID.toString());
      user_upd = onValue.DOCUMENT_ID;
    });

    map = {
      "DOCUMENT_ID": user_upd,
    };
    await new TransectionFuture().apiRequestFaceRecognition(map).then((onValue) {
      itemSearch = onValue;
    });

    List<int> person_id = [];
    //บุคคลเดียว
    itemSearch.group1.forEach((item) {
      if (int.parse(item.MISTREAT_NO) > 0) {
        person_id.add(int.parse(item.PERSON_ID));
        itemLaw.add(item);
      }
    });
    //บุคคลใกล้เคียง
    itemSearch.group2.forEach((item) {
      if (int.parse(item.MISTREAT_NO) > 0) {
        person_id.add(int.parse(item.PERSON_ID));
        itemLaw.add(item);
      }
    });

    //ตัดบุคคลซ้ำ
    List itemLawGet = [];
    var sampleList = Set.of(person_id).toList();
    if (sampleList.length > 0) {
      sampleList.forEach((f) {
        for (int i = 0; i < itemLaw.length; i++) {
          if (f == int.parse(itemLaw[i].PERSON_ID)) {
            itemLawGet.add(itemLaw[i]);
            break;
          }
        }
      });
      itemLaw = itemLawGet;
    }

    itemLaw.forEach((item) {
      itemLawbreaker.add(new ItemsListArrestLawbreaker(
          PERSON_ID: int.parse(item.PERSON_ID),
          PERSON_TYPE: int.parse(item.PERSON_TYPE),
          ENTITY_TYPE: int.parse(item.ENTITY_TYPE),
          ID_CARD: item.ID_CARD,
          PASSPORT_NO: item.PASSPORT_NO,
          COMPANY_REGISTRATION_NO: item.COMPANY_REGISTRATION_NO,
          COMPANY_NAME: item.COMPANY_NAME,
          TITLE_NAME_TH: item.TITLE_NAME_TH,
          TITLE_NAME_EN: item.TITLE_NAME_EN,
          TITLE_SHORT_NAME_TH: item.TITLE_SHORT_NAME_TH,
          TITLE_SHORT_NAME_EN: item.TITLE_SHORT_NAME_EN,
          FIRST_NAME: item.FIRST_NAME,
          MIDDLE_NAME: item.MIDDLE_NAME,
          LAST_NAME: item.LAST_NAME,
          OTHER_NAME: item.OTHER_NAME,
          MISTREAT_NO: int.parse(item.MISTREAT_NO),
          TITLE_ID: int.parse(item.TITLE_ID),
          IsCheck: item.IsCheck,
          IsCreate: item.IsCreate,
          IsCheckOffence: item.IsCheckOffence,
          INDEX: item.INDEX,
          REF_CODE: int.parse(item.DOCUMENT_ID)));
    });

    //Delete Image UserUpload
    /*map = {"DOCUMENT_ID": user_upd};
    await new TransectionFuture().apiRequestDocumentupdDelete(map).then((onValue) {
      print(onValue.Msg);
    });*/

    /*//map docID
    map = {
      "DOCUMENT_TYPE": 3,
      "REFERENCE_CODE": "0",
    };
    await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
      if(onValue.length>0){
        onValue.forEach((itm){
          if(itm.DOCUMENT_ID == user_upd){
            path_upd = itm.FILE_PATH;
          }
        });
      }
    });



    map = {"TEXT_SEARCH":""};
    await new TransectionFuture().apiRequestGetAllDocument(map).then((onValue) {
      List<ItemsListDocument> items = [];
      onValue.forEach((f){
        if(f.IS_ACTIVE!=0){
          items.add(f);
        }
      });
      list_dataset = items;
    });

    List<int>person_id = [];
    List<SortFaceX> ItemsDataFaceGet=[];
    List<SortFaceX> ItemsDataFaceSet=[];
    List<Map> mapDataSets = [];
    for(int i = 0;i<list_dataset.length;i++){
      if(int.parse(list_dataset[i].REFERENCE_CODE)!=0){
        */ /*await new TransectionFuture().apiRequestCompareFaceX(
            new Server().IPAddress+"/getImage.html/"+user_upd.toString(),
            new Server().IPAddress+"/getImage.html/"+list_dataset[i].DOCUMENT_ID.toString()
        )*/ /*
        String _result1 = list_dataset[i].FILE_PATH.replaceAll(r'\', r'\\');
        _result1 = _result1.replaceAll(' ', '');

        mapDataSets.add({
          "DocumentID": list_dataset[i].DOCUMENT_ID,
          "img": _result1
        });
      }
    }

    String _result2 = path_upd.replaceAll(r'\', r'\\');
    map = {
      "dataset": mapDataSets,
      "userUpload": {
        "DocumentID": user_upd,
        "img": _result2
      }
    };

    List<FaceXResponse> _itemRespFace = [];
    await new TransectionFuture().apiRequestFaceRecognition(map).then((onValue) {
      */ /*if(onValue.confidence!=null){
            //standard 0.75
            if(double.parse(onValue.confidence)>0.60){
              ItemsDataFaceGet.add(new SortFaceX(int.parse(list_dataset[i].REFERENCE_CODE),double.parse(onValue.confidence)));
              person_id.add(int.parse(list_dataset[i].REFERENCE_CODE));
            }
          }*/ /*
      _itemRespFace = onValue;
    });

    for(int i = 0;i<_itemRespFace.length;i++){
      if(_itemRespFace[i].IS_PERSON){
        ItemsDataFaceGet.add(new SortFaceX(int.parse(list_dataset[i].REFERENCE_CODE)));
        person_id.add(int.parse(list_dataset[i].REFERENCE_CODE));
      }
    }

    var sampleList = Set.of(person_id).toList();
    print(sampleList);
    if(sampleList.length>0){
      sampleList.forEach((f){
        for(int i=0;i<ItemsDataFaceGet.length;i++){
          */ /*if(f==ItemsDataFaceGet[i].PERSON_ID){
            ItemsDataFaceSet.add(new SortFaceX(ItemsDataFaceGet[i].PERSON_ID, ItemsDataFaceGet[i].CONFIDENCE));
            break;
          }*/ /*
          if(f==ItemsDataFaceGet[i].PERSON_ID){
            ItemsDataFaceSet.add(new SortFaceX(ItemsDataFaceGet[i].PERSON_ID));
            break;
          }
        }
      });
    }

    for(int i=0;i<ItemsDataFaceSet.length;i++){
      map={
        "TEXT_SEARCH" : "",
        "PERSON_ID": ItemsDataFaceSet[i].PERSON_ID
      };
      await new ArrestFutureMaster().apiRequestMasPersongetByCon(map).then((onValue) {
        if(onValue.RESPONSE_DATA.length>0){
          if(onValue.RESPONSE_DATA.first.MISTREAT_NO>0){
            itemSearch.add(onValue.RESPONSE_DATA.first);
          }
        }
      });
    }


    for(int i=0;i<itemSearch.length;i++){
      Map map = {
        "DOCUMENT_TYPE": 3,
        "REFERENCE_CODE": itemSearch[i].PERSON_ID,
      };
      await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
        if(onValue.length>0){
          itemSearch[i].REF_CODE = onValue.last.DOCUMENT_ID;
        }
      });
    }

    map = {"DOCUMENT_ID": user_upd};
    await new TransectionFuture().apiRequestDocumentupdDelete(map).then((onValue) {
      print(onValue.Msg);
    });*/

    setState(() {});
    return true;
  }

  bool checkID(PID) {
    if (PID.length != 13) return false;
    int sum = 0;
    for (int i = 0; i < 12; i++) {
      sum += int.parse(PID[i]) * (13 - i);
    }
    if ((11 - (sum % 11)) % 10 == int.parse(PID[12])) return true;
    return false;
  }

  _navigateSearchFace(BuildContext mContext, _imageFile) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (mContext) => TabScreenArrest4SearchFace(
                IsNotice: widget.IsNotice,
                ImageFile: _imageFile,
                ItemsPerson: itemLawbreaker,
                itemsTitle: widget.itemsTitle,
              )),
    );
    if (result.toString() != "back") {
      _itemsData = result;
      Navigator.pop(context, result);
    }
  }

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    _suspectType1 = true;
    //_nationalityType1 = true;

    listener = () {
      setState(() {});
    };
  }

  @override
  void dispose() {
    super.dispose();
    //node type1
    editIdentifyNumber.dispose();
    editCompanyRegistationNo.dispose();
    editPassportNo.dispose();
    editAgentName.dispose();
    editNameSus.dispose();
    editPlace.dispose();

    //node type2
    editEntityNumber.dispose();
    editCompanyName.dispose();
    editExciseRegistrationNumber.dispose();
    editCompanyNameTitle.dispose();
    editCompanyHeadName.dispose();
    editNameMother_2.dispose();
    editNameFather_2.dispose();
  }

  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(bottom: MediaQuery.of(context).viewInsets.bottom, right: 0.0, left: 0.0, child: InputDoneView());
    });

    overlayState.insert(overlayEntry);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    //EdgeInsets paddingLabelSearchImg = EdgeInsets.only(top: 8.0);
    var size = MediaQuery.of(context).size;

    return Container(
        decoration: BoxDecoration(
            //color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
                //top: BorderSide(color: Colors.grey[300], width: 1.0),
                // bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
        width: size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 4.0, bottom: 12.0, left: 22.0, right: 22.0),
            //width: Width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.IsNotice
                    ? Container(
                        padding: EdgeInsets.all(12),
                      )
                    : Container(
                        //padding: paddingLabelSearchImg,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new ButtonTheme(
                              padding: new EdgeInsets.all(0.0),
                              child: new FlatButton(
                                  onPressed: () {
                                    _showDialogPicker();
                                  },
                                  child: Text(
                                    "ค้นหาด้วยรูปภาพ",
                                    style: textSearchByImgStyle,
                                  )),
                            ),
                          ],
                        ),
                      ),
                Container(
                  //padding: paddingLabel,
                  child: Text(
                    "ประเภทผู้กระทำผิด",
                    style: textLabelStyle,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: size.width / 2.4,
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                _suspectType1 = true;
                                _suspectType2 = false;
                                _suspectType3 = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _suspectType1 ? Color(0xff3b69f3) : Colors.white,
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: _suspectType1
                                      ? Icon(
                                          Icons.check,
                                          size: 25.0,
                                          color: Colors.white,
                                        )
                                      : Container(
                                          height: 25.0,
                                          width: 25.0,
                                          color: Colors.transparent,
                                        )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'คนไทย',
                              style: textStyleSelect,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        width: size.width / 2.4,
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _suspectType1 = false;
                                  _suspectType2 = false;
                                  _suspectType3 = true;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _suspectType3 ? Color(0xff3b69f3) : Colors.white,
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: _suspectType3
                                        ? Icon(
                                            Icons.check,
                                            size: 25.0,
                                            color: Colors.white,
                                          )
                                        : Container(
                                            height: 25.0,
                                            width: 25.0,
                                            color: Colors.transparent,
                                          )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'คนต่างชาติ',
                                style: textStyleSelect,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
                Container(
                    width: size.width / 2.4,
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              _suspectType2 = true;
                              _suspectType1 = false;
                              _suspectType3 = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _suspectType2 ? Color(0xff3b69f3) : Colors.white,
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: _suspectType2
                                    ? Icon(
                                        Icons.check,
                                        size: 25.0,
                                        color: Colors.white,
                                      )
                                    : Container(
                                        height: 25.0,
                                        width: 25.0,
                                        color: Colors.transparent,
                                      )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'ผู้ประกอบการ',
                            style: textStyleSelect,
                          ),
                        )
                      ],
                    )),
                _suspectType1 ? _buildInputType1() : _suspectType2 ? _buildInputType2() : _buildInputType3(),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Card(
                          shape: new RoundedRectangleBorder(side: new BorderSide(color: labelColor, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                          elevation: 0.0,
                          child: Container(
                            width: 80.0,
                            child: MaterialButton(
                              onPressed: () {
                                _navigateSearch(context);
                              },
                              splashColor: Colors.grey,
                              child: Center(
                                child: Text(
                                  "ค้นหา",
                                  style: textLabelStyle,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildInputType1() {
    Widget _buildLine = Container(
      padding: EdgeInsets.only(bottom: 4.0, left: 22.0, right: 22.0),
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "หมายเลขบัตรประชาชน",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(13),
            ],
            focusNode: myFocusNodeIdentifyNumber,
            controller: editIdentifyNumber,
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            widget.IsNotice ? "ชื่อผู้ต้องสงสัย" : "ชื่อผู้ต้องหา",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameSus,
            controller: editNameSus,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "บิดา",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameFather_1,
            controller: editFather,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "มารดา",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameMother_1,
            controller: editMother,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
      ],
    );
  }

  Widget _buildInputType2() {
    var size = MediaQuery.of(context).size;
    //final double Width = (size.width * 80) / 100;
    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      //width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "หมายเลขบัตรประชาชน",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(13),
            ],
            focusNode: myFocusNodeIdentifyNumber,
            controller: editIdentifyNumber,
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "หมายเลขทะเบียนนิติบุคคล",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            //maxLength: 14,
            focusNode: myFocusNodeEntityNumber,
            controller: editEntityNumber,
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "หมายเลขทะเบียนสรรพสามิต",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(17),
            ],
            focusNode: myFocusNodeExciseRegistrationNumber,
            controller: editExciseRegistrationNumber,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ชื่อผู้ประกอบการ",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeCompanyName,
            controller: editCompanyName,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        /*Container(
          padding: paddingLabel,
          child: Text(
            "คำนำหน้าชื่อตัวแทนสถานประกอบการ", style: textLabelStyle,),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValue_2,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue_2 = newValue;
                });
              },
              items: dropdownItems_2
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
          ),
        ),
        _buildLine,*/
        Container(
          padding: paddingLabel,
          child: Text(
            "ชื่อตัวแทน",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameSus,
            controller: editNameSus,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
      ],
    );
  }

  Widget _buildInputType3() {
    Widget _buildLine = Container(
      padding: EdgeInsets.only(bottom: 4.0, left: 22.0, right: 22.0),
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "หมายเลขหนังสือเดินทาง",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusPassportNo,
            controller: editPassportNo,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            widget.IsNotice ? "ชื่อผู้ต้องสงสัย" : "ชื่อผู้ต้องหา",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameSus,
            controller: editNameSus,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
      ],
    );
  }

  Widget _buildButtonImgPicker() {
    var size = MediaQuery.of(context).size;
    Color boxColor = Colors.grey[300];
    Color uploadColor = Color(0xff31517c);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: uploadColor, fontFamily: FontStyles().FontFamily);
    return Container(
      padding: EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Card(
              shape: new RoundedRectangleBorder(side: new BorderSide(color: boxColor, width: 1.5), borderRadius: BorderRadius.circular(42.0)),
              elevation: 0.0,
              child: Container(
                width: size.width / 2,
                child: MaterialButton(
                  onPressed: () {},
                  splashColor: Colors.grey,
                  child: Container(
                      padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.file_upload,
                              size: 32,
                              color: uploadColor,
                            ),
                          ),
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Text(
                              widget.IsNotice ? "แนบรูปผู้ต้องสงสัย" : "แนบรูปผู้ต้องหา",
                              style: textLabelStyle,
                            ),
                          ),
                        ],
                      )),
                ),
              )),
        ],
      ),
    );
  }

  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await new ArrestFuture().apiRequestMasPersongetByConAdv(map).then((onValue) {
      print('onValue: ${onValue.length}');
      List<ItemsListArrestLawbreaker> items = [];
      if (widget.IsNotice) {
        items = onValue;
      } else {
        onValue.forEach((item) {
          if (item.PERSON_TYPE == 2) {
            items.add(item);
          } else {
            if (item.TITLE_SHORT_NAME_TH != null && item.FIRST_NAME != null && item.LAST_NAME != null && item.MISTREAT_NO > 0) {
              items.add(item);
            }
          }
        });
      }
      itemLawbreaker = items;
    });
    setState(() {});
    return true;
  }

  ItemsMasterCountryResponse itemsCountry;
  //on show dialog
  Future<bool> onLoadActionCountryMaster() async {
    Map map_title = {"TEXT_SEARCH": ""};
    Map map_country = {"TEXT_SEARCH": ""};
    await new ArrestFutureMaster().apiRequestMasCountrygetByCon(map_country).then((onValue) {
      itemsCountry = onValue;
    });

    setState(() {});
    return true;
  }

  _navigateCreate(BuildContext mContext) async {
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
                  ItemTitle: widget.itemsTitle,
                  ItemCountry: itemsCountry,
                  IsUpdate: false,
                  ItemsPerson: null,
                  IsNotice: widget.IsNotice,
                  Title: widget.IsNotice ? "สร้างผู้ต้องสงสัย" : "สร้างผู้ต้องหา",
                )),
      );
      if (result.toString() != "back") {
        Navigator.pop(context, result);
      }
    }
  }

  // nav search button
  _navigateSearch(BuildContext mContext) async {
    int ENTITY_TYPE;
    int PERSON_TYPE; // 0 = Thai, 1 = Foreigner, 2 = Oraganize

    if (_suspectType1) {
      // Thai
      ENTITY_TYPE = 0;
      PERSON_TYPE = 0;
    } else if (_suspectType2) {
      // Oraganize
      ENTITY_TYPE = null;
      PERSON_TYPE = 2;
    } else {
      // Foreigner
      ENTITY_TYPE = 0;
      PERSON_TYPE = 1;
    }

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });

    Map map;
    if (!_suspectType2) {
      map = {
        'ENTITY_TYPE': ENTITY_TYPE,
        'PERSON_TYPE': PERSON_TYPE,
        'ID_CARD': editIdentifyNumber.text,
        'COMPANY_REGISTRATION_NO': editCompanyRegistationNo.text,
        'PASSPORT_NO': editPassportNo.text,
        'PERSON_NAME': editNameSus.text,
        'AGENT_NAME': editPassportNo.text,
        'FATHER_NAME': editNameFather_2.text,
        'MOTHER_NAME': editNameMother_2.text,
      };
    } else {
      map = {
        'ENTITY_TYPE': ENTITY_TYPE,
        'PERSON_TYPE': PERSON_TYPE,
        'ID_CARD': editIdentifyNumber.text,
        'COMPANY_REGISTRATION_NO': editEntityNumber.text,
        'PASSPORT_NO': "",
        'PERSON_NAME': editCompanyName.text /*.isNotEmpty
              ?editCompanyName.text
              :editNameSus.text*/
        ,
        'AGENT_NAME': editNameSus.text,
        'FATHER_NAME': "",
        'MOTHER_NAME': "",
      };
    }

    print("Map_search: $map");

    await onLoadAction(map);
    Navigator.pop(context);

    if (itemLawbreaker.length > 0) {
      final result = await Navigator.push(
        mContext,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest4Search(
                  IsNotice: widget.IsNotice,
                  ItemsDataGet: itemLawbreaker,
                  itemsTitle: widget.itemsTitle,
                )),
      );
      if (result.toString() != "back") {
        _itemsData = result;
        Navigator.pop(mContext, result);
      }
    } else {
      if (_suspectType2 && !widget.IsNotice) {
        _showEmptyAlertDialog(mContext, widget.IsNotice ? "ไม่พบข้อมูลผู้ต้องสงสัย" : "ไม่พบข้อมูลผู้ต้องหา, ต้องการค้นหาข้อมูลทะเบียนผู้ประกอบการกรมสรรพสามิตหรือไม่");
      } else {
        new EmptyDialog(mContext, widget.IsNotice ? "ไม่พบข้อมูลผู้ต้องสงสัย" : "ไม่พบข้อมูลผู้ต้องหา");
      }
    }
  }

  _navigat_service_reg(BuildContext mContext) async {
    final result = await Navigator.push(
      mContext,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest4AddServiceReg(
                itemsTitle: widget.itemsTitle,
              )),
    );
    if (result.toString() != "back") {
      _itemsData = result;
      Navigator.pop(mContext, _itemsData);
    }
  }

  CupertinoAlertDialog _cupertinoNetworkError(BuildContext mContext, text) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
    return new CupertinoAlertDialog(
      content: new Padding(
        padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
        child: Text(
          text,
          style: TitleStyle,
        ),
      ),
      actions: <Widget>[
        new CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Text('ยกเลิก', style: ButtonCancelStyle)),
        new CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
              _navigat_service_reg(mContext);
            },
            child: new Text('ตกลง', style: ButtonAcceptStyle)),
      ],
    );
  }

  void _showEmptyAlertDialog(BuildContext mContext, text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoNetworkError(mContext, text);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              title: new Padding(
                padding: EdgeInsets.only(right: 22.0),
                child: new Text(
                  widget.IsNotice ? "ค้นหาผู้ต้องสงสัย" : "ค้นหาผู้ต้องหา",
                  style: styleTextAppbar,
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context, "back");
                  }),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    _navigateCreate(context);
                  },
                  child: Text(
                    "สร้าง",
                    style: styleTextAppbar,
                  ),
                ),
              ],
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
                          color: Colors.grey[200],
                          border: Border(
                            top: BorderSide(color: Colors.grey[300], width: 1.0),
                          )),
                      /*child: Column(
                    children: <Widget>[Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: new Text('ILG60_B_01_00_12_00',
                            style: textStylePageName,),
                        ),
                      ],
                    ),
                    ],
                  )*/
                    ),
                    Expanded(
                      child: new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: SingleChildScrollView(
                          child: _buildContent(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void _showImage(context) {
    _onImageButtonPressed(ImageSource.camera, context);
  }

  void _showDialogPicker() {
    showDialog(context: context, builder: (context) => _onTapImage(context)); // Call the Dialog.
  }

  _onTapImage(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: width / 3,
                  height: height / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                    size: 38.0,
                  ),
                ),
                onTap: () {
                  _showImage(context);
                },
              ),
              GestureDetector(
                child: Container(
                  width: width / 3,
                  height: height / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Icon(
                    Icons.image,
                    color: Colors.blue,
                    size: 38.0,
                  ),
                ),
                onTap: () {
                  _onImageButtonPressed(ImageSource.gallery, context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  //compress file and get file.
  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(file.absolute.path, targetPath, quality: 88, minHeight: 250, minWidth: 250);

    print("A : " + file.lengthSync().toString());
    print("B : " + result.path.toString());

    return result;
  }
}

/*class SortFaceX{
  int PERSON_ID;
  double CONFIDENCE;
  SortFaceX(this.PERSON_ID,this.CONFIDENCE);
}*/
class SortFaceX {
  int PERSON_ID;
  SortFaceX(this.PERSON_ID);
}
