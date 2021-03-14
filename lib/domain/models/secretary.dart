import 'package:flutter/foundation.dart';

class Secretary {
  String idReference;
  String profileReference;
  String name;
  String phone;

  Secretary({
    @required this.idReference,
    this.profileReference,
    @required this.name,
    @required this.phone,
  });
}
