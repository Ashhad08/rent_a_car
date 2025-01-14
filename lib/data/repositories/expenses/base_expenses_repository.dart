import '../../../configurations/backend_configs.dart';
import '../../../network/network_repository.dart';
import '../../models/expense/expense_model.dart';
import '../../models/response/response_model.dart';

abstract class BaseExpensesRepository {
  final BackendConfigs _backendConfigs;

  BackendConfigs get backendConfigs => _backendConfigs;
  final NetworkRepository _networkRepository;

  BaseExpensesRepository(
      {required BackendConfigs backendConfigs,
      required NetworkRepository networkRepository})
      : _backendConfigs = backendConfigs,
        _networkRepository = networkRepository;

  NetworkRepository get networkRepository => _networkRepository;

  Future<ResponseModel> createExpense(ExpenseModel expense);

  Future<ResponseModel> updateExpense(ExpenseModel expense);

  Future<List<ExpenseModel>> getAllExpenses();

  Future<ResponseModel> deleteExpense(String expenseId);

  Future<String> getAutoID();
}
