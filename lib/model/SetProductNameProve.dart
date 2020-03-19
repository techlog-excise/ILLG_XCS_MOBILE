import 'package:intl/intl.dart';

class SetProductProveName {
  var ItemsProduct;
  String PRODUCT_PROVE_NAME;
  SetProductProveName(this.ItemsProduct){
    _setName(this.ItemsProduct);
  }

  void _setName(item) {
    final formatter = new NumberFormat("#,##0.000");

    String product_name="";
    if(item.PRODUCT_CATEGORY_ID==null) {
      if(item.PRODUCT_GROUP_ID==13||item.PRODUCT_GROUP_ID==2) {
        product_name =
            item.PRODUCT_GROUP_NAME.toString()
                + ((item.PRODUCT_BRAND_NAME_TH != null
                ? item.PRODUCT_BRAND_NAME_TH
                : item.PRODUCT_BRAND_NAME_EN) != null
                ? (" ยี่ห้อ" + (item.PRODUCT_BRAND_NAME_TH != null
                ? item.PRODUCT_BRAND_NAME_TH
                : item.PRODUCT_BRAND_NAME_EN))
                : "")
                + (" จำนวน " + item.QUANTITY.toInt().toString() + " " +
                item.QUANTITY_UNIT.toString())
                + " ขนาด " + formatter.format(item.SIZES).toString() + " " +
                item.SIZES_UNIT.toString()
                + ((item.REMARK == null || item.REMARK
                .toString()
                .isEmpty) ? "" : " (...)".toString());
      }else{
        product_name =
            item.PRODUCT_GROUP_NAME.toString()
                + ((item.PRODUCT_BRAND_NAME_TH != null
                ? item.PRODUCT_BRAND_NAME_TH
                : item.PRODUCT_BRAND_NAME_EN) != null
                ? (" ยี่ห้อ" + (item.PRODUCT_BRAND_NAME_TH != null
                ? item.PRODUCT_BRAND_NAME_TH
                : item.PRODUCT_BRAND_NAME_EN))
                : "")
                + (" จำนวน " + item.QUANTITY.toInt().toString() + " " +
                item.QUANTITY_UNIT.toString())
                + " ขนาด " + formatter.format(item.SIZES).toString() + " " +
                item.SIZES_UNIT.toString()
                + ((item.REMARK == null || item.REMARK
                .toString()
                .isEmpty) ? "" : " (...)".toString());
      }
    }else{
      if(item.PRODUCT_GROUP_ID!=null){

      }
      if(item.PRODUCT_GROUP_ID==13){
        product_name = item.PRODUCT_CATEGORY_NAME.toString()
            +((item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN)!=null
                ?(" ยี่ห้อ" +(item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN))
                :"")
            +(" จำนวน "+item.QUANTITY.toInt().toString()+" "+item.QUANTITY_UNIT.toString())
            + " ขนาด " + formatter.format(item.SIZES).toString() +" "+ item.SIZES_UNIT.toString()
            + ((item.REMARK==null||item.REMARK.toString().isEmpty)?"":" (...)".toString());
      }else if(item.PRODUCT_GROUP_ID==2){
        product_name =
            item.PRODUCT_GROUP_NAME.toString()
                +((item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN)!=null
                ?(" ยี่ห้อ" +(item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN))
                :"")
                +(" จำนวน "+item.QUANTITY.toInt().toString()+" "+item.QUANTITY_UNIT.toString())
                + " ขนาด " + formatter.format(item.SIZES).toString() +" "+ item.SIZES_UNIT.toString()
                + ((item.REMARK==null||item.REMARK.toString().isEmpty)?"":" (...)".toString());
      }else{
        product_name =
            item.PRODUCT_GROUP_NAME.toString()
                +((item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN)!=null
                ?(" ยี่ห้อ" +(item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN))
                :"")
                +(" จำนวน "+item.QUANTITY.toInt().toString()+" "+item.QUANTITY_UNIT.toString())
                + " ขนาด " + item.SIZES.toString() +" "+ item.SIZES_UNIT.toString()
                + ((item.REMARK==null||item.REMARK.toString().isEmpty)?"":" (...)".toString());
      }
    }

    PRODUCT_PROVE_NAME =  product_name;
  }


}