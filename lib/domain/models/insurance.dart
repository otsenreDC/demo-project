class Insurance {
  InsuranceProvider insuranceProvider;
  String authorizationNumber;
  bool isPrivate;

  Insurance(
    this.insuranceProvider, {
    this.authorizationNumber,
    this.isPrivate = false,
  });

  factory Insurance.private() {
    return Insurance(
      null,
      authorizationNumber: null,
      isPrivate: true,
    );
  }
}

enum InsuranceProvider { Mapfre, SeNaSa, Futuro, Humano, Primera, Other }

extension InsuranceProviderImage on InsuranceProvider {
  String asset() {
    switch (this) {
      case InsuranceProvider.Mapfre:
        return "ars/mapfre.jpeg";
      case InsuranceProvider.SeNaSa:
        return "ars/senasa.jpeg";
      case InsuranceProvider.Futuro:
        return "ars/futuro.jpeg";
      case InsuranceProvider.Humano:
        return "ars/humano.png";
      case InsuranceProvider.Primera:
        return "ars/primera.png";
      case InsuranceProvider.Other:
      default:
        return "ars/mapfre.jpeg";
    }
  }
}
