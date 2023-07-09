abstract class ParkingStates {}

class ParkingInitialState extends ParkingStates {}

class ParkingChangeBottomNavState extends ParkingStates {}

class ChangeDatePickerState extends ParkingStates {}

class ChangeTimePickerState extends ParkingStates {}

class DataGetting extends ParkingStates {}

class DataGot extends ParkingStates {}

class DataError extends ParkingStates {
  final String error;

  DataError(this.error);
}

class ParkingUpdated extends ParkingStates {}

// payment
class PaymentAuthLoadingStates extends ParkingStates {}

class PaymentAuthSuccessStates extends ParkingStates {}

class PaymentAuthErrorStates extends ParkingStates {
  final String error;

  PaymentAuthErrorStates(this.error);
}

// for order id
class PaymentOrderIdLoadingStates extends ParkingStates {}

class PaymentOrderIdSuccessStates extends ParkingStates {}

class PaymentOrderIdErrorStates extends ParkingStates {
  final String error;

  PaymentOrderIdErrorStates(this.error);
}

// for request token
class PaymentRequestTokenLoadingStates extends ParkingStates {}

class PaymentRequestTokenSuccessStates extends ParkingStates {}

class PaymentRequestTokenErrorStates extends ParkingStates {
  final String error;

  PaymentRequestTokenErrorStates(this.error);
}

// for ref code
class PaymentRefCodeLoadingStates extends ParkingStates {}

class PaymentRefCodeSuccessStates extends ParkingStates {}

class PaymentRefCodeErrorStates extends ParkingStates {
  final String error;

  PaymentRefCodeErrorStates(this.error);
}
