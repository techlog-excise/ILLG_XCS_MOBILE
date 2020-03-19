
import 'package:prototype_app_pang/zan/model/person_net_arrest_lawbreaker_relationship.dart';

class ItemsListPersonNetAnalysisMain {
  int LAWBREAKER_ID;
  int PERSON_ID;
  String ARREST_LAWBREAKER_NAME;
  String ARREST_CODE;
  int DOCUMENT_ID;
  int REF_CODE;
  List<ItemsListPersonNetLawbreakerRelationShip> LawbreakerRelationShip;

  ItemsListPersonNetAnalysisMain({
    this.LAWBREAKER_ID,
    this.PERSON_ID,
    this.ARREST_LAWBREAKER_NAME,
    this.ARREST_CODE,
    this.DOCUMENT_ID,
    this.REF_CODE,
    this.LawbreakerRelationShip,
  });
}