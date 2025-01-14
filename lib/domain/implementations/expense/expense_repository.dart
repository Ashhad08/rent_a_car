import '../../../data/models/expense/expense_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/repositories/expenses/base_expenses_repository.dart';

class ExpenseRepository extends BaseExpensesRepository {
  ExpenseRepository(
      {required super.backendConfigs, required super.networkRepository});

  @override
  Future<ResponseModel> createExpense(ExpenseModel expense) async {
    try {
      final res = await super.networkRepository.post(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.expense,
                super.backendConfigs.addExpense,
              ],
            ),
            data: expense.toJson(),
          );
      return ResponseModel.fromJson(
        res,
        (data) => null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> deleteExpense(String expenseId) async {
    try {
      final res = await super.networkRepository.post(
        uri: super.backendConfigs.buildUri(
          segments: [
            super.backendConfigs.expense,
            super.backendConfigs.deleteExpense,
          ],
        ),
        data: {
          "expenseID": expenseId,
        },
      );
      return ResponseModel.fromJson(
        res,
        (data) => null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> updateExpense(ExpenseModel expense) async {
    try {
      final res = await super.networkRepository.post(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.expense,
                super.backendConfigs.updateExpense,
              ],
            ),
            data: expense.toJson(),
          );
      return ResponseModel.fromJson(
        res,
        (data) => null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.expense,
          ]));
      return ResponseModel<List<ExpenseModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<ExpenseModel>.from(
                    data!.map((e) => ExpenseModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getAutoID() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.booking,
            super.backendConfigs.randomId,
          ]));
      return ResponseModel<String>.fromJson(
            res,
            (data) => data == null ? '' : data['randomID'] as String,
          ).data ??
          "";
    } catch (e) {
      rethrow;
    }
  }
}
