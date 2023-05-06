// import 'package:hive/hive.dart';
// import 'package:pbm/main.dart';
// import 'package:pbm/model/transaction_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DatabaseController {
//   late SharedPreferences preferences;

//   // DatabaseController() {
//   //   openBox();
//   // }

//   // openBox() {
//   //   transactionBox = Hive.box('transactionBox');
//   // }

//   void addData(int amount, DateTime date, String type, String note) async {
//     var data = TransactionModel(amount, note.toLowerCase(), date, type);

//     await transactionBox.add(data);
//     print(data);
//   }

//   Future deleteData(
//     int index,
//   ) async {
//     await transactionBox.deleteAt(index);
//   }

//   Future cleanData() async {
//     await transactionBox.clear();
//   }

//   addName(String name) async {
//     preferences = await SharedPreferences.getInstance();
//     preferences.setString('name', name);
//   }

//   getName() async {
//     preferences = await SharedPreferences.getInstance();
//     return preferences.getString('name');
//   }
// }
