import 'package:flutter/material.dart';

class AlertSnackbar {
  //
  _showAlertSnackbar(snackBar, context) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showSuccessAlert(String? message, context) {
    var snackBar = SnackBar(
      content: message != null ? Text(message) : const Text("Success"),
      backgroundColor: (Colors.green),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {},
      ),
    );
    _showAlertSnackbar(snackBar, context);
  }

  showErrorAlert(String? message, context) {
    var snackBar =  SnackBar(
      content: message != null ? Text(message) : const Text("Error"),
      backgroundColor: (Colors.red),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {},
      ),
    );
    _showAlertSnackbar(snackBar, context);
  }
  showUserNoticeAlert(String? message, context) {
    var snackBar =  SnackBar(
      content: message != null ? Text(message) : const Text("Notice"),
      backgroundColor: (Colors.yellow),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {},
      ),
    );
    _showAlertSnackbar(snackBar, context);
  }
}