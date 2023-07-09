// ignore_for_file: public_member_api_docs, sort_constructors_first
const String userKey = 'userid';
const String codeKey = 'codeDate';

class UserScannerData {
  String? userId, scannCode;

  UserScannerData({
    this.scannCode,
    this.userId,
  });

  UserScannerData.fromJson(snapshot) {
    userId = snapshot[userKey];
    scannCode = snapshot[codeKey];
  }

  toJson() {
    return {
      userKey: userId,
      codeKey: scannCode,
    };
  }
}
