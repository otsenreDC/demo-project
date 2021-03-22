class Insurance {
  InsuranceProvider insuranceProvider;
  String authorizationNumber;

  Insurance(
    this.insuranceProvider, {
    this.authorizationNumber,
  });
}

enum InsuranceProvider { Palic, SeNaSa, Futuro, Humarno, Primera, Other }
