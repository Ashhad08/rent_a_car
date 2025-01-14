import '../master_data/expense_head_model.dart';

class ExpenseModel {
  final String? id;
  final ExpenseHeadModel? expenseHead;
  final DateTime? date;
  final String? time;
  final String? description;
  final num? totalAmount;
  final DateTime? createdAt;
  final int? v;

  ExpenseModel({
    this.id,
    this.expenseHead,
    this.date,
    this.time,
    this.description,
    this.totalAmount,
    this.createdAt,
    this.v,
  });

  ExpenseModel copyWith({
    String? id,
    ExpenseHeadModel? expenseHead,
    DateTime? date,
    String? time,
    String? description,
    num? totalAmount,
    DateTime? createdAt,
    int? v,
  }) =>
      ExpenseModel(
        id: id ?? this.id,
        expenseHead: expenseHead ?? this.expenseHead,
        date: date ?? this.date,
        time: time ?? this.time,
        description: description ?? this.description,
        totalAmount: totalAmount ?? this.totalAmount,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        id: json["_id"],
        expenseHead: json["expenseHeadID"] == null
            ? null
            : ExpenseHeadModel.fromJson(json["expenseHeadID"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"],
        description: json["description"],
        totalAmount: json["totalAmount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "docID": id,
        "expenseHeadID": expenseHead?.id,
        "date": date?.toIso8601String(),
        "time": time,
        "description": description,
        "totalAmount": totalAmount,
      };
}
