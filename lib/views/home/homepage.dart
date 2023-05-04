import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pbm/model/transaction_model.dart';
import 'package:pbm/utils/static.dart';
import 'package:pbm/views/add_transaction/add_transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box transcationBox;
  int items = 10;

  @override
  void initState() {
    transcationBox = Hive.box("transactionBox");
    super.initState();
  }

  Future<List<TransactionModel>> fetch() async {
    if (transcationBox.values.isEmpty) {
      return Future.value([]);
    } else {
      List<TransactionModel> items = [];
      transcationBox.toMap().values.forEach(
        (element) {
          items.add(
            TransactionModel(
              element['amount'],
              element['note'],
              element['date'],
              element['type'],
            ),
          );
        },
      );
      return items;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      persistentFooterButtons: const [
        SizedBox(
          width: 900,
          child: Text(
            '© Minhajul Islam',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 24,
                  child: Icon(Icons.person),
                ),
                title: Text(
                  "Welcome, Minhajul",
                  style: GoogleFonts.dmSans(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                trailing: const Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Total Balance",
                    style: GoogleFonts.dmSans(
                        color: Colors.grey.shade50,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "20000 Tk",
                    style: GoogleFonts.dmSans(
                        color: Colors.grey.shade50,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Income",
                                      style: GoogleFonts.dmSans(
                                          fontSize: 14,
                                          color: Colors.grey.shade50),
                                    ),
                                    Text(
                                      "30000 Tk",
                                      style: GoogleFonts.dmSans(
                                          fontSize: 18,
                                          color: Colors.grey.shade50,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Expense",
                                      style: GoogleFonts.dmSans(
                                          fontSize: 14,
                                          color: Colors.grey.shade50),
                                    ),
                                    Text(
                                      "10000 Tk",
                                      style: GoogleFonts.dmSans(
                                          fontSize: 18,
                                          color: Colors.grey.shade50,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 10.0),
            // Recent Transactions
            Row(
              children: [
                Text(
                  "Recent Transactions",
                  style: GoogleFonts.dmSans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                future: fetch(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error!"),
                    );
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("Please add your transaction"),
                      );
                    }
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data![index];
                      return data.type == "Income"
                          ? ListTile(
                              leading: const CircleAvatar(
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              title: Text(data.type),
                              trailing: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    Text("+ ${data.amount} Tk"),
                                    Text(
                                      data.note,
                                      style: GoogleFonts.dmSans(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Text(data.date.toIso8601String()),
                            )
                          : ListTile(
                              leading: const CircleAvatar(
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              ),
                              title: const Text("Expense"),
                              trailing: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    const Text("- 5000 Tk"),
                                    Text(
                                      "Home rent",
                                      style: GoogleFonts.dmSans(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: const Text("02 May 2023"),
                            );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddTranscationScreen()));
        },
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
