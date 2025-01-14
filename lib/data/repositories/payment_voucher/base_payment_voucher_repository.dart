import '../../../configurations/backend_configs.dart';
import '../../../network/network_repository.dart';
import '../../models/booking/make_update_booking_model.dart';
import '../../models/payment_voucher/payment_voucher_model.dart';
import '../../models/response/response_model.dart';
import '../../models/vehicle/vehicle_model.dart';

abstract class BasePaymentVoucherRepository {
  final BackendConfigs _backendConfigs;

  BackendConfigs get backendConfigs => _backendConfigs;
  final NetworkRepository _networkRepository;

  BasePaymentVoucherRepository(
      {required BackendConfigs backendConfigs,
      required NetworkRepository networkRepository})
      : _backendConfigs = backendConfigs,
        _networkRepository = networkRepository;

  NetworkRepository get networkRepository => _networkRepository;

  Future<ResponseModel<PaymentReceiptModel>> createVoucher(
      PaymentReceiptModel voucher,
      VehicleModel vehicle,
      MakeUpdateBookingModel booking);

  Future<ResponseModel> updateVoucher(
      PaymentReceiptModel voucher, String bookingId);

  Future<List<PaymentReceiptModel>> getAllPaymentVouchers();
}
