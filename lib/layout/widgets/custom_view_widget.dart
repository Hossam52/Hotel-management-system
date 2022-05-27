import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebview extends StatelessWidget {
  const CustomWebview({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: 'https://hotelstask.com/hotelTask/public/en/dashboard/home',
      appBar: AppBar(
        title: Text('Dashboard'.tr()),
        centerTitle: true,
      ),
      withZoom: true,
      // withLocalStorage: true,
    );
    // return Scaffold(
    //   // appBar: AppBar(
    //   //     title: const Text(
    //   //       'Dashboard',
    //   //     ),
    //   //     centerTitle: true),
    //   body: SafeArea(
    //       child: Stack(
    //     children: [
    //       WebView(
    //         onWebViewCreated: (WebViewController webViewController) {
    //           webView = webViewController;
    //           webViewController.clearCache();
    //           final cookieManager = CookieManager();
    //           cookieManager.clearCookies();
    //           webViewController.loadUrl(
    //               'https://hotelstask.com/hotelTask/public/en/dashboard/home',
    //               headers: {
    //                 'Authorization':
    //                     'Bearer ${AppCubit.instance(context).token}'
    //               });
    //         },
    //         onPageStarted: (String url) {
    //           setState(() {
    //             isLoading = true;
    //           });
    //           print('Page started loading: $url');
    //         },
    //         onPageFinished: (String url) {
    //           setState(() {
    //             isLoading = false;
    //           });

    //           print('Page finished loading: $url');
    //         },
    //       ),
    //       if (isLoading) const Center(child: CircularProgressIndicator())
    //     ],
    //   )),
    // );
  }
}
