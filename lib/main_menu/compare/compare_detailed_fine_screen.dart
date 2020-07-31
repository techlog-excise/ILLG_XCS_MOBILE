import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/evidence_search_staff.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_get_staff.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_main.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence.dart';
import 'package:prototype_app_pang/model/SetProductName.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

import 'model/compare_arrest_main.dart';
import 'model/compare_evidence_controller.dart';
import 'model/compare_guiltbase_fine.dart';
import 'model/compare_indicment_detail.dart';
import 'model/compare_map_fine_detail.dart';
import 'model/compare_prove_product.dart';
import 'model/compare_staff.dart';

class CompareDetailFineScreenFragment extends StatefulWidget {
  ItemsCompareListIndicmentDetail indicmentDetail;
  ItemsCompareArrestMain itemsCompareArrestMain;
  ItemsCompareGuiltbaseFine itemsCompareGuiltbaseFine;
  ItemsListCompareStaff itemsListCompareStaff;
  CompareDetailFineScreenFragment({
    Key key,
    @required this.indicmentDetail,
    @required this.itemsCompareArrestMain,
    @required this.itemsCompareGuiltbaseFine,
    @required this.itemsListCompareStaff,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<CompareDetailFineScreenFragment> with TickerProviderStateMixin {
  //เมื่อบันทึกข้อมูล
  bool _onSaved = false;
  bool _onSave = false;
  //เมื่อแก้ไขข้อมูล
  bool _onEdited = false;
  //เมื่อลบข้อมูล
  bool _onDeleted = false;
  //เมื่อทำรายการเสร็จ
  bool _onFinish = false;

  bool Checkedboxna = false;

  List<ItemsListEvidenceGetStaff> itemsListEvidenceStaff = [];
  ItemsEvidenceMain itemMain;

  ItemsCompareArrestMain ItemsMain;

  //ยอดชำระสุทธิ
  double _totalPayment;

  TextStyle textStyleLabel = Styles.textStyleLabel;
  TextStyle textStyleData = Styles.textStyleData;
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400], fontFamily: FontStyles().FontFamily, fontSize: 12.0);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0, right: 14, left: 4);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0, right: 14, left: 4);

  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle textErrorStyle = TextStyle(fontSize: 14.0, color: Colors.red, fontFamily: FontStyles().FontFamily);

  double fine_total = 0;
  final formatter = new NumberFormat("#,##0.00");

  final formatterint = new NumberFormat("#,##0");
  final formattertax = new NumberFormat("#,##0.0000");

  final FocusNode myFocusPresidentCommittee = FocusNode();
  TextEditingController editPresidentCommittee = new TextEditingController();

  final FocusNode myFocusTaxValue = FocusNode();
  final FocusNode myFocusFineDouble = FocusNode();
  final FocusNode myFocusFineTotal = FocusNode();
  final FocusNode myFocusFinePayment = FocusNode();
  TextEditingController editTaxValue = new TextEditingController();
  TextEditingController editFineDouble = new TextEditingController();
  TextEditingController editFineTotal = new TextEditingController();
  TextEditingController editFinePayment = new TextEditingController();
  bool IsErrorFine = false;

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
  // @override
  // void initState() {
  //   super.initState();

  //   _onSaved = widget.indicmentDetail.IsDetailFineComplete;
  //   _onFinish = widget.indicmentDetail.IsDetailFineComplete;

  //   setState(() {
  //     ItemsMain = widget.itemsCompareArrestMain;

  //     print(ItemsMain.FINE);

  //     _totalPayment = 0.0;

  //     /*if(ItemsMain.FINE_TYPE==2){
  //       _totalPayment += widget.indicmentDetail.FINE_TOTAL;
  //     }else{*/

  //     if (widget.itemsCompareGuiltbaseFine != null) {
  //       if (ItemsMain.CompareProveProduct.length > 0) {
  //         ItemsMain.CompareProveProduct.forEach((item) {
  //           if (_onSaved) {
  //             //item.Controller.
  //             setInitDataTextField(item, item.Controller.FineValue);
  //             _totalPayment += fine_total;
  //           } else {
  //             //item.Controller.
  //             setInitDataTextField(item, widget.itemsCompareGuiltbaseFine.FINE_RATE);
  //             _totalPayment += fine_total;
  //           }
  //         });
  //       } else {
  //         setInitDataTextField(null, widget.itemsCompareGuiltbaseFine.FINE_RATE);
  //         _totalPayment += fine_total;
  //       }
  //     } else {
  //       setInitDataTextField(null, 0);
  //       _totalPayment += fine_total;
  //     }

  //     //}
  //   });
  // }

//   setInitDataTextField(ItemsCompareListProveProduct item, double fine_rate) {
//     //ค่าปรับสุทธิ
//     //set text
//     if (widget.itemsCompareGuiltbaseFine != null) {
//       if (item != null) {
//         item.Controller.editTaxValue.text = item.VAT.toString();
//         if (ItemsMain.FINE_TYPE == 0 || ItemsMain.FINE_TYPE == 1 || ItemsMain.FINE_TYPE == 2) {
//           if (ItemsMain.FINE_TYPE == 2) {
//             fine_total = widget.indicmentDetail.FINE_TOTAL;
//           } else {
//             fine_total = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
//           }
//         } else {
//           fine_total = item.VAT * fine_rate;
//         }
//         item.Controller.editTaxValueDouble.text = formatterint.format(fine_rate).toString();
//         item.Controller.editPayment.text = formatter.format(fine_total).toString();
//         item.Controller.editFineValue.text = formatter.format(fine_total).toString();

//         editFinePayment.text = formatter.format(widget.indicmentDetail.FINE_TOTAL).toString();
//       } else {
//         editTaxValue.text = 0.toString();
//         if (ItemsMain.FINE_TYPE == 0 || ItemsMain.FINE_TYPE == 1 || ItemsMain.FINE_TYPE == 2) {
//           fine_total = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
//         } else {
//           fine_total = 0 * fine_rate;
//         }
//         //editFineDouble.text = formatterint.format(fine_rate).toString();
//         //editFineTotal.text = formatterint.format(fine_total).toString();
//         editFinePayment.text = formatter.format(widget.indicmentDetail.FINE_TOTAL).toString();
//       }
//     } else {
//       //153,154
//       editTaxValue.text = 0.toString();
//       if (ItemsMain.FINE_TYPE == 0 || ItemsMain.FINE_TYPE == 1 || ItemsMain.FINE_TYPE == 2) {
//         fine_total = 0;
//       } else {
//         fine_total = 0 * fine_rate;
//       }
//       editFinePayment.text = formatter.format(widget.indicmentDetail.FINE_TOTAL).toString();
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();

//     editTaxValue.dispose();
//     editPresidentCommittee.dispose();
//     editFineDouble.dispose();
//     editFinePayment.dispose();
//     editFineTotal.dispose();
//     /*ItemsMain.Evidenses.forEach((item){
//       item.EvidenceTaxValues.expController.dispose();
//       item.EvidenceTaxValues.editTaxValueDouble.dispose();
//     });*/
//   }

//   showOverlay(BuildContext context) {
//     if (overlayEntry != null) return;
//     OverlayState overlayState = Overlay.of(context);
//     overlayEntry = OverlayEntry(builder: (context) {
//       return Positioned(bottom: MediaQuery.of(context).viewInsets.bottom, right: 0.0, left: 0.0, child: InputDoneView());
//     });

//     overlayState.insert(overlayEntry);
//   }

//   removeOverlay() {
//     if (overlayEntry != null) {
//       overlayEntry.remove();
//       overlayEntry = null;
//     }
//   }

//   void clearTextfield() {
//     editPresidentCommittee.clear();
//   }

//   Widget _collap() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Divider(
//               color: Colors.white,
//             ),
//             Container(
//               padding: paddingLabel,
//               child: Text(
//                 "บทลงโทษมาตรา",
//                 style: textStyleLabel,
//               ),
//             ),

//             Container(
//               padding: paddingLabel,
//               child: Text(
//                 ItemsMain.SECTION_NAME.toString(),
//                 style: textStyleData,
//               ),
//             ),

//             Container(
//               padding: paddingLabel,
//               child: Text(
//                 "อัตราโทษ",
//                 style: textStyleLabel,
//               ),
//             ),

//             Container(
//               padding: paddingLabel,
//               child: Text(
//                 ItemsMain.PENALTY_DESC.toString(),
//                 style: textStyleData,
//               ),
//             ),
//             /* Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "อัตราที่กำหนดให้ปรับ",
//                   style: textStyleLabel,
//                 ),
//               ),
//               ItemsMain.FINE != null?
//               Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   ItemsMain.FINE.toString(),
//                   style: textStyleData,
//                 ),
//               ):Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "ไม่มีอัตราที่กำหนดให้ปรับ",
//                   style: textStyleData,
//                 ),
//               ),*/

//             widget.itemsCompareArrestMain.FINE_TYPE != 2
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         padding: paddingLabel,
//                         child: Text(
//                           "จำนวนครั้งกระทำผิด",
//                           style: textStyleLabel,
//                         ),
//                       ),
//                       Container(
//                         padding: paddingLabel,
//                         child: Text(
//                           widget.indicmentDetail.MISTREAT_NO.toString(),
//                           style: textStyleData,
//                         ),
//                       ),
//                     ],
//                   )
//                 : Column(
//                     children: <Widget>[
//                       /*Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "ปริมาณของกลาง",
//                   style: textStyleLabel,
//                 ),
//               ),
//               Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "",
//                   style: textStyleData,
//                 ),
//               ),*/
//                     ],
//                   ),
//             //Divider()
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _expand() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Divider(
//           color: Colors.white,
//         ),
//         Container(
//           padding: paddingLabel,
//           child: Text(
//             "บทลงโทษมาตรา",
//             style: textStyleLabel,
//           ),
//         ),

//         Container(
//           padding: paddingLabel,
//           child: Text(
//             ItemsMain.SECTION_NAME.toString(),
//             style: textStyleData,
//           ),
//         ),

//         Container(
//           padding: paddingLabel,
//           child: Text(
//             "อัตราโทษ",
//             style: textStyleLabel,
//           ),
//         ),

//         Container(
//           padding: paddingLabel,
//           child: Text(
//             ItemsMain.PENALTY_DESC.toString(),
//             style: textStyleData,
//           ),
//         ),

//         Container(
//           padding: paddingLabel,
//           child: Text(
//             "อัตราที่กำหนดให้ปรับ",
//             style: textStyleLabel,
//           ),
//         ),
//         ItemsMain.FINE != null
//             ? Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   ItemsMain.FINE.toString(),
//                   style: textStyleData,
//                 ),
//               )
//             : Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "ไม่มีอัตราที่กำหนดให้ปรับ",
//                   style: textStyleData,
//                 ),
//               ),

//         widget.itemsCompareArrestMain.FINE_TYPE != 2
//             ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     padding: paddingLabel,
//                     child: Text(
//                       "จำนวนครั้งกระทำผิด",
//                       style: textStyleLabel,
//                     ),
//                   ),
//                   Container(
//                     padding: paddingLabel,
//                     child: Text(
//                       widget.indicmentDetail.MISTREAT_NO.toString().trim(),
//                       style: textStyleData,
//                     ),
//                   ),
//                 ],
//               )
//             : Column(
//                 children: <Widget>[
//                   /*Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "ปริมาณของกลาง",
//                   style: textStyleLabel,
//                 ),
//               ),
//               Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "",
//                   style: textStyleData,
//                 ),
//               ),*/
//                 ],
//               ),
//         //Divider()
//       ],
//     );
//   }

//   Widget _buildContent() {
//     var size = MediaQuery.of(context).size;

//     _totalPayment = 0;
//     ItemsMain.CompareProveProduct.forEach((f) {
//       _totalPayment += double.parse(f.Controller.editPayment.text.replaceAll(",", ""));
//     });

//     return Column(
//       //mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
// // return ExpandableNotifier(

// //          child: Stack(

// //                     children: <Widget>[

// //                       Expandable(
// //                         collapsed: _collap(),
// //                         expanded: _expand(),
// //                       ),
// //                       Align(
// //              alignment: Alignment.topRight,
// //              child: Builder(builder: (context) {
// //                var exp = ExpandableController.of(context);
// //             return IconButton(
// //                  icon: Icon(
// //                   exp.expanded
// //                       ? Icons.keyboard_arrow_up
// //                        : Icons.keyboard_arrow_down,
// //                  size: 32.0,
// //                  color: Colors.grey,
// //                  ),
// //                 onPressed: () {
// //                   exp.toggle();
// //                 },
// //               );
// //             }),
// //           )

// //                     ],

// //                   ),

// //         );

//         ItemsMain.CompareProveProduct.length > 0 && (ItemsMain.FINE_TYPE == 2 || ItemsMain.FINE_TYPE == 3)
//             ? Container(
//                 padding: EdgeInsets.only(bottom: 1),
//                 child: ExpandableNotifier(
//                     child: Container(
//                   width: size.width,
//                   padding: EdgeInsets.all(22.0),
//                   decoration: BoxDecoration(
//                       shape: BoxShape.rectangle,
//                       border: Border(
//                         bottom: BorderSide(color: Colors.grey[300], width: 1.0),
//                       )),
//                   child: Stack(
//                     children: <Widget>[
//                       Expandable(
//                         collapsed: _collap(),
//                         expanded: _expand(),
//                       ),
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: Builder(builder: (context) {
//                           var exp = ExpandableController.of(context);
//                           return IconButton(
//                             icon: Icon(
//                               exp.expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                               size: 32.0,
//                               color: Colors.grey,
//                             ),
//                             onPressed: () {
//                               exp.toggle();
//                             },
//                           );
//                         }),
//                       )
//                     ],
//                   ),
//                 )),
//               )
//             : Container(),

//         widget.itemsCompareArrestMain.FINE_TYPE == 2
//             ? Container(
//                 width: size.width,
//                 padding: EdgeInsets.all(22.0),
//                 decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     border: Border(
//                       bottom: BorderSide(color: Colors.grey[300], width: 1.0),
//                     )),
//                 child: Stack(
//                   children: <Widget>[
//                     _buildExpandableContentFineType2(),
//                   ],
//                 ))
//             : new Container(
//                 child: ItemsMain.CompareProveProduct.length > 0 && widget.itemsCompareArrestMain.FINE_TYPE != 0
//                     ? ListView.builder(
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: ItemsMain.CompareProveProduct.length,
//                         scrollDirection: Axis.vertical,
//                         shrinkWrap: true,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Container(
//                               width: size.width,
//                               padding: EdgeInsets.all(22.0),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.rectangle,
//                                   border: Border(
//                                     bottom: BorderSide(color: Colors.grey[300], width: 1.0),
//                                   )),
//                               child: Stack(
//                                 children: <Widget>[
//                                   _buildExpandableContent(index),
//                                 ],
//                               ));
//                         },
//                       )
//                     : Container(
//                         width: size.width,
//                         padding: EdgeInsets.all(22.0),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.rectangle,
//                             border: Border(
//                               bottom: BorderSide(color: Colors.grey[300], width: 1.0),
//                             )),
//                         child: Stack(
//                           children: <Widget>[
//                             _buildExpandableContentNotProduct(),
//                           ],
//                         )),
//               ),
//         Container(
//           padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
//           child: Container(
//               width: size.width,
//               padding: EdgeInsets.all(22.0),
//               decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   border: Border(
//                     bottom: BorderSide(color: Colors.grey[300], width: 1.0),
//                   )),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Container(
//                         padding: EdgeInsets.only(right: 18.0, top: 8, bottom: 8.0),
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               Checkedboxna = !Checkedboxna;
//                             });
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.rectangle,
//                               borderRadius: BorderRadius.circular(4.0),
//                               color: Checkedboxna ? Color(0xff3b69f3) : Colors.white,
//                               border: Border.all(width: 1.5, color: Colors.black38),
//                             ),
//                             child: Padding(
//                                 padding: const EdgeInsets.all(4.0),
//                                 child: Checkedboxna
//                                     ? Icon(
//                                         Icons.check,
//                                         size: 16.0,
//                                         color: Colors.white,
//                                       )
//                                     : Container(
//                                         height: 16.0,
//                                         width: 16.0,
//                                         color: Colors.transparent,
//                                       )),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         child: Text(
//                           "ปรับผิดจากบัญชี",
//                           style: textStyleLabel,
//                         ),
//                       ),
//                       Container(),
//                     ],
//                   ),
//                   Checkedboxna
//                       ? Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: <Widget>[
//                               Container(
//                                 padding: paddingLabel,
//                                 child: Text(
//                                   "ผู้มีอำนาจ",
//                                   style: textStyleLabel,
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ),
//                               Container(
//                                 padding: paddingLabel,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     new Container(
//                                       //padding: paddingData,
//                                       child: TextField(
//                                         enableInteractiveSelection: false,
//                                         onTap: () {
//                                           FocusScope.of(context).requestFocus(new FocusNode());
//                                           _navigateSearchStaff(context, 34);
//                                           //
//                                         },
//                                         focusNode: myFocusPresidentCommittee,
//                                         controller: editPresidentCommittee,
//                                         keyboardType: TextInputType.text,
//                                         textCapitalization: TextCapitalization.words,
//                                         style: textStyleData,
//                                         decoration: InputDecoration(border: InputBorder.none, suffixIcon: Icon(Icons.person_add)),
//                                       ),
//                                     ),
//                                     Container(
//                                       height: 1.0,
//                                       color: Colors.grey[300],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : Container(
//                           child: Text(""),
//                         )
//                 ],
//               )),
//         ),

//         Container(
//           padding: EdgeInsets.only(top: 4.0, bottom: 44.0),
//           child: Container(
//               width: size.width,
//               padding: EdgeInsets.all(22.0),
//               decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   border: Border(
//                     bottom: BorderSide(color: Colors.grey[300], width: 1.0),
//                   )),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     padding: paddingLabel,
//                     child: Text(
//                       "รวมยอดชำระ",
//                       style: textStyleLabel,
//                     ),
//                   ),
//                   Padding(
//                     padding: paddingData,
//                     child: Text(
//                       formatter.format(_totalPayment).toString() + ' บาท',
//                       style: textStyleData,
//                     ),
//                   ),
//                 ],
//               )),
//         ),
//       ],
//     );
//   }

//   Widget _buildExpandableContent(int index) {
//     double fine_value = 0;
//     if (ItemsMain.FINE_TYPE == 0 || ItemsMain.FINE_TYPE == 1 || ItemsMain.FINE_TYPE == 2) {
//       fine_value = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
//     } else {
//       fine_value = ItemsMain.CompareProveProduct[index].VAT * widget.itemsCompareGuiltbaseFine.FINE_RATE;
//     }
//     var size = MediaQuery.of(context).size;

//     Widget _buildExpanded(index) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "ของกลางลำดับ" + (index + 1).toString(),
//                   style: textStyleLabel,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding: paddingData,
//             child: Text(
//               // ItemsMain.CompareProveProduct[index].PRODUCT_GROUP_NAME
//               //     .toString(),
//               ItemsMain.CompareProveProduct[index].PRODUCT_DESC.toString(),

//               style: textStyleData,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 width: ((size.width * 75) / 100) / 2,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: paddingLabel,
//                       child: Text(
//                         "มูลค่าภาษี",
//                         style: textStyleLabel,
//                       ),
//                     ),
//                     IgnorePointer(
//                       ignoring: true,
//                       child: Padding(
//                         padding: paddingData,
//                         child: TextField(
//                           controller: ItemsMain.CompareProveProduct[index].Controller.editTaxValue,
//                           keyboardType: TextInputType.number,
//                           textCapitalization: TextCapitalization.words,
//                           style: textStyleData,
//                           decoration: InputDecoration(border: InputBorder.none, errorText: ""),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 width: ((size.width * 75) / 100) / 2,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: paddingLabel,
//                       child: Text(
//                         "จำนวนค่าปรับเท่า",
//                         style: textStyleLabel,
//                       ),
//                     ),
//                     Padding(
//                       padding: paddingData,
//                       child: TextField(
//                         focusNode: ItemsMain.CompareProveProduct[index].Controller.myFocusNodeTaxValueDouble,
//                         controller: ItemsMain.CompareProveProduct[index].Controller.editTaxValueDouble,
//                         autofocus: false,
//                         keyboardType: TextInputType.number,
//                         textCapitalization: TextCapitalization.words,
//                         style: textStyleData,
//                         decoration: InputDecoration(border: InputBorder.none, errorText: ItemsMain.CompareProveProduct[index].Controller.IsErrorFineRate ? "กรุณาปรับตามอัตราที่กำหนดให้ปรับ" : "", errorStyle: textErrorStyle),
//                         onChanged: (String text) {
//                           double ble = double.parse(text);
//                           if (text.isEmpty) {
//                             setState(() {
//                               if (double.parse(text) > double.parse(widget.itemsCompareArrestMain.FINE_RATE_MAX) || double.parse(text) < double.parse(widget.itemsCompareArrestMain.FINE_RATE_MIN)) {
//                                 ItemsMain.CompareProveProduct[index].Controller.IsErrorFineRate = true;
//                               } else {
//                                 ble = 0;
//                                 if (ItemsMain.FINE_TYPE == 0 || ItemsMain.FINE_TYPE == 1 || ItemsMain.FINE_TYPE == 2) {
//                                   fine_total = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
//                                 } else {
//                                   fine_total = ItemsMain.CompareProveProduct[index].VAT * ble;
//                                 }

//                                 ItemsMain.CompareProveProduct[index].Controller.editFineValue.text = fine_total.toString();
//                                 ItemsMain.CompareProveProduct[index].Controller.editPayment.text = formatter.format(fine_total).toString();

//                                 ItemsMain.CompareProveProduct[index].Controller.IsErrorFineRate = false;
//                               }
//                             });
//                             return;
//                           }
//                           setState(() {
//                             if (double.parse(text) > double.parse(widget.itemsCompareArrestMain.FINE_RATE_MAX) || double.parse(text) < double.parse(widget.itemsCompareArrestMain.FINE_RATE_MIN)) {
//                               ItemsMain.CompareProveProduct[index].Controller.IsErrorFineRate = true;
//                             } else {
//                               if (ItemsMain.FINE_TYPE == 0 || ItemsMain.FINE_TYPE == 1 || ItemsMain.FINE_TYPE == 2) {
//                                 fine_total = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
//                               } else {
//                                 fine_total = ItemsMain.CompareProveProduct[index].VAT * ble;
//                               }

//                               ItemsMain.CompareProveProduct[index].Controller.editFineValue.text = fine_total.toString();
//                               ItemsMain.CompareProveProduct[index].Controller.editPayment.text = formatter.format(fine_total).toString();

//                               ItemsMain.CompareProveProduct[index].Controller.IsErrorFineRate = false;
//                             }
//                           });
//                         },
//                       ),
//                     ),
//                     _buildLine(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 width: ((size.width * 75) / 100) / 2,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: paddingLabel,
//                       child: Text(
//                         "ค่าปรับสุทธิ",
//                         style: textStyleLabel,
//                       ),
//                     ),
//                     IgnorePointer(
//                       ignoring: true,
//                       child: Padding(
//                         padding: paddingData,
//                         child: TextField(
//                           controller: ItemsMain.CompareProveProduct[index].Controller.editFineValue,
//                           keyboardType: TextInputType.number,
//                           textCapitalization: TextCapitalization.words,
//                           style: textStyleData,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 width: ((size.width * 75) / 100) / 2,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: paddingLabel,
//                       child: Text(
//                         "ยอดชำระ",
//                         style: textStyleLabel,
//                       ),
//                     ),
//                     IgnorePointer(
//                       ignoring: true,
//                       child: Padding(
//                         padding: paddingData,
//                         child: TextField(
//                           controller: ItemsMain.CompareProveProduct[index].Controller.editPayment,
//                           keyboardType: TextInputType.number,
//                           textCapitalization: TextCapitalization.words,
//                           style: textStyleData,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
//     }

//     Widget _buildCollapsed(int index) {
//       double fine_value = 0;
//       if (ItemsMain.FINE_TYPE == 0 || ItemsMain.FINE_TYPE == 1 || ItemsMain.FINE_TYPE == 2) {
//         fine_value = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
//       } else {
//         fine_value = ItemsMain.CompareProveProduct[index].VAT * widget.itemsCompareGuiltbaseFine.FINE_RATE;
//       }
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "ของกลางลำดับ" + (index + 1).toString(),
//                   style: textStyleLabel,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding: paddingData,
//             child: Text(
//               // ItemsMain.CompareProveProduct[index].PRODUCT_GROUP_NAME
//               //     .toString(),
//               ItemsMain.CompareProveProduct[index].PRODUCT_DESC.toString(),

//               style: textStyleData,
//             ),
//           ),
//           Container(
//             padding: paddingLabel,
//             child: Text(
//               "ยอดชำระ",
//               style: textStyleLabel,
//             ),
//           ),
//           Container(
//             padding: paddingData,
//             child: Text(
//               formatter.format(fine_value).toString(),
//               style: textStyleData,
//             ),
//           ),
//         ],
//       );
//     }

//     return ExpandableNotifier(
//       controller: ItemsMain.CompareProveProduct[index].Controller.expController,
//       child: Stack(
//         children: <Widget>[
//           Expandable(collapsed: _buildCollapsed(index), expanded: _buildExpanded(index)),
//           Align(
//             alignment: Alignment.topRight,
//             child: Builder(builder: (context) {
//               var exp = ExpandableController.of(context);
//               return IconButton(
//                 icon: Icon(
//                   exp.expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                   size: 32.0,
//                   color: Colors.grey,
//                 ),
//                 onPressed: () {
//                   exp.toggle();
//                 },
//               );
//             }),
//           )
//         ],
//       ),
//     );
//   }

//   //*********************Not Product***********************

//   Widget _buildExpandableContentNotProduct() {
//     double fine_value = 0;

//     if (widget.itemsCompareGuiltbaseFine != null) {
//       if (ItemsMain.FINE_TYPE == 0 || ItemsMain.FINE_TYPE == 1 || ItemsMain.FINE_TYPE == 2) {
//         fine_value = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
//       } else {
//         fine_value = widget.itemsCompareGuiltbaseFine.FINE_RATE;
//       }
//     } else {
//       if (ItemsMain.FINE_TYPE == 0 || ItemsMain.FINE_TYPE == 1 || ItemsMain.FINE_TYPE == 2) {
//         fine_value = 0;
//       } else {
//         fine_value = 0;
//       }
//     }

//     _totalPayment += editFinePayment.text.isNotEmpty ? double.parse(editFinePayment.text.replaceAll(",", "")) : 0;

//     var size = MediaQuery.of(context).size;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           padding: paddingLabel,
//           child: Text(
//             "บทลงโทษมาตรา",
//             style: textStyleLabel,
//           ),
//         ),
//         Container(
//           padding: paddingData,
//           child: Text(
//             ItemsMain.SECTION_NAME.toString(),
//             style: textStyleData,
//           ),
//         ),
//         Container(
//           padding: paddingLabel,
//           child: Text(
//             "อัตราโทษ",
//             style: textStyleLabel,
//           ),
//         ),
//         Container(
//           padding: paddingData,
//           child: Text(
//             ItemsMain.PENALTY_DESC.toString(),
//             style: textStyleData,
//           ),
//         ),
//         Container(
//           padding: paddingLabel,
//           child: Text(
//             "อัตราที่กำหนดให้ปรับ",
//             style: textStyleLabel,
//           ),
//         ),
//         ItemsMain.FINE != null
//             ? Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   ItemsMain.FINE.toString(),
//                   style: textStyleData,
//                 ),
//               )
//             : Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "ไม่มีอัตราที่กำหนดให้ปรับ",
//                   style: textStyleData,
//                 ),
//               ),
//         Container(
//           padding: paddingLabel,
//           child: Text(
//             "จำนวนครั้งกระทำผิด",
//             style: textStyleLabel,
//           ),
//         ),
//         Container(
//           padding: paddingData,
//           child: Text(
//             widget.indicmentDetail.MISTREAT_NO.toString(),
//             style: textStyleData,
//           ),
//         ),
//         Container(
//           width: ((size.width * 75) / 100) / 2,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "ยอดชำระ",
//                   style: textStyleLabel,
//                 ),
//               ),
//               TextField(
//                 focusNode: myFocusFinePayment,
//                 controller: editFinePayment,
//                 keyboardType: TextInputType.number,
//                 textCapitalization: TextCapitalization.words,
//                 style: textStyleData,
//                 decoration: InputDecoration(border: InputBorder.none, errorText: IsErrorFine ? "กรุณาปรับตามอะตราที่กำหนดให้ปรับ" : "", errorStyle: textErrorStyle),
//                 onChanged: (text) {
//                   setState(() {
//                     print("IsEmpty : " + text.isNotEmpty.toString());
//                     if (text.isNotEmpty) {
//                       if (widget.itemsCompareArrestMain.FINE_MAX != null) {
//                         if (widget.indicmentDetail.FINE_TOTAL > 0) {
//                           if (double.parse(text.replaceAll(",", "")) > double.parse(widget.itemsCompareArrestMain.FINE_MAX) || double.parse(text.replaceAll(",", "")) < double.parse(widget.itemsCompareArrestMain.FINE_MIN)) {
//                             IsErrorFine = true;
//                           } else {
//                             IsErrorFine = false;
//                           }
//                         } else {
//                           if (double.parse(text.replaceAll(",", "")) > double.parse(widget.itemsCompareArrestMain.FINE_MAX)) {
//                             IsErrorFine = true;
//                           } else {
//                             IsErrorFine = false;
//                           }
//                         }
//                       } else {
//                         if (widget.indicmentDetail.FINE_TOTAL > 0) {
//                           if (double.parse(text.replaceAll(",", "")) < double.parse(widget.itemsCompareArrestMain.FINE_MIN)) {
//                             IsErrorFine = true;
//                           } else {
//                             IsErrorFine = false;
//                           }
//                         }
//                       }
//                     } else {
//                       _totalPayment = 0;
//                       widget.indicmentDetail.FINE_TOTAL = 0;
//                     }
//                   });
//                 },
//               ),
//               _buildLine(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   //************************END********************************

//   Widget _buildLine() {
//     var size = MediaQuery.of(context).size;
//     final double Width = (size.width * 80) / 100;

//     return Container(
//       padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
//       width: Width,
//       height: 1.0,
//       color: Colors.grey[300],
//     );
//   }

//   Widget _buildExpandableContentNotProduct_saved() {
//     double fine_value = 0;

//     if (widget.itemsCompareGuiltbaseFine != null) {
//       if (ItemsMain.FINE_TYPE == 0 || ItemsMain.FINE_TYPE == 1 || ItemsMain.FINE_TYPE == 2) {
//         fine_value = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
//       } else {
//         fine_value = widget.itemsCompareGuiltbaseFine.FINE_RATE;
//       }
//     } else {
//       if (ItemsMain.FINE_TYPE == 0 || ItemsMain.FINE_TYPE == 1 || ItemsMain.FINE_TYPE == 2) {
//         fine_value = 0;
//       } else {
//         fine_value = 0;
//       }
//     }

//     _totalPayment += double.parse(editFinePayment.text.replaceAll(",", ""));

//     var size = MediaQuery.of(context).size;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           padding: paddingLabel,
//           child: Text(
//             "บทลงโทษมาตรา",
//             style: textStyleLabel,
//           ),
//         ),
//         Container(
//           padding: paddingData,
//           child: Text(
//             ItemsMain.SECTION_NAME.toString(),
//             style: textStyleData,
//           ),
//         ),
//         Container(
//           padding: paddingLabel,
//           child: Text(
//             "อัตราโทษ",
//             style: textStyleLabel,
//           ),
//         ),
//         Container(
//           padding: paddingData,
//           child: Text(
//             ItemsMain.PENALTY_DESC.toString(),
//             style: textStyleData,
//           ),
//         ),
//         Container(
//           padding: paddingLabel,
//           child: Text(
//             "อัตราที่กำหนดให้ปรับ",
//             style: textStyleLabel,
//           ),
//         ),
//         ItemsMain.FINE != null
//             ? Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   ItemsMain.FINE.toString(),
//                   style: textStyleData,
//                 ),
//               )
//             : Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "ไม่มีอัตราที่กำหนดให้ปรับ",
//                   style: textStyleData,
//                 ),
//               ),
//         widget.itemsCompareArrestMain.FINE_TYPE != 2
//             ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     padding: paddingLabel,
//                     child: Text(
//                       "จำนวนครั้งกระทำผิด",
//                       style: textStyleLabel,
//                     ),
//                   ),
//                   Container(
//                     padding: paddingData,
//                     child: Text(
//                       widget.indicmentDetail.MISTREAT_NO.toString(),
//                       style: textStyleData,
//                     ),
//                   ),
//                 ],
//               )
//             : Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     padding: paddingLabel,
//                     child: Text(
//                       "ปริมาณของกลาง",
//                       style: textStyleLabel,
//                     ),
//                   ),
//                   Container(
//                     padding: paddingData,
//                     child: Text(
//                       "",
//                       style: textStyleData,
//                     ),
//                   ),
//                 ],
//               ),
//         Container(
//           padding: paddingLabel,
//           child: Text(
//             "ยอดชำระ",
//             style: textStyleLabel,
//           ),
//         ),
//         Container(
//           padding: paddingData,
//           child: Text(
//             formatter.format(widget.indicmentDetail.FINE_TOTAL).toString(),
//             style: textStyleData,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildExpandableContent_saved(int index) {
//     double fine_value = 0;
//     if (ItemsMain.FINE_TYPE == 0 || ItemsMain.FINE_TYPE == 1 || ItemsMain.FINE_TYPE == 2) {
//       fine_value = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
//     } else {
//       fine_value = ItemsMain.CompareProveProduct[index].VAT * widget.itemsCompareGuiltbaseFine.FINE_RATE;
//     }

//     var size = MediaQuery.of(context).size;
//     Widget _buildExpanded(index) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "ของกลางลำดับ" + (index + 1).toString(),
//                   style: textStyleLabel,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding: paddingData,
//             child: Text(
//               // ItemsMain.CompareProveProduct[index].PRODUCT_GROUP_NAME
//               //     .toString(),
//               ItemsMain.CompareProveProduct[index].PRODUCT_DESC.toString(),

//               style: textStyleData,
//             ),
//           ),
//           Container(
//             padding: paddingLabel,
//             child: Text(
//               "ยอดชำระ",
//               style: textStyleLabel,
//             ),
//           ),
//           Container(
//             padding: paddingData,
//             child: Text(
//               formatter.format(ItemsMain.CompareProveProduct[index].Controller.Total).toString(),
//               style: textStyleData,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 width: ((size.width * 75) / 100) / 2,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: paddingLabel,
//                       child: Text(
//                         "มูลค่าภาษี",
//                         style: textStyleLabel,
//                       ),
//                     ),
//                     Container(
//                       padding: paddingData,
//                       child: Text(
//                         ItemsMain.CompareProveProduct[index].Controller.TaxValue.toString(),
//                         style: textStyleData,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: ((size.width * 75) / 100) / 2,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: paddingLabel,
//                       child: Text(
//                         "จำนวนค่าปรับเท่า",
//                         style: textStyleLabel,
//                       ),
//                     ),
//                     Container(
//                       padding: paddingData,
//                       child: Text(
//                         ItemsMain.CompareProveProduct[index].Controller.FineValue.toString(),
//                         style: textStyleData,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 width: ((size.width * 75) / 100) / 2,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: paddingLabel,
//                       child: Text(
//                         "ค่าปรับสุทธิ",
//                         style: textStyleLabel,
//                       ),
//                     ),
//                     Container(
//                       padding: paddingData,
//                       child: Text(
//                         ItemsMain.CompareProveProduct[index].Controller.Payment.toString(),
//                         style: textStyleData,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: ((size.width * 75) / 100) / 2,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: paddingLabel,
//                       child: Text(
//                         "ยอดชำระ",
//                         style: textStyleLabel,
//                       ),
//                     ),
//                     Container(
//                       padding: paddingData,
//                       child: Text(
//                         formatter.format(ItemsMain.CompareProveProduct[index].Controller.Total).toString(),
//                         style: textStyleData,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
//     }

//     Widget _buildCollapsed(int index) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "ของกลางลำดับ" + (index + 1).toString(),
//                   style: textStyleLabel,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding: paddingData,
//             child: Text(
//               // ItemsMain.CompareProveProduct[index].PRODUCT_GROUP_NAME
//               //     .toString(),
//               ItemsMain.CompareProveProduct[index].PRODUCT_DESC.toString(),

//               style: textStyleData,
//             ),
//           ),
//           Container(
//             padding: paddingLabel,
//             child: Text(
//               "ยอดชำระ",
//               style: textStyleLabel,
//             ),
//           ),
//           Container(
//             padding: paddingData,
//             child: Text(
//               formatter.format(ItemsMain.CompareProveProduct[index].Controller.Total).toString(),
//               style: textStyleData,
//             ),
//           ),
//         ],
//       );
//     }

//     return ExpandableNotifier(
//       controller: ItemsMain.CompareProveProduct[index].Controller.expController,
//       child: Stack(
//         children: <Widget>[
//           Expandable(collapsed: _buildCollapsed(index), expanded: _buildExpanded(index)),
//           Align(
//             alignment: Alignment.topRight,
//             child: Builder(builder: (context) {
//               var exp = ExpandableController.of(context);
//               return IconButton(
//                 icon: Icon(
//                   exp.expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                   size: 32.0,
//                   color: Colors.grey,
//                 ),
//                 onPressed: () {
//                   exp.toggle();
//                 },
//               );
//             }),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildContent_saved() {
//     var size = MediaQuery.of(context).size;

//     _totalPayment = 0;
//     if (ItemsMain.CompareProveProduct.length > 0 && widget.itemsCompareArrestMain.FINE_TYPE != 0) {
//       ItemsMain.CompareProveProduct.forEach((f) {
//         _totalPayment += f.Controller.Total;
//       });
//     }

//     List<ItemsListCompareStaff> _items_staff = [];
//     if (widget.itemsListCompareStaff != null) {
//       _items_staff = [];
//       _items_staff.add(widget.itemsListCompareStaff);
//     }

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         ItemsMain.FINE_TYPE == 2 || ItemsMain.FINE_TYPE == 3
//             ? Container(
//                 padding: EdgeInsets.only(bottom: 1),
//                 child: ExpandableNotifier(
//                     child: Container(
//                   width: size.width,
//                   padding: EdgeInsets.all(22.0),
//                   decoration: BoxDecoration(
//                       shape: BoxShape.rectangle,
//                       border: Border(
//                         bottom: BorderSide(color: Colors.grey[300], width: 1.0),
//                       )),
//                   child: Stack(
//                     children: <Widget>[
//                       Expandable(
//                         collapsed: _collap(),
//                         expanded: _expand(),
//                       ),
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: Builder(builder: (context) {
//                           var exp = ExpandableController.of(context);
//                           return IconButton(
//                             icon: Icon(
//                               exp.expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                               size: 32.0,
//                               color: Colors.grey,
//                             ),
//                             onPressed: () {
//                               exp.toggle();
//                             },
//                           );
//                         }),
//                       )
//                     ],
//                   ),
//                 )),
//               )
//             : Container(),
//         widget.itemsCompareArrestMain.FINE_TYPE == 2
//             ? Container(
//                 width: size.width,
//                 padding: EdgeInsets.all(22.0),
//                 decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     border: Border(
//                       bottom: BorderSide(color: Colors.grey[300], width: 1.0),
//                     )),
//                 child: Stack(
//                   children: <Widget>[
//                     _buildExpandableContentFineType2(),
//                   ],
//                 ))
//             : Container(
//                 child: ItemsMain.CompareProveProduct.length > 0 && widget.itemsCompareArrestMain.FINE_TYPE != 0
//                     ? new Container(
//                         child: ListView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: ItemsMain.CompareProveProduct.length,
//                           scrollDirection: Axis.vertical,
//                           shrinkWrap: true,
//                           itemBuilder: (BuildContext context, int index) {
//                             /*return Container(
//                   width: size.width,
//                   padding: EdgeInsets.all(22.0),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.rectangle,
//                       border: Border(
//                         bottom: BorderSide(
//                             color: Colors.grey[300], width: 1.0),
//                       )
//                   ),
//                   child: Stack(
//                     children: <Widget>[

//                       Align(
//                         alignment: Alignment.topRight,
//                         child: Builder(
//                             builder: (context) {
//                               return IconButton(
//                                 icon: Icon(Icons.keyboard_arrow_down, size: 32.0,
//                                   color: Colors.grey,),
//                               );
//                             }
//                         ),
//                       )
//                     ],
//                   )
//               );*/
//                             return Container(
//                                 width: size.width,
//                                 padding: EdgeInsets.all(22.0),
//                                 decoration: BoxDecoration(
//                                     shape: BoxShape.rectangle,
//                                     border: Border(
//                                       bottom: BorderSide(color: Colors.grey[300], width: 1.0),
//                                     )),
//                                 child: Stack(
//                                   children: <Widget>[
//                                     _buildExpandableContent_saved(index),
//                                   ],
//                                 ));
//                           },
//                         ),
//                       )
//                     : Container(
//                         width: size.width,
//                         padding: EdgeInsets.all(22.0),
//                         decoration: BoxDecoration(
//                             shape: BoxShape.rectangle,
//                             border: Border(
//                               bottom: BorderSide(color: Colors.grey[300], width: 1.0),
//                             )),
//                         child: Stack(
//                           children: <Widget>[
//                             _buildExpandableContentNotProduct_saved(),
//                           ],
//                         )),
//               ),
//         widget.itemsListCompareStaff != null
//             ? Container(
//                 padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
//                 child: Container(
//                     width: size.width,
//                     padding: EdgeInsets.all(22.0),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.rectangle,
//                         border: Border(
//                           bottom: BorderSide(color: Colors.grey[300], width: 1.0),
//                         )),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Container(
//                           padding: paddingLabel,
//                           child: Text(
//                             "ผู้มีอำนาจปรับผิดจากบัญชี",
//                             style: textStyleLabel,
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                         Padding(
//                           padding: paddingData,
//                           child: Text(
//                             get_staff_name(_items_staff, widget.itemsListCompareStaff.CONTRIBUTOR_ID),
//                             style: textStyleData,
//                           ),
//                         ),
//                       ],
//                     )),
//               )
//             : Container(),
//         Container(
//           padding: EdgeInsets.only(top: 4.0, bottom: 22.0),
//           child: Container(
//               width: size.width,
//               padding: EdgeInsets.all(22.0),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.rectangle,
//                   border: Border(
//                     bottom: BorderSide(color: Colors.grey[300], width: 1.0),
//                   )),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     padding: paddingLabel,
//                     child: Text(
//                       "รวมยอดชำระ",
//                       style: textStyleLabel,
//                     ),
//                   ),
//                   Padding(
//                     padding: paddingData,
//                     child: Text(
//                       formatter.format(_totalPayment).toString() + "\t\t\t\t\tบาท",
//                       style: textStyleData,
//                     ),
//                   ),
//                 ],
//               )),
//         ),
//       ],
//     );
//   }

//   void _showCheckedEmptyAlertDialog(context, text) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return _cupertinoSearchEmpty(context, text);
//       },
//     );
//   }

//   CupertinoAlertDialog _cupertinoSearchEmpty(mContext, text) {
//     TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
//     TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
//     return new CupertinoAlertDialog(
//         content: new Padding(
//           padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
//           child: Text(
//             text,
//             style: TitleStyle,
//           ),
//         ),
//         actions: <Widget>[
//           new CupertinoButton(
//               onPressed: () {
//                 Navigator.pop(mContext);
//               },
//               child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
//         ]);
//   }

//   void onSaved() async {
//     bool hasChange = false;
//     if (widget.itemsCompareGuiltbaseFine != null) {
//       ItemsMain.CompareProveProduct.forEach((item) {
//         if (double.parse(item.Controller.editTaxValueDouble.text) != widget.itemsCompareGuiltbaseFine.FINE_RATE) {
//           hasChange = true;
//         }
//       });
//       if (double.parse(editFinePayment.text.replaceAll(",", "")) != widget.itemsCompareGuiltbaseFine.FINE_AMOUNT) {
//         hasChange = true;
//       }
//     } else {
//       hasChange = false;
//     }

//     if (widget.itemsCompareGuiltbaseFine != null) {
//       if (editPresidentCommittee.text.isEmpty && Checkedboxna == true && hasChange) {
//         _showCheckedEmptyAlertDialog(context, 'กรุณากรอกชื่อผู้มีอำนาจหากทำการเเก้ไขข้อมูล');
//       } else if (ItemsMain.CompareProveProduct.length == 0 && double.parse(editFinePayment.text.replaceAll(",", "")) != widget.indicmentDetail.FINE_TOTAL && editPresidentCommittee.text.isEmpty) {
//         _showCheckedEmptyAlertDialog(context, 'กรุณากรอกชื่อผู้มีอำนาจหากทำการเเก้ไขข้อมูล');
//       } else {
//         showDialog(
//             barrierDismissible: false,
//             context: context,
//             builder: (BuildContext context) {
//               return Center(
//                 child: CupertinoActivityIndicator(),
//               );
//             });
//         await onLoadAction();
//         Navigator.pop(context);

//         setState(() {
//           _onSaved = true;
//           _onFinish = true;

//           widget.indicmentDetail.IsDetailFineComplete = true;

//           double sum_total = 0;
//           if (ItemsMain.CompareProveProduct.length > 0 && widget.itemsCompareArrestMain.FINE_TYPE != 0) {
//             if (ItemsMain.FINE_TYPE == 2) {
//               sum_total = double.parse(editFinePayment.text.replaceAll(",", ""));
//             } else {
//               ItemsMain.CompareProveProduct.forEach((item) {
//                 item.Controller.TaxValue = double.parse(item.Controller.editTaxValue.text.replaceAll(",", ""));
//                 item.Controller.FineValue = double.parse(item.Controller.editTaxValueDouble.text.replaceAll(",", ""));
//                 item.Controller.Payment = double.parse(item.Controller.editFineValue.text.replaceAll(",", ""));
//                 item.Controller.Total = double.parse(item.Controller.editPayment.text.replaceAll(",", ""));
//                 sum_total += item.Controller.Total;
//               });
//             }
//           } else {
//             sum_total = double.parse(editFinePayment.text.replaceAll(",", ""));
//           }

//           widget.indicmentDetail.FINE_TOTAL = sum_total;

//           ItemsCompareMapFineDetail itemsCompareMapFineDetail = new ItemsCompareMapFineDetail(itemsCompareListIndicmentDetail: widget.indicmentDetail, itemsListEvidenceGetStaff: itemsListEvidenceStaff.length > 0 ? itemsListEvidenceStaff[0] : null);

//           //Navigator.pop(context, widget.indicmentDetail);
//           Navigator.pop(context, itemsCompareMapFineDetail);

//           //เปลี่ยนสถานะเป็น active
//           /*ItemsMain.IsActive=true;

//       ItemsMain.Descriptions = new ItemsEvidenceDescription(
//           30,
//           1,
//           3000,
//           dropdownValueTaxUnit,
//           0,
//           0,
//           0,
//           1220.0000,
//           149.0001,
//           22,
//           dropdownValueRemainingEvidenceCountUnit,
//           500,
//           dropdownValueRemainingEvidenceVolumnUnit,
//           editRemainingEvidenceComment.text,
//           editProveDescription.text,
//           editLabResult.text,
//           _arrItemsImageFile
//       );*/
//         });
//       }
//     } else {
//       showDialog(
//           barrierDismissible: false,
//           context: context,
//           builder: (BuildContext context) {
//             return Center(
//               child: CupertinoActivityIndicator(),
//             );
//           });
//       await onLoadAction();
//       Navigator.pop(context);

//       setState(() {
//         _onSaved = true;
//         _onFinish = true;

//         widget.indicmentDetail.IsDetailFineComplete = true;

//         double sum_total = 0;
//         if (ItemsMain.CompareProveProduct.length > 0 && widget.itemsCompareArrestMain.FINE_TYPE != 0) {
//           if (ItemsMain.FINE_TYPE == 2) {
//             sum_total = double.parse(editFinePayment.text.replaceAll(",", ""));
//           } else {
//             ItemsMain.CompareProveProduct.forEach((item) {
//               item.Controller.TaxValue = double.parse(item.Controller.editTaxValue.text.replaceAll(",", ""));
//               item.Controller.FineValue = double.parse(item.Controller.editTaxValueDouble.text.replaceAll(",", ""));
//               item.Controller.Payment = double.parse(item.Controller.editFineValue.text.replaceAll(",", ""));
//               item.Controller.Total = double.parse(item.Controller.editPayment.text.replaceAll(",", ""));
//               sum_total += item.Controller.Total;
//             });
//           }
//         } else {
//           sum_total = double.parse(editFinePayment.text.replaceAll(",", ""));
//         }

//         widget.indicmentDetail.FINE_TOTAL = sum_total;

//         ItemsCompareMapFineDetail itemsCompareMapFineDetail = new ItemsCompareMapFineDetail(itemsCompareListIndicmentDetail: widget.indicmentDetail, itemsListEvidenceGetStaff: itemsListEvidenceStaff.length > 0 ? itemsListEvidenceStaff[0] : null);

//         //Navigator.pop(context, widget.indicmentDetail);
//         Navigator.pop(context, itemsCompareMapFineDetail);

//         //เปลี่ยนสถานะเป็น active
//         /*ItemsMain.IsActive=true;

//       ItemsMain.Descriptions = new ItemsEvidenceDescription(
//           30,
//           1,
//           3000,
//           dropdownValueTaxUnit,
//           0,
//           0,
//           0,
//           1220.0000,
//           149.0001,
//           22,
//           dropdownValueRemainingEvidenceCountUnit,
//           500,
//           dropdownValueRemainingEvidenceVolumnUnit,
//           editRemainingEvidenceComment.text,
//           editProveDescription.text,
//           editLabResult.text,
//           _arrItemsImageFile
//       );*/
//       });
//     }
//   }

//   Future<bool> onLoadAction() async {
//     await new Future.delayed(const Duration(seconds: 1));
//     return true;
//   }

//   //เมื่อกด popup แสดงการแก้ไขหรือลบ
//   void choiceAction(Constants constants) {
//     setState(() {
//       if (constants.text.endsWith("แก้ไข")) {
//         _onSaved = false;

//         if (widget.itemsListCompareStaff != null) {
//           List<ItemsListCompareStaff> _items = [];
//           _items.add(widget.itemsListCompareStaff);

//           editPresidentCommittee.text = get_staff_name(_items, widget.itemsListCompareStaff.CONTRIBUTOR_ID);
//           Checkedboxna = true;
//         }
//         //setInitDataTextField(null, widget.itemsCompareGuiltbaseFine.FINE_RATE);
//       }
//     });
//   }

//   //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน cancel dialog
//   CupertinoAlertDialog _createCupertinoCancelAlertDialog(mContext) {
//     return new CupertinoAlertDialog(
//         content: new Padding(
//           padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
//           child: Text(
//             "ยืนยันการยกเลิกข้อมูลทั้งหมด.",
//             style: TitleStyle,
//           ),
//         ),
//         actions: <Widget>[
//           new CupertinoButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: new Text('ยกเลิก', style: ButtonCancelStyle)),
//           new CupertinoButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.pop(mContext, "Back");
//               },
//               child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
//         ]);
//   }

//   //แสดง dialog ยกเลิกรายการ
//   void _showCancelAlertDialog(context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return _createCupertinoCancelAlertDialog(context);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new WillPopScope(
//       onWillPop: () {
//         //
//       },
//       child: Scaffold(
//           backgroundColor: Colors.grey[200],
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(60.0), // here the desired height
//             child: AppBar(
//               title: Text(
//                 "รายละเอียดค่าปรับ",
//                 style: styleTextAppbar,
//               ),
//               actions: <Widget>[
//                 _onSaved
//                     ? (_onSave
//                         ? new FlatButton(
//                             onPressed: () {
//                               setState(() {
//                                 _onSaved = true;
//                                 _onSave = false;
//                                 _onEdited = false;
//                               });
//                               //TabScreenArrest1().createAcceptAlert(context);
//                             },
//                             child: Text('บันทึก', style: appBarStyle))
//                         : PopupMenuButton<Constants>(
//                             onSelected: choiceAction,
//                             icon: Icon(
//                               Icons.more_vert,
//                               color: Colors.white,
//                             ),
//                             itemBuilder: (BuildContext context) {
//                               return constants.map((Constants contants) {
//                                 return PopupMenuItem<Constants>(
//                                   value: contants,
//                                   child: Row(
//                                     children: <Widget>[
//                                       Padding(
//                                         padding: EdgeInsets.only(right: 4.0),
//                                         child: Icon(
//                                           contants.icon,
//                                           color: Colors.grey[400],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(left: 4.0),
//                                         child: Text(contants.text, style: TextStyle(fontFamily: FontStyles().FontFamily)),
//                                       )
//                                     ],
//                                   ),
//                                 );
//                               }).toList();
//                             },
//                           ))
//                     : new FlatButton(
//                         onPressed: () {
//                           onSaved();
//                         },
//                         child: Text('บันทึก', style: appBarStyle)),
//               ],
//               centerTitle: true,
//               elevation: 0.0,
//               leading: IconButton(
//                   icon: Icon(Icons.arrow_back_ios, color: Colors.white),
//                   onPressed: () {
//                     if (_onSaved) {
//                       Navigator.pop(context, "Back");
//                     } else {
//                       _showCancelAlertDialog(context);
//                     }
//                   }),
//             ),
//           ),
//           body: Stack(
//             children: <Widget>[
//               BackgroundContent(),
//               Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       //height: 34.0,
//                       decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           border: Border(
//                             top: BorderSide(color: Colors.grey[300], width: 1.0),
//                             //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
//                           )),
//                       /*child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: new Text(
//                         'ILG60_B_04_00_06_00', style: textStylePageName,),
//                     )
//                   ],
//                 ),*/
//                     ),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: _onSaved ? _buildContent_saved() : _buildContent(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     );
//   }

//   _navigateSearchStaff(BuildContext context, int CONTRIBUTOR_ID) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => TabScreenSearchStaff(CONTRIBUTOR_ID: CONTRIBUTOR_ID)),
//     );

//     if (result.toString() != "back") {
//       var Item = result;
//       /*if (_onEdited) {
//         if (itemMain.EvidenceInStaff.length > 0) {
//           for(int i=0;i<itemMain.EvidenceInStaff.length;i++){
//             if (Item.CONTRIBUTOR_ID == itemMain.EvidenceInStaff[i].CONTRIBUTOR_ID) {
//               itemMain.EvidenceInStaff[i]=Item;
//             }
//           }
//         }
//         print(itemMain.EvidenceInStaff.length);
//       } else {
//         if (itemsListEvidenceStaff.length > 0) {
//           if(itemsListEvidenceStaff.where((food) => food.CONTRIBUTOR_ID==(Item.CONTRIBUTOR_ID)).toList().length>0){
//             for(int i=0;i<itemsListEvidenceStaff.length;i++){
//               if(Item.CONTRIBUTOR_ID==itemsListEvidenceStaff[i].CONTRIBUTOR_ID){
//                 itemsListEvidenceStaff[i] = Item;
//               }
//             }
//           }else{
//             itemsListEvidenceStaff.add(Item);
//           }
//         }else{
//           itemsListEvidenceStaff.add(Item);
//         }
//         print(itemsListEvidenceStaff.length);
//       }*/
//       if (itemsListEvidenceStaff.length > 0) {
//         if (itemsListEvidenceStaff.where((food) => food.CONTRIBUTOR_ID == (Item.CONTRIBUTOR_ID)).toList().length > 0) {
//           for (int i = 0; i < itemsListEvidenceStaff.length; i++) {
//             if (Item.CONTRIBUTOR_ID == itemsListEvidenceStaff[i].CONTRIBUTOR_ID) {
//               itemsListEvidenceStaff[i] = Item;
//             }
//           }
//         } else {
//           itemsListEvidenceStaff.add(Item);
//         }
//       } else {
//         itemsListEvidenceStaff.add(Item);
//       }

//       print(itemsListEvidenceStaff.length);
//       editPresidentCommittee.text = get_staff_name(itemsListEvidenceStaff, 34);
//     }
//   }

//   String get_staff_name(var Items, int CONTRIBUTOR_ID) {
//     String name;
//     Items.forEach((item) {
//       if (item.CONTRIBUTOR_ID == CONTRIBUTOR_ID) {
//         name = item.TITLE_SHORT_NAME_TH + item.FIRST_NAME + " " + item.LAST_NAME;
//       }
//     });
//     return name;
//   }

//   //FINE_TYPE = 2
//   ExpandableController expControllerFineType2 = new ExpandableController();
//   Widget _buildExpandableContentFineType2() {
//     double fine_value = 0;
//     print(ItemsMain.FINE_TYPE.toString() + " : " + widget.indicmentDetail.FINE_TOTAL.toString());
//     if (ItemsMain.FINE_TYPE == 0 || ItemsMain.FINE_TYPE == 1 || ItemsMain.FINE_TYPE == 2) {
//       if (ItemsMain.FINE_TYPE == 2) {
//         if (editFinePayment.text.isNotEmpty) {
//           fine_value = /*widget.indicmentDetail.FINE_TOTAL*/ double.parse(editFinePayment.text.replaceAll(",", ""));
//         }
//       } else {
//         fine_value = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
//       }
//     } else {
//       /*fine_value = ItemsMain.CompareProveProduct[index].VAT *
//           widget.itemsCompareGuiltbaseFine.FINE_RATE;*/
//     }
//     var size = MediaQuery.of(context).size;

//     String _product = "";
//     double volumn = 0;
//     String volumn_unit = "";
//     int i = 0;
//     ItemsMain.CompareProveProduct.forEach((item) {
//       i++;
//       _product += i.toString() + ". " + item.PRODUCT_DESC.toString() + "\n";
//       volumn += item.VOLUMN;
//       volumn_unit = item.VOLUMN_UNIT.toString();
//     });
//     _totalPayment = fine_value;

//     //editFinePayment.text =formatter.format(fine_value).toString();

//     Widget _buildExpanded() {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "ของกลาง ",
//                   style: textStyleLabel,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding: paddingData,
//             child: Text(
//               _product,
//               style: textStyleData,
//             ),
//           ),
//           Container(
//             padding: paddingLabel,
//             child: Text(
//               "ปริมาณของกลางรวม",
//               style: textStyleLabel,
//             ),
//           ),
//           Container(
//             padding: paddingData,
//             child: Text(
//               volumn.toString() + " " + volumn_unit,
//               style: textStyleData,
//             ),
//           ),
//           _onSaved
//               ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: paddingLabel,
//                       child: Text(
//                         "ยอดชำระ",
//                         style: textStyleLabel,
//                       ),
//                     ),
//                     Container(
//                       padding: paddingData,
//                       child: Text(
//                         formatter.format(fine_value).toString(),
//                         style: textStyleData,
//                       ),
//                     )
//                   ],
//                 )
//               : Container(
//                   width: ((size.width * 75) / 100) / 2,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         padding: paddingLabel,
//                         child: Text(
//                           "ยอดชำระ",
//                           style: textStyleLabel,
//                         ),
//                       ),
//                       TextField(
//                         focusNode: myFocusFinePayment,
//                         controller: editFinePayment,
//                         keyboardType: TextInputType.number,
//                         textCapitalization: TextCapitalization.words,
//                         style: textStyleData,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           errorText: IsErrorFine ? "กรุณาปรับตามอะตราที่กำหนดให้ปรับ" : "",
//                           errorStyle: textErrorStyle,
//                         ),
//                         onChanged: (text) {
//                           setState(() {
//                             print("IsEmpty : " + text.isNotEmpty.toString());
//                             if (text.isNotEmpty) {
//                               if (widget.itemsCompareArrestMain.FINE_MAX != null) {
//                                 if (widget.indicmentDetail.FINE_TOTAL > 0) {
//                                   if (double.parse(text.replaceAll(",", "")) > double.parse(widget.itemsCompareArrestMain.FINE_MAX) || double.parse(text.replaceAll(",", "")) < double.parse(widget.itemsCompareArrestMain.FINE_MIN)) {
//                                     IsErrorFine = true;
//                                   } else {
//                                     IsErrorFine = false;
//                                   }
//                                 } else {
//                                   if (double.parse(text.replaceAll(",", "")) > double.parse(widget.itemsCompareArrestMain.FINE_MAX)) {
//                                     IsErrorFine = true;
//                                   } else {
//                                     IsErrorFine = false;
//                                   }
//                                 }
//                               } else {
//                                 if (widget.indicmentDetail.FINE_TOTAL > 0) {
//                                   if (double.parse(text.replaceAll(",", "")) < double.parse(widget.itemsCompareArrestMain.FINE_MIN)) {
//                                     IsErrorFine = true;
//                                   } else {
//                                     IsErrorFine = false;
//                                   }
//                                 }
//                               }
//                             } else {
//                               _totalPayment = 0;
//                               widget.indicmentDetail.FINE_TOTAL = 0;
//                             }
//                           });
//                         },
//                       ),
//                       _buildLine(),
//                     ],
//                   ),
//                 ),
//         ],
//       );
//     }

//     Widget _buildCollapsed() {
//       /*double fine_value = 0;
//       if (ItemsMain.FINE_TYPE == 0 ||
//           ItemsMain.FINE_TYPE == 1 ||
//           ItemsMain.FINE_TYPE == 2) {
//         if(ItemsMain.FINE_TYPE==2){
//           fine_value = widget.indicmentDetail.FINE_TOTAL;
//         }else{
//           fine_value = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
//         }
//       } else {
//        */ /* fine_value = ItemsMain.CompareProveProduct[index].VAT *
//             widget.itemsCompareGuiltbaseFine.FINE_RATE;*/ /*
//       }

//       String _product = "";
//       int i = 0;
//       ItemsMain.CompareProveProduct.forEach((item){
//         i++;
//         _product +=i.toString()+". "+new SetProductName(item).PRODUCT_NAME.toString();
//       });*/

//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 padding: paddingLabel,
//                 child: Text(
//                   "ของกลาง ",
//                   style: textStyleLabel,
//                 ),
//               ),
//               Container(
//                 padding: paddingData,
//                 child: Text(
//                   " " + ItemsMain.CompareProveProduct.length.toString() + " รายการ",
//                   style: textStyleData,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding: paddingLabel,
//             child: Text(
//               "ยอดชำระ",
//               style: textStyleLabel,
//             ),
//           ),
//           Container(
//             padding: paddingData,
//             child: Text(
//               formatter.format(fine_value).toString(),
//               style: textStyleData,
//             ),
//           ),
//         ],
//       );
//     }

//     return ExpandableNotifier(
//       controller: expControllerFineType2,
//       child: Stack(
//         children: <Widget>[
//           Expandable(collapsed: _buildCollapsed(), expanded: _buildExpanded()),
//           Align(
//             alignment: Alignment.topRight,
//             child: Builder(builder: (context) {
//               var exp = ExpandableController.of(context);
//               return IconButton(
//                 icon: Icon(
//                   exp.expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                   size: 32.0,
//                   color: Colors.grey,
//                 ),
//                 onPressed: () {
//                   exp.toggle();
//                 },
//               );
//             }),
//           )
//         ],
//       ),
//     );
//   }
}

class Constants {
  const Constants({this.text, this.icon});

  final String text;
  final IconData icon;
}

const List<Constants> constants = const <Constants>[
  const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
];
