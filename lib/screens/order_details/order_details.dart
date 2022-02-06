import 'package:flutter/material.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/styles/text_styles.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarTextStyle: const TextStyle(color: Colors.black),
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        leading: !Navigator.canPop(context) ? null : _backButton(),
        title: const Text('Order details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _time(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Row(
          children: const [
            Icon(Icons.arrow_back_ios),
            Text(
              'Back',
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      );
    });
  }

  Widget _time() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text(
          'Remaining estimated',
          style: TextStyle(fontSize: 16),
        ),
        Center(
          child: Text('12 min 30 sec', style: AppTextStyles.textStyle2),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class _PersonalDataStatistics extends StatelessWidget {
  const _PersonalDataStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _name(),
        ],
      ),
    );
  }

  Widget _name() {
    return Row(children: [
      Image.asset('assets/images/user.png'),
      const SizedBox(width: 10),
      RichText(
        text: const TextSpan(text: 'Mr ', children: [
          TextSpan(text: 'Ahmed mohamed', style: TextStyle(fontSize: 19)),
        ]),
      )
    ]);
  }
}
