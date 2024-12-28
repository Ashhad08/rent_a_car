import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Vehicle> vehicleFromJson(String str) =>
    List<Vehicle>.from(json.decode(str).map((x) => Vehicle.fromJson(x)));

String vehicleToJson(List<Vehicle> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Vehicle extends Equatable {
  final String? _id;
  final String? _registrationNo;
  final String? _registeredCity;
  final String? _carType;
  final String? _carMake;
  final String? _carModel;
  final String? _yearOfModel;
  final int? _ratePerDay;
  final String? _color;
  final String? _transmissionType;
  final String? _engineCapacity;
  final String? _chassisNo;
  final String? _engineNo;
  final String? _fuelType;
  final String? _fuelTankCapacity;
  final int? _maxSpeed;
  final int? _seatingCapacity;
  final DateTime? _inspectionDate;
  final String? _inspectionMileage;
  final bool? _airConditioner;
  final bool? _heater;
  final bool? _sunRoof;
  final bool? _cdDvd;
  final bool? _frontCamera;
  final bool? _rearCamera;
  final bool? _cigarette;
  final bool? _wheelCup;
  final bool? _spareWheel;
  final bool? _airCompressor;
  final bool? _jackHandle;
  final bool? _wheelPanna;
  final bool? _mudFlaps;
  final bool? _floorMat;
  final List<String>? _photos;
  final bool? _isBooked;
  final bool? _isSaved;
  final int? _v;
  final String? _status;
  final String? _rentReceiptId;
  final String? _fuel;
  final String? _priceVehicle;
  final bool? _documents;
  final int? _balanceAmount;
  final String? _condition;
  final DateTime? _date;
  final String? _time;

  const Vehicle({
    String? id,
    String? registrationNo,
    String? registeredCity,
    String? carType,
    String? carMake,
    String? carModel,
    String? yearOfModel,
    int? ratePerDay,
    String? color,
    String? transmissionType,
    String? engineCapacity,
    String? chassisNo,
    String? engineNo,
    String? fuelType,
    String? fuelTankCapacity,
    int? maxSpeed,
    int? seatingCapacity,
    DateTime? inspectionDate,
    String? inspectionMileage,
    bool? airConditioner,
    bool? heater,
    bool? sunRoof,
    bool? cdDvd,
    bool? frontCamera,
    bool? rearCamera,
    bool? cigarette,
    bool? wheelCup,
    bool? spareWheel,
    bool? airCompressor,
    bool? jackHandle,
    bool? wheelPanna,
    bool? mudFlaps,
    bool? floorMat,
    List<String>? photos,
    bool? isBooked,
    bool? isSaved,
    int? v,
    String? status,
    String? rentReceiptId,
    String? fuel,
    String? priceVehicle,
    bool? documents,
    int? balanceAmount,
    String? condition,
    DateTime? date,
    String? time,
  })  : _id = id,
        _registrationNo = registrationNo,
        _registeredCity = registeredCity,
        _carType = carType,
        _carMake = carMake,
        _carModel = carModel,
        _yearOfModel = yearOfModel,
        _ratePerDay = ratePerDay,
        _color = color,
        _transmissionType = transmissionType,
        _engineCapacity = engineCapacity,
        _chassisNo = chassisNo,
        _engineNo = engineNo,
        _fuelType = fuelType,
        _fuelTankCapacity = fuelTankCapacity,
        _maxSpeed = maxSpeed,
        _seatingCapacity = seatingCapacity,
        _inspectionDate = inspectionDate,
        _inspectionMileage = inspectionMileage,
        _airConditioner = airConditioner,
        _heater = heater,
        _sunRoof = sunRoof,
        _cdDvd = cdDvd,
        _frontCamera = frontCamera,
        _rearCamera = rearCamera,
        _cigarette = cigarette,
        _wheelCup = wheelCup,
        _spareWheel = spareWheel,
        _airCompressor = airCompressor,
        _jackHandle = jackHandle,
        _wheelPanna = wheelPanna,
        _mudFlaps = mudFlaps,
        _floorMat = floorMat,
        _photos = photos,
        _isBooked = isBooked,
        _isSaved = isSaved,
        _v = v,
        _status = status,
        _rentReceiptId = rentReceiptId,
        _fuel = fuel,
        _priceVehicle = priceVehicle,
        _documents = documents,
        _balanceAmount = balanceAmount,
        _condition = condition,
        _date = date,
        _time = time;

  // Getters
  String? get id => _id;

  String? get registrationNo => _registrationNo;

  String? get registeredCity => _registeredCity;

  String? get carType => _carType;

  String? get carMake => _carMake;

  String? get carModel => _carModel;

  String? get yearOfModel => _yearOfModel;

  int? get ratePerDay => _ratePerDay;

  String? get color => _color;

  String? get transmissionType => _transmissionType;

  String? get engineCapacity => _engineCapacity;

  String? get chassisNo => _chassisNo;

  String? get engineNo => _engineNo;

  String? get fuelType => _fuelType;

  String? get fuelTankCapacity => _fuelTankCapacity;

  int? get maxSpeed => _maxSpeed;

  int? get seatingCapacity => _seatingCapacity;

  DateTime? get inspectionDate => _inspectionDate;

  String? get inspectionMileage => _inspectionMileage;

  bool? get airConditioner => _airConditioner;

  bool? get heater => _heater;

  bool? get sunRoof => _sunRoof;

  bool? get cdDvd => _cdDvd;

  bool? get frontCamera => _frontCamera;

  bool? get rearCamera => _rearCamera;

  bool? get cigarette => _cigarette;

  bool? get wheelCup => _wheelCup;

  bool? get spareWheel => _spareWheel;

  bool? get airCompressor => _airCompressor;

  bool? get jackHandle => _jackHandle;

  bool? get wheelPanna => _wheelPanna;

  bool? get mudFlaps => _mudFlaps;

  bool? get floorMat => _floorMat;

  List<String>? get photos => _photos;

  bool? get isBooked => _isBooked;

  bool? get isSaved => _isSaved;

  int? get v => _v;

  String? get status => _status;

  String? get rentReceiptId => _rentReceiptId;

  String? get fuel => _fuel;

  String? get priceVehicle => _priceVehicle;

  bool? get documents => _documents;

  int? get balanceAmount => _balanceAmount;

  String? get condition => _condition;

  DateTime? get date => _date;

  String? get time => _time;

  // Copy method
  Vehicle copyWith({
    String? id,
    String? registrationNo,
    String? registeredCity,
    String? carType,
    String? carMake,
    String? carModel,
    String? yearOfModel,
    int? ratePerDay,
    String? color,
    String? transmissionType,
    String? engineCapacity,
    String? chassisNo,
    String? engineNo,
    String? fuelType,
    String? fuelTankCapacity,
    int? maxSpeed,
    int? seatingCapacity,
    DateTime? inspectionDate,
    String? inspectionMileage,
    bool? airConditioner,
    bool? heater,
    bool? sunRoof,
    bool? cdDvd,
    bool? frontCamera,
    bool? rearCamera,
    bool? cigarette,
    bool? wheelCup,
    bool? spareWheel,
    bool? airCompressor,
    bool? jackHandle,
    bool? wheelPanna,
    bool? mudFlaps,
    bool? floorMat,
    List<String>? photos,
    bool? isBooked,
    bool? isSaved,
    int? v,
    String? status,
    String? rentReceiptId,
    String? fuel,
    String? priceVehicle,
    bool? documents,
    int? balanceAmount,
    String? condition,
    DateTime? date,
    String? time,
  }) =>
      Vehicle(
        id: id ?? _id,
        registrationNo: registrationNo ?? _registrationNo,
        registeredCity: registeredCity ?? _registeredCity,
        carType: carType ?? _carType,
        carMake: carMake ?? _carMake,
        carModel: carModel ?? _carModel,
        yearOfModel: yearOfModel ?? _yearOfModel,
        ratePerDay: ratePerDay ?? _ratePerDay,
        color: color ?? _color,
        transmissionType: transmissionType ?? _transmissionType,
        engineCapacity: engineCapacity ?? _engineCapacity,
        chassisNo: chassisNo ?? _chassisNo,
        engineNo: engineNo ?? _engineNo,
        fuelType: fuelType ?? _fuelType,
        fuelTankCapacity: fuelTankCapacity ?? _fuelTankCapacity,
        maxSpeed: maxSpeed ?? _maxSpeed,
        seatingCapacity: seatingCapacity ?? _seatingCapacity,
        inspectionDate: inspectionDate ?? _inspectionDate,
        inspectionMileage: inspectionMileage ?? _inspectionMileage,
        airConditioner: airConditioner ?? _airConditioner,
        heater: heater ?? _heater,
        sunRoof: sunRoof ?? _sunRoof,
        cdDvd: cdDvd ?? _cdDvd,
        frontCamera: frontCamera ?? _frontCamera,
        rearCamera: rearCamera ?? _rearCamera,
        cigarette: cigarette ?? _cigarette,
        wheelCup: wheelCup ?? _wheelCup,
        spareWheel: spareWheel ?? _spareWheel,
        airCompressor: airCompressor ?? _airCompressor,
        jackHandle: jackHandle ?? _jackHandle,
        wheelPanna: wheelPanna ?? _wheelPanna,
        mudFlaps: mudFlaps ?? _mudFlaps,
        floorMat: floorMat ?? _floorMat,
        photos: photos ?? _photos,
        isBooked: isBooked ?? _isBooked,
        isSaved: isSaved ?? _isSaved,
        v: v ?? _v,
        status: status ?? _status,
        rentReceiptId: rentReceiptId ?? _rentReceiptId,
        fuel: fuel ?? _fuel,
        priceVehicle: priceVehicle ?? _priceVehicle,
        documents: documents ?? _documents,
        balanceAmount: balanceAmount ?? _balanceAmount,
        condition: condition ?? _condition,
        date: date ?? _date,
        time: time ?? _time,
      );

  @override
  List<Object?> get props => [
        _id,
        _registrationNo,
        _registeredCity,
        _carType,
        _carMake,
        _carModel,
        _yearOfModel,
        _ratePerDay,
        _color,
        _transmissionType,
        _engineCapacity,
        _chassisNo,
        _engineNo,
        _fuelType,
        _fuelTankCapacity,
        _maxSpeed,
        _seatingCapacity,
        _inspectionDate,
        _inspectionMileage,
        _airConditioner,
        _heater,
        _sunRoof,
        _cdDvd,
        _frontCamera,
        _rearCamera,
        _cigarette,
        _wheelCup,
        _spareWheel,
        _airCompressor,
        _jackHandle,
        _wheelPanna,
        _mudFlaps,
        _floorMat,
        _photos,
        _isBooked,
        _isSaved,
        _v,
        _status,
        _rentReceiptId,
        _fuel,
        _priceVehicle,
        _documents,
        _balanceAmount,
        _condition,
        _date,
        _time,
      ];

  // JSON serialization methods
  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["_id"],
        registrationNo: json["registrationNo"],
        registeredCity: json["registeredCity"],
        carType: json["carType"],
        carMake: json["carMake"],
        carModel: json["carModel"],
        yearOfModel: json["yearOfModel"],
        ratePerDay: json["ratePerDay"],
        color: json["color"],
        transmissionType: json["transmissionType"],
        engineCapacity: json["engineCapacity"],
        chassisNo: json["chassisNo"],
        engineNo: json["engineNo"],
        fuelType: json["fuelType"],
        fuelTankCapacity: json["fuelTankCapacity"],
        maxSpeed: json["maxSpeed"],
        seatingCapacity: json["seatingCapacity"],
        inspectionDate: json["inspectionDate"] == null
            ? null
            : DateTime.parse(json["inspectionDate"]),
        inspectionMileage: json["inspectionMileage"],
        airConditioner: json["airConditioner"],
        heater: json["heater"],
        sunRoof: json["sunRoof"],
        cdDvd: json["cdDvd"],
        frontCamera: json["frontCamera"],
        rearCamera: json["rearCamera"],
        cigarette: json["cigarette"],
        wheelCup: json["wheelCup"],
        spareWheel: json["spareWheel"],
        airCompressor: json["airCompressor"],
        jackHandle: json["jackHandle"],
        wheelPanna: json["wheelPanna"],
        mudFlaps: json["mudFlaps"],
        floorMat: json["floorMat"],
        photos: json["photos"] == null
            ? null
            : List<String>.from(json["photos"].map((x) => x)),
        isBooked: json["isBooked"],
        isSaved: json["isSaved"],
        v: json["__v"],
        status: json["status"],
        rentReceiptId: json["rentReceiptId"],
        fuel: json["fuel"],
        priceVehicle: json["priceVehicle"],
        documents: json["documents"],
        balanceAmount: json["balanceAmount"],
        condition: json["condition"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "_id": _id,
        "registrationNo": _registrationNo,
        "registeredCity": _registeredCity,
        "carType": _carType,
        "carMake": _carMake,
        "carModel": _carModel,
        "yearOfModel": _yearOfModel,
        "ratePerDay": _ratePerDay,
        "color": _color,
        "transmissionType": _transmissionType,
        "engineCapacity": _engineCapacity,
        "chassisNo": _chassisNo,
        "engineNo": _engineNo,
        "fuelType": _fuelType,
        "fuelTankCapacity": _fuelTankCapacity,
        "maxSpeed": _maxSpeed,
        "seatingCapacity": _seatingCapacity,
        "inspectionDate": _inspectionDate?.toIso8601String(),
        "inspectionMileage": _inspectionMileage,
        "airConditioner": _airConditioner,
        "heater": _heater,
        "sunRoof": _sunRoof,
        "cdDvd": _cdDvd,
        "frontCamera": _frontCamera,
        "rearCamera": _rearCamera,
        "cigarette": _cigarette,
        "wheelCup": _wheelCup,
        "spareWheel": _spareWheel,
        "airCompressor": _airCompressor,
        "jackHandle": _jackHandle,
        "wheelPanna": _wheelPanna,
        "mudFlaps": _mudFlaps,
        "floorMat": _floorMat,
        "photos": _photos,
        "isBooked": _isBooked,
        "isSaved": _isSaved,
        "__v": _v,
        "status": _status,
        "rentReceiptId": _rentReceiptId,
        "fuel": _fuel,
        "priceVehicle": _priceVehicle,
        "documents": _documents,
        "balanceAmount": _balanceAmount,
        "condition": _condition,
        "date": _date?.toIso8601String(),
        "time": _time,
      };
}
