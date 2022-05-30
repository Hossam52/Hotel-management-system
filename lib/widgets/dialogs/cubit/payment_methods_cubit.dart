import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/Employee/payment_methods_model.dart';
import 'package:htask/shared/network/services/employee_services.dart';
import 'package:htask/widgets/dialogs/cubit/payment_methods_states.dart';

//Bloc builder and bloc consumer methods
typedef PaymentMethodsBlocBuilder
    = BlocBuilder<PaymentMethodsCubit, PaymentMethodsStates>;
typedef PaymentMethodsBlocConsumer
    = BlocConsumer<PaymentMethodsCubit, PaymentMethodsStates>;

//
class PaymentMethodsCubit extends Cubit<PaymentMethodsStates> {
  PaymentMethodsCubit() : super(IntitalPaymentMethodsState());
  static PaymentMethodsCubit instance(BuildContext context) =>
      BlocProvider.of<PaymentMethodsCubit>(context);

  PaymentMethodsModel? _paymentsModel;
  bool get hasError => _paymentsModel == null;
  List<PaymentItemModel> get payments {
    // _paymentsModel!.payments.add(PaymentItemModel.fromMap(0, {
    //   "id": Random.secure().nextInt(100),
    //   "name": "cash",
    //   "hotel_id": 1,
    //   "status": "active",
    //   "type": "cash",
    //   "created_at": "2022-04-08T08:09:38.000000Z",
    //   "updated_at": "2022-04-08T08:09:38.000000Z"
    // }));
    return _paymentsModel?.payments ?? [];
  }

  //For manage selected payment
  PaymentItemModel? _selectedItem;
  PaymentItemModel get selectedItem {
    return _selectedItem ?? payments.first;
  }

  set changeSelectedPayment(PaymentItemModel item) {
    _selectedItem = item;
    emit(ChangeSelectePayment());
  }

  Future<void> getPaymentMethods(BuildContext context) async {
    try {
      emit(GetPaymentMethodsLoadingState());
      final token = AppCubit.instance(context).token;
      final map = await EmployeeServices.availablePaymentMethods(token);
      _paymentsModel = PaymentMethodsModel.fromMap(map);
      emit(GetPaymentMethodsSuccessState());
    } catch (e) {
      emit(GetPaymentMethodsErrorState(error: e.toString()));
      rethrow;
    }
  }
}
