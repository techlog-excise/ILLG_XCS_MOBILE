import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_cv_signature.dart';
import 'package:prototype_app_pang/main_menu/compare/future/compare_future.dart';
import 'package:prototype_app_pang/main_menu/compare/model/ItemCompareCV.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_main.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:share_extend/share_extend.dart';

class CompareSignature extends StatefulWidget {
  String Title;
  String FILE_PATH;
  String NAME;
  bool IsHaveCV;
  int CompareID;
  CompareSignature({
    Key key,
    @required this.Title,
    @required this.FILE_PATH,
    @required this.NAME,
    @required this.IsHaveCV,
    @required this.CompareID,
  }) : super(key: key);
  @override
  _CompareSignature createState() => new _CompareSignature();
}

class _CompareSignature extends State<CompareSignature> {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int pages = 0;
  bool isReady = false;
  String _page = "";

  ItemsCompareMain _itemsCompareMain;
  ItemsCompareCV _itemsCompareCV;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print('test: ${widget.itemsCompareMain.COMPARE_ID}');
  }

  void share(String FILE_PATH) async {
    File testFile = new File(FILE_PATH);
    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
  }

//************************ navigate to cv screen *******************************
  _navigate_preview_cv(BuildContext context, String item) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionCVForms(item);
    Navigator.pop(context);

    if (_itemsCompareCV == null) {
      print("apiRequestCVSignature return null && not navigate");
    } else {
      if (_itemsCompareCV.DATAFILE != null && _itemsCompareCV.ID != null) {
        Map item_map_did = {
          "COMPARE_DETAIL_ID": widget.CompareID,
          "DID": _itemsCompareCV.ID,
        };

        await _updDIDCompare(item_map_did);
        await _createFileFromString(_itemsCompareCV.DATAFILE, _itemsCompareCV.ID).then((filePath) async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompareCVSignature(
                      DataFile: _itemsCompareCV.DATAFILE,
                      PATH: filePath,
                      // PATH: '/data/user/0/com.example.prototype_app_pang/app_flutter/ILG60_00_06_002.pdf',
                    )),
          );

          if (result.toString() == "back") {
            print("Return");
            Navigator.pop(context);
          }
        });
      } else {
        print("_itemsCompareCV.DATAFILE != null && _itemsCompareCV.ID != null && not navigate");
      }
    }
  }

  Future<bool> _updDIDCompare(Map map) async {
    await new CompareFuture().apiRequestCompareupdByCon(map).then((onValue) {
      print("Update DID : " + onValue.Msg);
    });
  }

  Future<String> _createFileFromString(String item, String id) async {
    final encodedStr = item;
    Uint8List bytes = base64.decode(encodedStr);
    // String dir = (await getApplicationDocumentsDirectory()).path;
    String dir = (await getTemporaryDirectory()).path;
    String path = '$dir/pdf${DateTime.now().toIso8601String()}.pdf';
    File file = File(path);
    // File file = await File(path).writeAsBytes(base64.decode(encodedStr).buffer.asUint8List());
    await file.writeAsBytes(bytes);
    return file.path;
  }

  // ******************** Load image signature ********************
  Future<bool> onLoadActionCVForms(String item) async {
    print("CV_item: ${item}");

    File testFile = new File(item);
    print("file_absolute: ${testFile.absolute}");

    Map temp_signDataList = {
      "page": "1",
      "x": "75",
      "y": "100",
      "w": "100",
      "h": "20",
      "isCorporate": "false",
    };
    List signDataList = [];
    signDataList.add(temp_signDataList);

    Map map = {
      // "fileName": widget.NAME,
      "textFile": "undefined",
      "saveFile": "true",
      "docName": widget.CompareID.toString(), // แก้เป็นเลขที่ใบเสร็จที่ระบบ gen มาเป็นตัวเลข (RECEIPT_NO)
      "docTitle": "xcs",
      "docAccount": "LAW_RECEIPT", // เก่า INCOME_RECEIPT แก้ใหม่
      "docType": "",
      "pin": "Suthee#1",
      "id": "wannapa_j",
      "system": "",
      "officeCode": "100300",
      "fileType": "ใบเสร็จรับเงินคดี", // เก่า ภส. 101 แก้ใหม่
      "sendMail": "false",
      "signDataList": signDataList.toString(),
    };

    await new TransectionFuture().apiRequestCVSignature(map, testFile.absolute).then((onValue) {
      if (onValue.MSG == "ลงลายเซ็นดิจิตอลในเอกสารเรียบร้อยแล้ว") {
        if (onValue == null) {
          print("apiRequestCVSignature return null");
          new NetworkDialog(context, "บันทึกข้อมูลไม่สำเร็จ!");
        } else {
          print("CV Signature: ${onValue.MSG}");
          _itemsCompareCV = onValue.ItemCV;
        }
      } else {
        print("onValue.MSG != ลงลายเซ็นดิจิตอลในเอกสารเรียบร้อยแล้ว");
        new NetworkDialog(context, "บันทึกข้อมูลไม่สำเร็จ!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    TextStyle styleTextEmpty = TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily);

    final List<Widget> btnFuctionRight = <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        !widget.IsHaveCV
            ? new FlatButton(
                onPressed: () {
                  _navigate_preview_cv(context, widget.FILE_PATH);
                },
                child: Text('ยืนยัน', style: styleTextAppbar))
            : <Widget>[
                widget.FILE_PATH.isNotEmpty
                    ? new FlatButton(
                        onPressed: () {
                          share(widget.FILE_PATH);
                        },
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      )
                    : Container(),
              ],
      ])
    ];
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
            title: new Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: new Text(
                'ตรวจสอบใบเสร็จรับเงิน',
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
            actions: btnFuctionRight),
      ),
      body: Stack(
        children: <Widget>[
          BackgroundContent(),
          Center(
              child: widget.FILE_PATH.isNotEmpty
                  ? Stack(
                      children: <Widget>[
                        PDFView(
                          filePath: widget.FILE_PATH,
                          enableSwipe: true,
                          swipeHorizontal: true,
                          autoSpacing: true,
                          pageFling: true,
                          onRender: (_pages) {
                            setState(() {
                              print(_pages.toString());
                              pages = _pages;
                              isReady = true;
                            });
                          },
                          onError: (error) {
                            print(error.toString());
                          },
                          onPageError: (page, error) {
                            print('$page: ${error.toString()}');
                          },
                          onViewCreated: (PDFViewController pdfViewController) {
                            _controller.complete(pdfViewController);
                          },
                          onPageChanged: (int page, int total) {
                            print('page change: $page/$total');
                            setState(() {
                              _page = (page + 1).toString() + "/$total";
                            });
                          },
                        ),
                        !isReady
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container()
                      ],
                    )
                  : Text(
                      'ไม่พบแบบฟอร์ม',
                      style: styleTextEmpty,
                    )),
        ],
      ),
      floatingActionButton: widget.FILE_PATH.isNotEmpty
          ? FutureBuilder<PDFViewController>(
              future: _controller.future,
              builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
                if (snapshot.hasData) {
                  return FloatingActionButton.extended(
                    label: Text("$_page"),
                    onPressed: () async {
                      await snapshot.data.setPage(pages + 1 ~/ 2);
                    },
                  );
                }

                return Container();
              },
            )
          : null,
    );
  }
}
