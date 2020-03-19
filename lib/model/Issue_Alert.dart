import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';

class NetworkDialog {
  BuildContext context;
  String text;
  NetworkDialog(this.context, this.text) {
    _showNetworkErrorAlertDialog(this.context, this.text);
  }
  CupertinoAlertDialog _cupertinoNetworkError(mContext, text) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
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
                Navigator.pop(mContext);
              },
              child: new Text('ตกลง', style: ButtonAcceptStyle)),
        ]);
  }

  void _showNetworkErrorAlertDialog(context, text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoNetworkError(context, text);
      },
    );
  }
}

class EmptyDialog {
  BuildContext context;
  String text;
  EmptyDialog(this.context, this.text) {
    _showNetworkErrorAlertDialog(this.context, this.text);
  }
  CupertinoAlertDialog _cupertinoNetworkError(mContext, text) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
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
                Navigator.pop(mContext);
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void _showNetworkErrorAlertDialog(context, text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoNetworkError(context, text);
      },
    );
  }
}

class VerifyDialog {
  BuildContext context;
  String text;
  VerifyDialog(this.context, this.text) {
    _showNetworkErrorAlertDialog(this.context, this.text);
  }
  CupertinoAlertDialog _cupertinoNetworkError(mContext, text) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
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
                Navigator.pop(mContext);
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void _showNetworkErrorAlertDialog(context, text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoNetworkError(context, text);
      },
    );
  }
}

class InforDialog {
  BuildContext context;
  String title;
  String content;
  InforDialog(this.context, this.title, this.content) {
    _showNetworkErrorAlertDialog(this.context, this.title, this.content);
  }
  CupertinoAlertDialog _cupertinoNetworkError(mContext, text, content) {
    TextStyle ContentStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle TitleStyle = TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily, color: Colors.red);
    TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
    return new CupertinoAlertDialog(
        title: Text(
          text,
          style: TitleStyle,
        ),
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            content,
            style: ContentStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void _showNetworkErrorAlertDialog(context, text, content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoNetworkError(context, text, content);
      },
    );
  }
}

class NoInternetDialog {
  BuildContext context;
  String title;
  String content;
  NoInternetDialog(this.context, this.title, this.content) {
    _showNetworkErrorAlertDialog(this.context, this.title, this.content);
  }
  CupertinoAlertDialog _cupertinoNetworkError(mContext, text, content) {
    TextStyle ContentStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle TitleStyle = TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily, color: Colors.red);
    TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
    return new CupertinoAlertDialog(
        title: Text(
          text,
          style: TitleStyle,
        ),
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            content,
            style: ContentStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
                //Navigator.pop(mContext);
              },
              child: new Text('ตกลง', style: ButtonAcceptStyle)),
        ]);
  }

  void _showNetworkErrorAlertDialog(context, text, content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoNetworkError(context, text, content);
      },
    );
  }
}
