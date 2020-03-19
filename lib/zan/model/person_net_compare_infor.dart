
class ItemsListPersonNetCompanyInfor {
  final String COMPANY_REGISTRATION_NO;
  final String COMPANY_FOUND_DATE;
  final String COMPANY_LICENSE_NO;
  final String COMPANY_LICENSE_DATE_FROM;
  final String COMPANY_LICENSE_DATE_TO;
  final String EXCISE_REGISTRATION_NO;
  final String ID_CARD;
  final String COMPANY_NAME;

  ItemsListPersonNetCompanyInfor({
    this.COMPANY_REGISTRATION_NO,
    this.COMPANY_FOUND_DATE,
    this.COMPANY_LICENSE_NO,
    this.COMPANY_LICENSE_DATE_FROM,
    this.COMPANY_LICENSE_DATE_TO,
    this.EXCISE_REGISTRATION_NO,
    this.ID_CARD,
    this.COMPANY_NAME,
  });

  factory ItemsListPersonNetCompanyInfor.fromJson(Map<String, dynamic> js) {
    return ItemsListPersonNetCompanyInfor(
      COMPANY_REGISTRATION_NO: js['COMPANY_REGISTRATION_NO'],
      COMPANY_FOUND_DATE: js['COMPANY_FOUND_DATE'],
      COMPANY_LICENSE_NO: js['COMPANY_LICENSE_NO'],
      COMPANY_LICENSE_DATE_FROM: js['COMPANY_LICENSE_DATE_FROM'],
      COMPANY_LICENSE_DATE_TO: js['COMPANY_LICENSE_DATE_TO'],
      EXCISE_REGISTRATION_NO: js['EXCISE_REGISTRATION_NO'],
      ID_CARD: js['ID_CARD'],
      COMPANY_NAME: js['COMPANY_NAME'],
    );
  }
}