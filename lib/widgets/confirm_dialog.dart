import 'package:flutter/material.dart';

showConfirmDialog({required BuildContext context, String? title, String? content,void Function()? onPressed}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title!),
      content: Text(content!),
      actions: [
        ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.red,
            ),
          ),
          child: const Text(
            "YES",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text(
            "No",
          ),
        ),
      ],
    ),
  );
}
