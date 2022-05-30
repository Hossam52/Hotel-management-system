import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/models/Employee/payment_methods_model.dart';
import 'package:htask/widgets/defulat_button.dart';
import 'package:htask/widgets/dialogs/cubit/payment_methods_cubit.dart';
import 'package:htask/widgets/dialogs/cubit/payment_methods_states.dart';
import 'package:htask/widgets/no_data.dart';

class PaymentMethodsDialog extends StatelessWidget {
  const PaymentMethodsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => PaymentMethodsCubit()..getPaymentMethods(context),
        child: SingleChildScrollView(
          child: PaymentMethodsBlocBuilder(
            builder: (context, state) {
              final cubit = PaymentMethodsCubit.instance(context);
              if (state is GetPaymentMethodsLoadingState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                );
              }
              if (cubit.hasError) return const NoData();
              final payments = cubit.payments;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'available_payments'.tr(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Divider(),
                  ListView.builder(
                    primary: false,
                    itemBuilder: (context, index) => _PaymentItemWidget(
                      payment: payments[index],
                    ),
                    itemCount: payments.length,
                    shrinkWrap: true,
                  ),
                  DefaultButton(
                    text: 'confirm'.tr(),
                    onPressed: () {
                      Navigator.pop(context, cubit.selectedItem.getId());
                    },
                    backgroundColor: Colors.green,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PaymentItemWidget extends StatelessWidget {
  const _PaymentItemWidget({Key? key, required this.payment}) : super(key: key);
  final PaymentItemModel payment;
  @override
  Widget build(BuildContext context) {
    return RadioListTile<PaymentItemModel>(
      groupValue: PaymentMethodsCubit.instance(context).selectedItem,
      title: Text(payment.getName()),
      onChanged: (val) {
        PaymentMethodsCubit.instance(context).changeSelectedPayment = val!;
      },
      value: payment,
    );
  }
}
