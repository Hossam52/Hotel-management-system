import 'package:flutter/material.dart';
import 'package:htask/models/service_model.dart';
import 'package:htask/widgets/service_item.dart';

class ServiceToday extends StatelessWidget {
  const ServiceToday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your service today are: '),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                    width: 15,
                  ),
              scrollDirection: Axis.horizontal,
              itemCount: servicesToday.length,
              itemBuilder: (_, index) {
                return ServiceItem(serviceModel: servicesToday[index]);
              }),
        )
      ],
    );
  }
}
