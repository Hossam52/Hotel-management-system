import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';

class DefaultErrorWidget extends StatelessWidget {
  const DefaultErrorWidget({Key? key, required this.refreshMethod})
      : super(key: key);
  final VoidCallback refreshMethod;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: AppColors.darkPrimaryColor,
          ),
          const SizedBox(height: 20),
          const Text('Error happened'),
          const SizedBox(height: 20),
          TextButton(
            onPressed: refreshMethod,
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white)),
            child: const Text(
              'Refresh now',
            ),
          ),
        ],
      ),
    );
  }
}
