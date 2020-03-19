import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_message.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_cv_response.dart';
import 'package:prototype_app_pang/main_menu/future/item_transection.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;

import 'item_service_uat100.dart';
import 'item_service_uat200.dart';
import 'item_transection_item.dart';
import 'item_version.dart';

class TransectionFuture {
  TransectionFuture() : super();

  Future<List<ItemsListTransection>> apiRequestTransactionRunninggetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMasterCompare + "/TransactionRunninggetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListTransection.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestImgSignature(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      // serv.Server().IPAddressReport + "/ILG60_00_06_002.aspx",
      "http://103.233.193.62:8000/Report_XCS/ILG60_00_06_002.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = (await getApplicationDocumentsDirectory()).path;
      File file = new File("$dir/" + "ILG60_00_06_002.pdf");
      await file.writeAsBytes(response.bodyBytes);

      // return response.statusCode.toString();
      return file.path;
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<CompareCVResponse> apiRequestCVSignature(Map jsonMap, File pdfFile) async {
    var stream = new http.ByteStream(DelegatingStream.typed(pdfFile.openRead()));
    var length = await pdfFile.length();

    // var uri = Uri.parse(serv.Server().IPAddressDocumentinsAll + "/DocumentinsAll");
    var uri = Uri.parse("http://192.168.160.59/ets-signer/api/signPdf/MultiplePage");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('pdfFile', stream, length, filename: jsonMap['docName'], contentType: MediaType('application', 'pdf'));

    request.files.add(multipartFile);
    request.fields['textFile'] = jsonMap['textFile'];
    request.fields['saveFile'] = jsonMap['saveFile'];
    request.fields['docName'] = jsonMap['docName'];
    request.fields['docTitle'] = jsonMap['docTitle'];
    request.fields['docAccount'] = jsonMap['docAccount'];
    request.fields['docType'] = jsonMap['docType'];
    request.fields['pin'] = jsonMap['pin'];
    request.fields['id'] = jsonMap['id'];
    request.fields['system'] = jsonMap['system'];
    request.fields['officeCode'] = jsonMap['officeCode'];
    request.fields['fileType'] = jsonMap['fileType'];
    request.fields['sendMail'] = jsonMap['sendMail'];
    request.fields['signDataList'] = jsonMap['signDataList'];
    var data;
    await request
        .send()
        .then((result) async {
          await http.Response.fromStream(result).then((response) {
            if (response.statusCode == 200) {
              print("Uploaded! ");
              print('response.body ' + response.body);
              data = response.body;
            }
          });
        })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
    return Future.delayed(Duration(seconds: 3), () => CompareCVResponse.fromJson(json.decode(data)));
  }

  Future<ItemsArrestResponseMessage> apiRequestTransactionRunninginsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMasterCompare + "/TransactionRunninginsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestTransactionRunningupdByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMasterCompare + "/TransactionRunningupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //Transection Item
  Future<List<ItemsListTransectionItem>> apiRequestTransactionRunningItemgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidence + "/TransactionRunningItemgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListTransectionItem.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestTransactionRunningIteminsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidence + "/TransactionRunningIteminsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestTransactionRunningItemupdByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidence + "/TransactionRunningItemupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  /*Future<TestImageResponse> apiRequestDocumentinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressDocument+ "/DocumentinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return TestImageResponse.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }*/

  Future<TestImageResponse> apiRequestDocumentinsAll(Map jsonMap, File imageFile) async {
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(serv.Server().IPAddressDocumentinsAll + "/DocumentinsAll");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('FILE', stream, length, filename: basename(/*imageFile.path*/ jsonMap['DOCUMENT_NAME']));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    request.fields['DOCUMENT_NAME'] = jsonMap['DOCUMENT_NAME'];
    request.fields['DOCUMENT_OLD_NAME'] = jsonMap['DOCUMENT_OLD_NAME'];
    request.fields['DOCUMENT_TYPE'] = jsonMap['DOCUMENT_TYPE'];
    request.fields['FOLDER'] = jsonMap['FOLDER'];
    request.fields['REFERENCE_CODE'] = jsonMap['REFERENCE_CODE'].toString();
    var response = await request.send();
    if (response.statusCode == 200) {
      var items;
      await response.stream.transform(utf8.decoder).listen((value) {
        items = value;
      });
      return TestImageResponse.fromJson(json.decode(items));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<ItemsListDocument>> apiRequestGetDocumentByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressDocument + "/GetDocumentByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListDocument.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestDocumentupdDelete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressDocument + "/DocumentupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestArrestReport(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressReport + "/ILG60_00_03_001.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_03_001.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestArrestReportTest(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressReport + "/ILG60_00_03_001.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_03_001.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return file.path;
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_04_001(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressReport + "/ILG60_00_04_001.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_04_001.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_04_002(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressReport + "/ILG60_00_04_002.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_04_002.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_06_002(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressReport + "/ILG60_00_06_002.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_06_002.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_06_003(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressReport + "/ILG60_00_06_003.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_06_003.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_06_004(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressReport + "/ILG60_00_06_004.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_06_004.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_06_001(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressReport + "/ILG60_00_06_001.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_06_001.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_05_001(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressReport + "/ILG60_00_05_001.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_05_001.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_05_002(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressReport + "/ILG60_00_05_002.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_05_002.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_05_003(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressReport + "/ILG60_00_05_003.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_05_003.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_02_001(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressReport + "/ILG60_00_02_001.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_02_001.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_02_002(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressReport + "/ILG60_00_02_002.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_02_002.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsListServiceUAT100Response> apiRequestEDRestServicesUAT100(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressServiceReg + "/EDRestServicesUAT/reg/Reg0100",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsListServiceUAT100Response.fromJson(json.decode(response.body));
      //return ItemsListServiceUATResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsListServiceUAT200Response> apiRequestEDRestServicesUAT200(Map jsonMap) async {
    //encode Map to JSON
    var body = utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv.Server().IPAddressServiceReg + "/EDRestServicesUAT/reg/Reg0200",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsListServiceUAT200Response.fromJson(json.decode(response.body));
      //return ItemsListServiceUATResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<ItemsListDocument>> apiRequestGetAllDocument(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressDocument + "/GetImagePerson",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListDocument.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  /*Future<List<FaceXResponse>> apiRequestFaceRecognition(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressCheckVersion+ "/FaceRec",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new FaceXResponse.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }*/

  Future<FaceRecognitionMainResponse> apiRequestFaceRecognition(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressFaceRecognition + "/api_facerecognition_oracle.php",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return FaceRecognitionMainResponse.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //Check Version App
  Future<List<ItemsListVersion>> apiRequestCheckVersion(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/CheckVersion",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListVersion.fromJson(m)).toList();
      //return ItemsListVersion.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
}

class TestImageResponse {
  String IsSuccess;
  String Msg;
  int DOCUMENT_ID;

  TestImageResponse({
    this.IsSuccess,
    this.Msg,
    this.DOCUMENT_ID,
  });

  factory TestImageResponse.fromJson(Map<String, dynamic> js) {
    return TestImageResponse(IsSuccess: js['IsSuccess'], Msg: js['Msg'], DOCUMENT_ID: js['DOCUMENT_ID']);
  }
}

/*class FaceXResponse {
  bool IS_PERSON;
  int DocumentID;
  double Confidence;
  FaceXResponse({
    this.IS_PERSON,
    this.DocumentID,
    this.Confidence,
  });
  factory FaceXResponse.fromJson(Map<String, dynamic> js) {
    return FaceXResponse(
      IS_PERSON: js['IS_PERSON'],
      DocumentID: js['DocumentID'],
      Confidence: js['Confidence'],
    );
  }
}*/
class FaceRecognitionMainResponse {
  List<FaceXResponse> group1;
  List<FaceXResponse> group2;

  FaceRecognitionMainResponse({this.group1, this.group2});

  factory FaceRecognitionMainResponse.fromJson(Map<String, dynamic> json) {
    return FaceRecognitionMainResponse(
      group1: List<FaceXResponse>.from(json['group1'].map((m) => FaceXResponse.fromJson(m))),
      group2: List<FaceXResponse>.from(json['group2'].map((m) => FaceXResponse.fromJson(m))),
    );
  }
}

class FaceXResponse {
  String DOCUMENT_ID;
  String REFERENCE_CODE;
  String FILE_PATH;
  String PERSON_ID;
  String PERSON_TYPE;
  String ENTITY_TYPE;
  String ID_CARD;
  String PASSPORT_NO;
  String COMPANY_NAME;
  String COMPANY_REGISTRATION_NO;
  String TITLE_ID;
  String MISTREAT_NO;
  String TITLE_NAME_EN;
  String TITLE_NAME_TH;
  String TITLE_SHORT_NAME_TH;
  String TITLE_SHORT_NAME_EN;
  String FIRST_NAME;
  String MIDDLE_NAME;
  String LAST_NAME;
  String OTHER_NAME;
  bool IsCheck;
  bool IsCreate;
  bool IsCheckOffence;
  int INDEX;
  //Document ID เอาไว้ ref image
  String REF_CODE;

  FaceXResponse({
    this.DOCUMENT_ID,
    this.REFERENCE_CODE,
    this.FILE_PATH,
    this.PERSON_ID,
    this.PERSON_TYPE,
    this.ENTITY_TYPE,
    this.ID_CARD,
    this.PASSPORT_NO,
    this.COMPANY_NAME,
    this.COMPANY_REGISTRATION_NO,
    this.TITLE_ID,
    this.MISTREAT_NO,
    this.TITLE_NAME_EN,
    this.TITLE_NAME_TH,
    this.TITLE_SHORT_NAME_TH,
    this.TITLE_SHORT_NAME_EN,
    this.FIRST_NAME,
    this.MIDDLE_NAME,
    this.LAST_NAME,
    this.OTHER_NAME,
    this.IsCheck,
    this.IsCreate,
    this.IsCheckOffence,
    this.INDEX,
    this.REF_CODE,
  });

  factory FaceXResponse.fromJson(Map<String, dynamic> js) {
    return FaceXResponse(
        DOCUMENT_ID: js['DOCUMENT_ID'],
        REFERENCE_CODE: js['REFERENCE_CODE'],
        FILE_PATH: js['FILE_PATH'],
        PERSON_ID: js['PERSON_ID'],
        PERSON_TYPE: js['PERSON_TYPE'],
        ENTITY_TYPE: js['ENTITY_TYPE'],
        ID_CARD: js['ID_CARD'],
        PASSPORT_NO: js['PASSPORT_NO'],
        COMPANY_NAME: js['COMPANY_NAME'],
        COMPANY_REGISTRATION_NO: js['COMPANY_REGISTRATION_NO'],
        TITLE_ID: js['TITLE_ID'],
        MISTREAT_NO: js['MISTREAT_NO'],
        TITLE_NAME_EN: js['TITLE_NAME_EN'],
        TITLE_NAME_TH: js['TITLE_NAME_TH'],
        TITLE_SHORT_NAME_TH: js['TITLE_SHORT_NAME_TH'],
        TITLE_SHORT_NAME_EN: js['TITLE_SHORT_NAME_EN'],
        FIRST_NAME: js['FIRST_NAME'],
        MIDDLE_NAME: js['MIDDLE_NAME'],
        LAST_NAME: js['LAST_NAME'],
        OTHER_NAME: js['OTHER_NAME'],
        IsCheck: false,
        IsCreate: false,
        IsCheckOffence: false,
        INDEX: null,
        REF_CODE: js['DOCUMENT_ID']);
  }
}
