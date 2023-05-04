import 'package:flutter/material.dart';
import 'package:pbm/utils/static.dart';

showErrorDialog(BuildContext context, String title, String content) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              primaryColor,
            ),
          ),
          child: const Text(
            "Ok",
          ),
        ),
      ],
    ),
  );
}
