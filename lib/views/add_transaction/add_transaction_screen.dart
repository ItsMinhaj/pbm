import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pbm/controller/db_helper.dart';
import 'package:pbm/utils/static.dart';
import 'package:pbm/widgets/error_dialog.dart';

class AddTranscationScreen extends StatefulWidget {
  const AddTranscationScreen({super.key});

  @override
  State<AddTranscationScreen> createState() => _AddTranscationScreenState();
}

class _AddTranscationScreenState extends State<AddTranscationScreen> {
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  var selectedDate = DateTime.now();
  // int? amount;
  // String note = "Expense";
  String type = "Income";
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    _amountController = TextEditingController();
    _noteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Text(
            "Add Transaction",
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
                color: primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 30.0),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15.0)),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.attach_money, color: Colors.white),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "0000",
                  ),
                  style: const TextStyle(fontSize: 24.0),
                ),
              )
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15.0)),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.description, color: Colors.white),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: TextFormField(
                  controller: _noteController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Note of Transaction",
                  ),
                  style: const TextStyle(fontSize: 24.0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15.0)),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.moving_sharp, color: Colors.white),
                ),
              ),
              const SizedBox(width: 16.0),
              ChoiceChip(
                label: Text(
                  "Income",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: type == "Income" ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: primaryColor,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Income";
                    });
                  }
                },
                selected: type == "Income" ? true : false,
              ),
              const SizedBox(width: 8.0),
              ChoiceChip(
                label: Text(
                  "Expense",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: type == "Expense" ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: primaryColor,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Expense";
                    });
                  }
                },
                selected: type == "Expense" ? true : false,
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            height: 50.0,
            child: TextButton(
              onPressed: () {
                _selectDate(context);
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero)),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                    ),
                    padding: const EdgeInsets.all(
                      12.0,
                    ),
                    child: const Icon(
                      Icons.date_range,
                      size: 24.0,
                      // color: Colors.grey[700],
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12.0),

                  Text(
                    "${selectedDate.day} ${months[selectedDate.month - 1]}",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  // Text(
                  //   "2 May",
                  //   style: TextStyle(
                  //     fontSize: 20.0,
                  //     color: Colors.grey[700],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          InkWell(
            onTap: () {
              try {
                if (_amountController.text.isNotEmpty &&
                    _noteController.text.isNotEmpty) {
                  DbHelper dbHelper = DbHelper();
                  dbHelper.addData(int.tryParse(_amountController.text)!,
                      selectedDate, type, _noteController.text);

                  print(_amountController.text);
                  print(selectedDate);
                  print(_noteController.text);
                  print(type);

                  Navigator.of(context).pop();
                } else {
                  showErrorDialog(context, "Alert", "Fields can't be empty");
                }
              } catch (e) {
                showErrorDialog(context, "Alert", e.toString());
              }
            },
            child: Ink(
              height: 48.0,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(15.0)),
              child: const Center(
                child: Text(
                  "Add",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
