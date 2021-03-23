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

extension InsuranceString on InsuranceProvider {
  String string() {
    switch (this) {
      case InsuranceProvider.Mapfre:
        return "MAPFRE";
      case InsuranceProvider.SeNaSa:
        return "SENASA";
      case InsuranceProvider.Futuro:
        return "FUTURO";
      case InsuranceProvider.Humano:
        return "HUMANO";
      case InsuranceProvider.Primera:
        return "PRIMERA";
      case InsuranceProvider.Other:
      default:
        return "OTHER";
    }
  }
}

InsuranceProvider insuranceProviderFromString(String provider) {
  switch (provider) {
    case "MAPFRE":
      return InsuranceProvider.Mapfre;
    case "SENASA":
      return InsuranceProvider.SeNaSa;
    case "FUTURO":
      return InsuranceProvider.Futuro;
    case "HUMANO":
      return InsuranceProvider.Humano;
    case "PRIMERA":
      return InsuranceProvider.Primera;
    case "OTHER":
      return InsuranceProvider.Other;
    default:
      return null;
  }
}
