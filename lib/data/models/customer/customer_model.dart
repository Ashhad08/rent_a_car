class CustomerModel {
  final String? id;
  final String? email;
  final String? password;
  final String? profileImage;
  final String? name;
  final String? fatherName;
  final String? cnic;
  final String? mobileNumber;
  final String? profession;
  final String? cnicFrontImage;
  final String? cnicBackImage;
  final String? drivingLicenceImage;
  final String? residenceMobileNumber;
  final DateTime? date;
  final int? v;
  final String? customerCode;
  final DateTime? dateFrom;
  final ReferenceDetails? referenceDetails;

  CustomerModel({
    this.id,
    this.email,
    this.password,
    this.profileImage,
    this.name,
    this.fatherName,
    this.cnic,
    this.mobileNumber,
    this.profession,
    this.cnicFrontImage,
    this.cnicBackImage,
    this.drivingLicenceImage,
    this.residenceMobileNumber,
    this.date,
    this.v,
    this.customerCode,
    this.dateFrom,
    this.referenceDetails,
  });

  CustomerModel copyWith({
    String? id,
    String? email,
    String? password,
    String? profileImage,
    String? name,
    String? fatherName,
    String? cnic,
    String? mobileNumber,
    String? profession,
    String? cnicFrontImage,
    String? cnicBackImage,
    String? drivingLicenceImage,
    String? residenceMobileNumber,
    DateTime? date,
    int? v,
    String? customerCode,
    DateTime? dateFrom,
    ReferenceDetails? referenceDetails,
  }) =>
      CustomerModel(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        profileImage: profileImage ?? this.profileImage,
        name: name ?? this.name,
        fatherName: fatherName ?? this.fatherName,
        cnic: cnic ?? this.cnic,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        profession: profession ?? this.profession,
        cnicFrontImage: cnicFrontImage ?? this.cnicFrontImage,
        cnicBackImage: cnicBackImage ?? this.cnicBackImage,
        drivingLicenceImage: drivingLicenceImage ?? this.drivingLicenceImage,
        residenceMobileNumber:
            residenceMobileNumber ?? this.residenceMobileNumber,
        date: date ?? this.date,
        v: v ?? this.v,
        customerCode: customerCode ?? this.customerCode,
        dateFrom: dateFrom ?? this.dateFrom,
        referenceDetails: referenceDetails ?? this.referenceDetails,
      );

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        profileImage: json["profileImage"],
        name: json["name"],
        fatherName: json["fatherName"],
        cnic: json["cnic"],
        mobileNumber: json["mobileNumber"],
        profession: json["profession"],
        cnicFrontImage: json["cnicFrontImage"],
        cnicBackImage: json["cnicBackImage"],
        drivingLicenceImage: json["drivingLicenceImage"],
        residenceMobileNumber: json["residenceMobileNumber"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
        customerCode: json["customerCode"],
        dateFrom:
            json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
        referenceDetails: json["referenceDetails"] == null
            ? null
            : ReferenceDetails.fromJson(json["referenceDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "customerId": id,
        "email": email,
        "password": password,
        "profileImage": profileImage,
        "name": name,
        "fatherName": fatherName,
        "cnic": cnic,
        "mobileNumber": mobileNumber,
        "profession": profession,
        "cnicFrontImage": cnicFrontImage,
        "cnicBackImage": cnicBackImage,
        "drivingLicenceImage": drivingLicenceImage,
        "residenceMobileNumber": residenceMobileNumber,
        "date": date?.toIso8601String(),
        "__v": v,
        "customerCode": customerCode,
        "dateFrom": dateFrom?.toIso8601String(),
        "referenceDetails": referenceDetails?.toJson(),
      };
}

class ReferenceDetails {
  final String? referenceName;
  final String? referenceCnic;
  final String? referenceAddress;
  final String? referenceCity;
  final String? referenceMobileNumber;
  final String? referenceResidenceMobileNumber;

  ReferenceDetails({
    this.referenceName,
    this.referenceCnic,
    this.referenceAddress,
    this.referenceCity,
    this.referenceMobileNumber,
    this.referenceResidenceMobileNumber,
  });

  ReferenceDetails copyWith({
    String? referenceName,
    String? referenceCnic,
    String? referenceAddress,
    String? referenceCity,
    String? referenceMobileNumber,
    String? referenceResidenceMobileNumber,
  }) =>
      ReferenceDetails(
        referenceName: referenceName ?? this.referenceName,
        referenceCnic: referenceCnic ?? this.referenceCnic,
        referenceAddress: referenceAddress ?? this.referenceAddress,
        referenceCity: referenceCity ?? this.referenceCity,
        referenceMobileNumber:
            referenceMobileNumber ?? this.referenceMobileNumber,
        referenceResidenceMobileNumber: referenceResidenceMobileNumber ??
            this.referenceResidenceMobileNumber,
      );

  factory ReferenceDetails.fromJson(Map<String, dynamic> json) =>
      ReferenceDetails(
        referenceName: json["referenceName"],
        referenceCnic: json["referenceCnic"],
        referenceAddress: json["referenceAddress"],
        referenceCity: json["referenceCity"],
        referenceMobileNumber: json["referenceMobileNumber"],
        referenceResidenceMobileNumber: json["referenceResidenceMobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "referenceName": referenceName,
        "referenceCnic": referenceCnic,
        "referenceAddress": referenceAddress,
        "referenceCity": referenceCity,
        "referenceMobileNumber": referenceMobileNumber,
        "referenceResidenceMobileNumber": referenceResidenceMobileNumber,
      };
}
