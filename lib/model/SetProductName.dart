import 'package:intl/intl.dart';

class SetProductName {
  var ItemsProduct;
  String PRODUCT_NAME;
  String PRODUCT_NAME_PROVE;

  SetProductName(this.ItemsProduct) {
    _setName(this.ItemsProduct);
  }

  void _setName(item) {
    final formatter = new NumberFormat("#,##0.000");

    String product_name = "";
    //String product_name_prove="";

    if (item.PRODUCT_CATEGORY_ID == null) {
      product_name =
          item.PRODUCT_GROUP_NAME.toString()
              + ((item.PRODUCT_BRAND_NAME_TH != null
              ? item.PRODUCT_BRAND_NAME_TH
              : item.PRODUCT_BRAND_NAME_EN) != null
              ? (" ยี่ห้อ" + (item.PRODUCT_BRAND_NAME_TH != null
              ? item.PRODUCT_BRAND_NAME_TH
              : item.PRODUCT_BRAND_NAME_EN))
              : "")
              + (item.PRODUCT_SUBBRAND_NAME_TH != null ? item
              .PRODUCT_SUBBRAND_NAME_TH : item.PRODUCT_SUBBRAND_NAME_EN != null
              ? (" " + (item.PRODUCT_SUBBRAND_NAME_TH != null ? item
              .PRODUCT_SUBBRAND_NAME_TH : item.PRODUCT_SUBBRAND_NAME_EN))
              : "")
              + (item.PRODUCT_MODEL_NAME_TH != null
              ? (" รุ่น" + item.PRODUCT_MODEL_NAME_TH)
              : "") + " ขนาด " + item.SIZES.toString() + " " +
              item.SIZES_UNIT.toString();

      /*product_name_prove = item.PRODUCT_GROUP_NAME.toString()
          +((item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN)!=null
              ?(" ยี่ห้อ" +(item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN))
              :"")
          + (item.SIZES!=null?" ขนาด " + item.SIZES.toString():"") +" "+ item.SIZES_UNIT.toString();*/
    } else {
      if (item.PRODUCT_GROUP_ID != null) {

      }
      if (item.PRODUCT_GROUP_ID == 13) {
        try {
          product_name = item.PRODUCT_CATEGORY_NAME.toString()
              + (item.PRODUCT_TYPE_NAME != null ? (" ชนิด" +
                  item.PRODUCT_TYPE_NAME.toString()) : "")
              + ((item.PRODUCT_BRAND_NAME_TH != null
                  ? item.PRODUCT_BRAND_NAME_TH
                  : item.PRODUCT_BRAND_NAME_EN) != null
                  ? (" ยี่ห้อ" + (item.PRODUCT_BRAND_NAME_TH != null ? item
                  .PRODUCT_BRAND_NAME_TH : item.PRODUCT_BRAND_NAME_EN))
                  : "")
              + (item.PRODUCT_SUBBRAND_NAME_TH != null ? item
                  .PRODUCT_SUBBRAND_NAME_TH : item.PRODUCT_SUBBRAND_NAME_EN !=
                  null
                  ? (" " + (item.PRODUCT_SUBBRAND_NAME_TH != null ? item
                  .PRODUCT_SUBBRAND_NAME_TH : item.PRODUCT_SUBBRAND_NAME_EN))
                  : "")
              + (item.PRODUCT_MODEL_NAME_TH != null
                  ? (" รุ่น" + item.PRODUCT_MODEL_NAME_TH)
                  : "") + " ขนาด " + formatter.format(item.SIZES).toString() +
              " " + item.SIZES_UNIT.toString();
        } catch (_) {
          product_name = item.PRODUCT_CATEGORY_NAME.toString()
              + (item.PRODUCT_TYPE_NAME != null ? (" ชนิด" +
                  item.PRODUCT_TYPE_NAME.toString()) : "")
              + ((item.PRODUCT_BRAND_NAME_TH != null
                  ? item.PRODUCT_BRAND_NAME_TH
                  : item.PRODUCT_BRAND_NAME_EN) != null
                  ? (" ยี่ห้อ" + (item.PRODUCT_BRAND_NAME_TH != null ? item
                  .PRODUCT_BRAND_NAME_TH : item.PRODUCT_BRAND_NAME_EN))
                  : "")
              + (item.PRODUCT_SUBBRAND_NAME_TH != null ? item
                  .PRODUCT_SUBBRAND_NAME_TH : item.PRODUCT_SUBBRAND_NAME_EN !=
                  null
                  ? (" " + (item.PRODUCT_SUBBRAND_NAME_TH != null ? item
                  .PRODUCT_SUBBRAND_NAME_TH : item.PRODUCT_SUBBRAND_NAME_EN))
                  : "")
              + (item.PRODUCT_MODEL_NAME_TH != null
                  ? (" รุ่น" + item.PRODUCT_MODEL_NAME_TH)
                  : "");
        }
      } else if (item.PRODUCT_GROUP_ID == 2) {
        product_name =
            item.PRODUCT_GROUP_NAME.toString() +
                (item.PRODUCT_CATEGORY_NAME != null
                    ? " ชนิด" + item.PRODUCT_CATEGORY_NAME.toString() : "")
                + ((item.PRODUCT_BRAND_NAME_TH != null ? item
                .PRODUCT_BRAND_NAME_TH : item.PRODUCT_BRAND_NAME_EN) != null
                ? (" ยี่ห้อ" + (item.PRODUCT_BRAND_NAME_TH != null
                ? item.PRODUCT_BRAND_NAME_TH
                : item.PRODUCT_BRAND_NAME_EN))
                : "")
                + (item.PRODUCT_SUBBRAND_NAME_TH != null ? item
                .PRODUCT_SUBBRAND_NAME_TH : item.PRODUCT_SUBBRAND_NAME_EN !=
                null
                ? (" " + (item.PRODUCT_SUBBRAND_NAME_TH != null ? item
                .PRODUCT_SUBBRAND_NAME_TH : item.PRODUCT_SUBBRAND_NAME_EN))
                : "")
                + (item.PRODUCT_MODEL_NAME_TH != null
                ? (" รุ่น" + item.PRODUCT_MODEL_NAME_TH)
                : "") + " ขนาด " + formatter.format(item.SIZES).toString() + " " +
                item.SIZES_UNIT.toString();
      } else {
        product_name =
            item.PRODUCT_GROUP_NAME.toString() +
                (item.PRODUCT_CATEGORY_NAME != null
                    ? " ชนิด" + item.PRODUCT_CATEGORY_NAME.toString() : "")
                + ((item.PRODUCT_BRAND_NAME_TH != null ? item
                .PRODUCT_BRAND_NAME_TH : item.PRODUCT_BRAND_NAME_EN) != null
                ? (" ยี่ห้อ" + (item.PRODUCT_BRAND_NAME_TH != null
                ? item.PRODUCT_BRAND_NAME_TH
                : item.PRODUCT_BRAND_NAME_EN))
                : "")
                + (item.PRODUCT_SUBBRAND_NAME_TH != null ? item
                .PRODUCT_SUBBRAND_NAME_TH : item.PRODUCT_SUBBRAND_NAME_EN !=
                null
                ? (" " + (item.PRODUCT_SUBBRAND_NAME_TH != null ? item
                .PRODUCT_SUBBRAND_NAME_TH : item.PRODUCT_SUBBRAND_NAME_EN))
                : "")
                + (item.PRODUCT_MODEL_NAME_TH != null
                ? (" รุ่น" + item.PRODUCT_MODEL_NAME_TH)
                : "") + " ขนาด " + item.SIZES.toString() + " " +
                item.SIZES_UNIT.toString();
      }
    }

    PRODUCT_NAME = product_name;
  }


}