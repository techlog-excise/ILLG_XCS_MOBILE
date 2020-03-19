
class ItemsEvidenceStockBalance {
  final int STOCK_ID;
  final int WAREHOUSE_ID;
  final int EVIDENCE_IN_ITEM_ID;
  final double RECEIVE_QTY;
  final String RECEIVE_QTY_UNIT;
  final double RECEIVE_SIZE;
  final String RECEIVE_SIZE_UNIT;
  final double RECEIVE_NET_VOLUMN;
  final String RECEIVE_NET_VOLUMN_UNIT;
  final double BALANCE_QTY;
  final String BALANCE_QTY_UNIT;
  final double BALANCE_SIZE;
  final String BALANCE_SIZE_UNIT;
  final double BALANCE_NET_VOLUMN;
  final String BALANCE_NET_VOLUMN_UNIT;
  final int IS_FINISH;
  final int IS_RECEIVE;

  ItemsEvidenceStockBalance({
    this.STOCK_ID,
    this.WAREHOUSE_ID,
    this.EVIDENCE_IN_ITEM_ID,
    this.RECEIVE_QTY,
    this.RECEIVE_QTY_UNIT,
    this.RECEIVE_SIZE,
    this.RECEIVE_SIZE_UNIT,
    this.RECEIVE_NET_VOLUMN,
    this.RECEIVE_NET_VOLUMN_UNIT,
    this.BALANCE_QTY,
    this.BALANCE_QTY_UNIT,
    this.BALANCE_SIZE,
    this.BALANCE_SIZE_UNIT,
    this.BALANCE_NET_VOLUMN,
    this.BALANCE_NET_VOLUMN_UNIT,
    this.IS_FINISH,
    this.IS_RECEIVE,
  });

  factory ItemsEvidenceStockBalance.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceStockBalance(
      STOCK_ID: json['STOCK_ID'],
      WAREHOUSE_ID: json['WAREHOUSE_ID'],
      EVIDENCE_IN_ITEM_ID: json['EVIDENCE_IN_ITEM_ID'],
      RECEIVE_QTY: json['RECEIVE_QTY'],
      RECEIVE_QTY_UNIT: json['RECEIVE_QTY_UNIT'],
      RECEIVE_SIZE: json['RECEIVE_SIZE'],
      RECEIVE_SIZE_UNIT: json['RECEIVE_SIZE_UNIT'],
      RECEIVE_NET_VOLUMN: json['RECEIVE_NET_VOLUMN'],
      RECEIVE_NET_VOLUMN_UNIT: json['RECEIVE_NET_VOLUMN_UNIT'],
      BALANCE_QTY: json['BALANCE_QTY'],
      BALANCE_QTY_UNIT: json['BALANCE_QTY_UNIT'],
      BALANCE_SIZE: json['BALANCE_SIZE'],
      BALANCE_SIZE_UNIT: json['BALANCE_SIZE_UNIT'],
      BALANCE_NET_VOLUMN: json['BALANCE_NET_VOLUMN'],
      BALANCE_NET_VOLUMN_UNIT: json['BALANCE_NET_VOLUMN_UNIT'],
      IS_FINISH: json['IS_FINISH'],
      IS_RECEIVE: json['IS_RECEIVE'],
    );
  }
}