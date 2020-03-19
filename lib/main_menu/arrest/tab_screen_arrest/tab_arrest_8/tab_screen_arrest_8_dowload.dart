import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:share_extend/share_extend.dart';

class TabScreenArrest8Dowload extends StatefulWidget {
  String Title;
  String FILE_PATH;
  TabScreenArrest8Dowload({
    Key key,
    @required this.Title,
    @required this.FILE_PATH,
  }) : super(key: key);
  @override
  _TabScreenArrest8DowloadState createState() => new _TabScreenArrest8DowloadState();
}
class _TabScreenArrest8DowloadState extends State<TabScreenArrest8Dowload> {
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int pages = 0;
  bool isReady = false;
  String _page="";

  void share(String FILE_PATH) async {
    File testFile = new File(FILE_PATH);
    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
  }


  @override
  void initState() {
    super.initState();

    print(widget.FILE_PATH.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);
    TextStyle styleTextEmpty = TextStyle(fontSize: 18.0,
        fontFamily: FontStyles().FontFamily);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Padding(
            padding: EdgeInsets.only(right: 22.0),
            child: new Text(widget.Title,
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
            widget.FILE_PATH.isNotEmpty
                ? new FlatButton(
              onPressed: () {
                share(widget.FILE_PATH);
              },
              child: Icon(Icons.share, color: Colors.white,),
            )
                : Container(),
          ],
        ),
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
                        _page = (page+1).toString()+"/$total";
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
                  : Text('ไม่พบแบบฟอร์ม', style: styleTextEmpty,)
          ),
        ],
      ),
      floatingActionButton: widget.FILE_PATH.isNotEmpty
          ?FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              label: Text("$_page"),
              onPressed: () async {
                await snapshot.data.setPage(pages+1 ~/ 2);
              },
            );
          }

          return Container();
        },
      ):null,
    );
  }
}