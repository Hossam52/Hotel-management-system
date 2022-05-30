//
abstract class PaymentMethodsStates {}

class IntitalPaymentMethodsState extends PaymentMethodsStates {}

//

class ChangeSelectePayment extends PaymentMethodsStates {}

//GetPaymentMethods online fetch data
class GetPaymentMethodsLoadingState extends PaymentMethodsStates {}

class GetPaymentMethodsSuccessState extends PaymentMethodsStates {}

class GetPaymentMethodsErrorState extends PaymentMethodsStates {
  final String error;
  GetPaymentMethodsErrorState({required this.error});
}
