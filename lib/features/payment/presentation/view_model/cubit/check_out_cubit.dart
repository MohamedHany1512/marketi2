import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/payment/data/repos/checkout_repo.dart';
import 'package:marketi/features/payment/presentation/view_model/cubit/check_out_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutRepo checkoutRepo;

  CheckoutCubit({required this.checkoutRepo}) : super(CheckoutInitialState());

  Future<void> payWithPaymob({
    required String apiKey,
    required String integrationId,
    required double amount,
    required Map<String, dynamic> billingData,
  }) async {
    emit(CheckoutLoadingState());

    final amountInCents = (amount * 100).toInt().toString();

    // الخطوة 1: Authentication
    final authResult = await checkoutRepo.getAuthToken(apiKey);
    authResult.fold(
      (error) => emit(CheckoutErrorState(error.errorMessage)),
      (authToken) async {
        // الخطوة 2: Order Registration
        final orderResult = await checkoutRepo.createOrder(
          authToken: authToken,
          amountCents: amountInCents,
          items: [],
        );
        orderResult.fold(
          (error) => emit(CheckoutErrorState(error.errorMessage)),
          (orderId) async {
            // الخطوة 3: Request Payment Key
            final keyResult = await checkoutRepo.getPaymentKey(
              authToken: authToken,
              orderId: orderId.toString(),
              amountCents: amountInCents,
              integrationId: integrationId,
              billingData: billingData,
            );
            keyResult.fold(
              (error) => emit(CheckoutErrorState(error.errorMessage)),
              (paymentToken) => emit(CheckoutSuccessState(paymentToken)),
            );
          },
        );
      },
    );
  }
}