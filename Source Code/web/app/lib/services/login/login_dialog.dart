import 'package:flutter/material.dart';
import 'package:virtuallibrary/Widgets/login_loading_indicator.dart';

class DialogBuilders {
  const DialogBuilders(this.context);
  final BuildContext context;

  /// Example loading dialog
  Future<void> showLoadingDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async => false,
          child: const AlertDialog(
            content: LoadingIndicator(),
          ),
        ),
      );

  /// Example result dialog
  Future<void> showResultDialog(String text) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: SizedBox(
            height: 100,
            width: 100,
            child: Center(child: Text(text, textAlign: TextAlign.center)),
          ),
        ),
      );
}
