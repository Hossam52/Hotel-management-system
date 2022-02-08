import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> navigateTo(BuildContext context, Widget child) async {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => child));
}

Future<void> navigateToReplacement(BuildContext context, Widget child) async {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => child));
}
