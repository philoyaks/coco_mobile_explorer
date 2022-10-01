import 'package:flutter/material.dart';

void showErrorAlert(
    {required BuildContext context, String? description}) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 70,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                const Text(
                  'Error ',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  description ?? 'An error Occured ',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Dismiss'))
              ],
            ),
          ),
        );
      });
}
