import '../../../configurations/backend_configs.dart';
import '../../../network/network_repository.dart';
import '../../models/booking/booking_list_model.dart';
import '../../models/booking/make_update_booking_model.dart';
import '../../models/response/response_model.dart';

abstract class BaseBookingRepository {
  final BackendConfigs _backendConfigs;

  BackendConfigs get backendConfigs => _backendConfigs;
  final NetworkRepository _networkRepository;

  BaseBookingRepository(
      {required BackendConfigs backendConfigs,
      required NetworkRepository networkRepository})
      : _backendConfigs = backendConfigs,
        _networkRepository = networkRepository;

  NetworkRepository get networkRepository => _networkRepository;

  Future<ResponseModel> createBooking(MakeUpdateBookingModel booking);

  Future<ResponseModel> updateBooking(MakeUpdateBookingModel booking);

  Future<List<BookingListModel>> getPendingBookings();

  Future<List<BookingListModel>> getApprovedBookings();

  Future<List<BookingListModel>> getBookingsByCustomer(String customerId);
}
