// ignore_for_file: constant_identifier_names

const String CARNUNMMBER = 'carNum';

class UserModel {
  String? phone;
  String? uId;
  String? carNumber;

  UserModel({
    this.phone,
    this.uId,
    this.carNumber,
  });

  //named constructor
  UserModel.fromJson(json) {
    phone = json['phone'];
    uId = json['uId'];

    carNumber = json[CARNUNMMBER];
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'uId': uId,
      CARNUNMMBER: carNumber,
    };
  }
}
