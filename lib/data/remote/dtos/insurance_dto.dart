import 'package:project_docere/domain/models/insurance.dart';

class InsuranceDTO {
  static final String keyProvider = "provider";
  static final String keyAuthorization = "authorization";
  static final String keyIsPrivate = "isPrivate";

  String insuranceProvider;
  String authorizationNumber;
  bool isPrivate;

  InsuranceDTO(
    this.insuranceProvider,
    this.authorizationNumber,
    this.isPrivate,
  );

  factory InsuranceDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return InsuranceDTO(
      json[keyProvider],
      json[keyAuthorization],
      json[keyIsPrivate],
    );
  }

  factory InsuranceDTO.fromDomain(Insurance insurance) {
    if (insurance == null) return null;

    return InsuranceDTO(
      insurance.insuranceProvider?.string(),
      insurance.authorizationNumber,
      insurance.isPrivate,
    );
  }

  Map<String, dynamic> toJson() {
    return Map.fromEntries([
      MapEntry(
        keyProvider,
        insuranceProvider,
      ),
      MapEntry(
        keyAuthorization,
        authorizationNumber,
      ),
      MapEntry(
        keyIsPrivate,
        isPrivate,
      ),
    ]);
  }

  Insurance toDomain() {
    return Insurance(
      insuranceProviderFromString(this.insuranceProvider),
      isPrivate: this.isPrivate,
      authorizationNumber: this.authorizationNumber,
    );
  }
}
