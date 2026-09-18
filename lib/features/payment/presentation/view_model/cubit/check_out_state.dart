abstract class CheckoutState {}

class CheckoutInitialState extends CheckoutState {}

class CheckoutLoadingState extends CheckoutState {}

class CheckoutSuccessState extends CheckoutState {
  final String paymentPaymentToken;
  CheckoutSuccessState(this.paymentPaymentToken);
}

class CheckoutErrorState extends CheckoutState {
  final String errorMessage;
  CheckoutErrorState(this.errorMessage);
}