import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pbm/main.dart';
import 'package:pbm/services/database_helper.dart';
import 'package:pbm/model/trans_model.dart';
import 'package:pbm/model/transaction_model.dart';
import 'package:pbm/utils/static.dart';
import 'package:pbm/views/add_transaction/add_transaction_screen.dart';
import 'package:pbm/widgets/confirm_dialog.dart';

import '../../controller/profile_pic_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 // late Box transcationBox;
  int items = 10;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;

  bool isShowLogout = false;

  String dropdownValue = "";

  DateTime today = DateTime.now();
  DateTime now = DateTime.now();
  int index = 1;
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

  DatabaseHelper databaseHelper =  DatabaseHelper();


  // Get total Balance
  getTotalBalance(List<TransModel> entireData) {
    totalExpense = 0;
    totalIncome = 0;
    totalBalance = 0;

    for (TransModel data in entireData) {

        if (data.type == "Income") {
          totalBalance += data.amount!;
          totalIncome += data.amount!;
        } else {
          totalBalance -= data.amount!;
          totalExpense += data.amount!;
        }

    }
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfilePicController());
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
      body: FutureBuilder<List<TransModel>>(
        future:  databaseHelper.getAllTransactions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("No data"));
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("Please add your transactions!"),
              );
            }
          }
          getTotalBalance(snapshot.data!);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListTile(
                    leading:  CircleAvatar(
                      radius: 24,
                      child: Obx(()=> ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(profileController.imgUrl.value == "" ? "Loading.." :profileController.imgUrl.value, height: 100,width: 100, fit: BoxFit.fill,),),)
                    ),
                    title: Text(
                      "Welcome, ${nameBox.get("name")}",
                      style: GoogleFonts.dmSans(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    trailing: IconButton(
                      icon:const Icon(Icons.logout),
                      onPressed: (){
                        showConfirmDialog(
                          context: context,
                          title: "Logout",
                          content: "Do you want to logout?",
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                          },
                        );
                      },
                    ),
                    // PopupMenuButton<int>(
                    //   onSelected: (value) {
                    //     if (value == 1) {
                    //       // Perform logout action
                    //       showConfirmDialog(
                    //         context: context,
                    //         title: "",
                    //         content: "Are you sure?",
                    //         onPressed: () async {
                    //           await FirebaseAuth.instance.signOut();
                    //         },
                    //       );
                    //     }
                    //   },
                    //   itemBuilder: (context) =>[
                    //     const PopupMenuItem(
                    //       value: 1,
                    //       child: Text('Logout'),
                    //     ),
                    //   ],
                    //   child: IconButton(
                    //     icon: const Icon(Icons.menu),
                    //     onPressed: () {},
                    //   ),
                    // ),
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
                        "$totalBalance Tk",
                        style: GoogleFonts.dmSans(
                            color: Colors.grey.shade50,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Income",
                                          style: GoogleFonts.dmSans(
                                              fontSize: 14,
                                              color: Colors.grey.shade50),
                                        ),
                                        Text(
                                          "$totalIncome Tk",
                                          style: GoogleFonts.dmSans(
                                              fontSize: 20,
                                              color: Colors.grey.shade50,
                                              fontWeight: FontWeight.w700),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Expense",
                                          style: GoogleFonts.dmSans(
                                              fontSize: 14,
                                              color: Colors.grey.shade50),
                                        ),
                                        Text(
                                          "$totalExpense Tk",
                                          style: GoogleFonts.dmSans(
                                              fontSize: 20,
                                              color: Colors.grey.shade50,
                                              fontWeight: FontWeight.w700),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: ListView.builder(
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
                              title: Text(data.type!),
                              trailing: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    Text("+ ${data.amount} Tk"),
                                    Text(
                                      data.source!,
                                      style: GoogleFonts.dmSans(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Text( DateFormat.yMMMEd().format(DateTime.parse(data.date.toString()
                              ),),),
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
                                     Text("- ${data.amount.toString()} Tk"),
                                    Text(
                                      "Home rent",
                                      style: GoogleFonts.dmSans(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle:  Text( DateFormat.yMMMEd().format(DateTime.parse(data.date.toString()),),),
                       );

                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) =>  AddTranscationScreen(totalBalance: totalBalance),
            ),
          )
              .whenComplete(() {
            setState(() {});
          });
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
