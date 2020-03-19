import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';

class SetProductRewardName {
  var ItemsProduct;
  String PRODUCT_REWARD_NAME;
  SetProductRewardName(this.ItemsProduct){
    _setName(this.ItemsProduct);
  }

  void _setName(item) {
    String product_name="";
    if(item.PRODUCT_CATEGORY_ID==null){
      product_name =
          item.PRODUCT_GROUP_NAME.toString()
              +((item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN)!=null
              ?(" ยี่ห้อ" +(item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN))
              :"");

    }else{
      if(item.PRODUCT_GROUP_ID!=null){

      }
      if(item.PRODUCT_GROUP_ID==13){
        product_name = item.PRODUCT_CATEGORY_NAME.toString()
            +((item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN)!=null
                ?(" ยี่ห้อ" +(item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN))
                :"");
      }else{
        product_name =
            item.PRODUCT_GROUP_NAME.toString()
                +((item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN)!=null
                ?(" ยี่ห้อ" +(item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:item.PRODUCT_BRAND_NAME_EN))
                :"");
      }
    }

    PRODUCT_REWARD_NAME =  product_name;
  }


}