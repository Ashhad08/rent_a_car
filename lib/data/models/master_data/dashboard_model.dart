class DashboardModel {
  final int? allVehicles;
  final int? availableVehicles;
  final int? allCustomers;
  final int? onRentVehicles;

  DashboardModel({
    this.allVehicles,
    this.availableVehicles,
    this.allCustomers,
    this.onRentVehicles,
  });

  DashboardModel copyWith({
    int? allVehicles,
    int? availableVehicles,
    int? allCustomers,
    int? onRentVehicles,
  }) =>
      DashboardModel(
        allVehicles: allVehicles ?? this.allVehicles,
        availableVehicles: availableVehicles ?? this.availableVehicles,
        allCustomers: allCustomers ?? this.allCustomers,
        onRentVehicles: onRentVehicles ?? this.onRentVehicles,
      );

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        allVehicles: json["allVehicles"],
        availableVehicles: json["availableVehicles"],
        allCustomers: json["allCustomers"],
        onRentVehicles: json["onRentVehicle"],
      );
}
