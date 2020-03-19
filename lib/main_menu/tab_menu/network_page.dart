import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/server/server.dart';
import 'package:prototype_app_pang/zan/analysis_recog_search_screen.dart';
import 'package:flutter/cupertino.dart';

Color labelColor = Color(0xff087de1);
TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
TextStyle textappbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
TextStyle textLabelStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
TextStyle textStyleSelect = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

List _itemsData = [];

class NetworkFragment extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<NetworkFragment> {
  Future<File> _imageFile;

  void _showImage(context) {
    _onImageButtonPressed(ImageSource.camera, context);
  }

  void _showDialogPicker() {
    showDialog(context: context, builder: (context) => _onTapImage(context)); // Call the Dialog.
  }

  List itemLaw = [];
  List<ItemsListArrestLawbreaker> itemLawbreaker = [];
  FaceRecognitionMainResponse itemSearch; //class อยู่ที่ transection_future.dart บรรทัดที่ 664

  //on show dialog
  Future<bool> onLoadAction(Map map, File images) async {
    itemLaw = [];
    int user_upd;
    String path_upd;
    List<ItemsListDocument> list_dataset = [];
    await new TransectionFuture().apiRequestDocumentinsAll(map, images).then((onValue) {
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
        ItemsDataFaceGet.add(new SortFaceX(int.parse(list_dataset[i].REFERENCE_CODE),_itemRespFace[i].Confidence));
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
            ItemsDataFaceSet.add(new SortFaceX(ItemsDataFaceGet[i].PERSON_ID,ItemsDataFaceGet[i].CONFIDENCE));
            break;
          }
        }
      });
    }

    ItemsDataFaceSet.sort((a, b) => a.CONFIDENCE.compareTo(b.CONFIDENCE));
    ItemsDataFaceSet.reversed;

    List<double> _confs = [];
    for(int i=0;i<ItemsDataFaceSet.length;i++){
      map={
        "TEXT_SEARCH" : "",
        "PERSON_ID": ItemsDataFaceSet[i].PERSON_ID
      };
      await new ArrestFutureMaster().apiRequestMasPersongetByCon(map).then((onValue) {
        if(onValue.RESPONSE_DATA.length>0){
          if(onValue.RESPONSE_DATA.first.MISTREAT_NO>0){
            itemSearch.add(onValue.RESPONSE_DATA.first);
            _confs.add(ItemsDataFaceSet[i].CONFIDENCE);
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
          itemSearch[i].CONFIDENCE = (_confs[i]/1)*100;
        }
      });
    }*/

    setState(() {});
    return true;
  }

  void onSetDataRequest(BuildContext mContext, File _file) async {
    String base64Image = base64Encode(_file.absolute.readAsBytesSync());

    Map map = {"DATA_SOURCE": "", "DOCUMENT_ID": "", "DOCUMENT_NAME": "UserUpload.jpg", "DOCUMENT_OLD_NAME": _file.path, "DOCUMENT_TYPE": "3", "FILE_TYPE": "jpg", "FOLDER": "person", "IS_ACTIVE": "1", "REFERENCE_CODE": 0, "CONTENT": base64Image};

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return /*WillPopScope(
            onWillPop: () {},
            child: Center(
              child: CupertinoActivityIndicator(
              ),
            ),
          );*/
              Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadAction(map, _file);
    Navigator.pop(context);

    _navigateSearchFace(mContext, _imageFile);
  }

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

        List<int> imageBytes = f.absolute.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        onSetDataRequest(mContext, f);
      });
      Navigator.pop(mContext);
    });
  }

  _navigateSearchFace(BuildContext mContext, _imageFile) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (mContext) => AnalysisRecognitionSearchScreenFragment(
                ImageFile: _imageFile,
                ItemsPerson: itemLawbreaker,
              )),
    );
    if (result.toString() != "back") {
      _itemsData = result;
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        /*appBar: AppBar(
        title: Text('วิเคราะห์ข้อมูลผู้ต้องหา',
            style: TextStyle(fontFamily: 'Kanit')),
        centerTitle: true,
        backgroundColor: Color(0xff2e76bc),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SearchPerson(),
                  ))),
        ],
      ),*/
        body: Stack(
          children: <Widget>[
            BackgroundContent(),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /*FlatButton(
                        onPressed: () {
                          _showDialogPicker();
                        },
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.camera_alt,
                              size: 200,
                              color: Color(0xff2e76bc),
                            ),
                            Text(
                              'ค้นหาด้วยรูปภาพ',
                              style: TextStyle(
                                  fontFamily: FontStyles().FontFamily, fontSize: 25),
                            )
                          ],
                        ))*/
                    new SizedBox(
                      height: (size.width * 40) / 100,
                      width: (size.width * 40) / 100,
                      child: new RawMaterialButton(
                        onPressed: () {
                          _showDialogPicker();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(28.0),
                          child: Image(
                            image: AssetImage("assets/icons/landing/network_landing.png"),
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
                        "ค้นหาด้วยรูปภาพ",
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
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
  double CONFIDENCE;
  SortFaceX(this.PERSON_ID, this.CONFIDENCE);
}
