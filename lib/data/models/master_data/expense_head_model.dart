class ExpenseHeadModel {
  final String? id;
  final String? expenseHeadName;
  final DateTime? date;
  final int? v;

  ExpenseHeadModel({
    this.id,
    this.expenseHeadName,
    this.date,
    this.v,
  });

  ExpenseHeadModel copyWith({
    String? id,
    String? expenseHeadName,
    DateTime? date,
    int? v,
  }) =>
      ExpenseHeadModel(
        id: id ?? this.id,
        expenseHeadName: expenseHeadName ?? this.expenseHeadName,
        date: date ?? this.date,
        v: v ?? this.v,
      );

  factory ExpenseHeadModel.fromJson(Map<String, dynamic> json) =>
      ExpenseHeadModel(
        id: json["_id"],
        expenseHeadName: json["expenseHeadName"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "expenseHeadID": id,
        "expenseHeadName": expenseHeadName,
      };
}
