// import 'package:flutter/material.dart';
// import 'package:pbm/utils/static.dart';

// showErrorDialog(BuildContext context, String title, String content) async {
//   return await showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text(title),
//       content: Text(content),
//       actions: [
//         ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).pop(true);
//           },
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all(
//               primaryColor,
//             ),
//           ),
//           child: const Text(
//             "Ok",
//           ),
//         ),
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> errorShowDialog(String text) async {
  return Get.defaultDialog(
    title: "Error message",
<<<<<<< HEAD
    content: Text(text,style: const TextStyle(color: Colors.black87),),
=======
    content: Text(text),
>>>>>>> 5f50e2439b2bb2dee19fa4bf5b2cc3a10248be31
    textConfirm: "Ok",
    onConfirm: () => Get.back(),
  );
}
