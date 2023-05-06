import 'package:flutter/material.dart';
import 'package:pbm/main.dart';
import 'package:pbm/utils/static.dart';
import 'package:pbm/views/auth/registration_screen.dart';
import 'package:pbm/views/home/homepage.dart';

class AddName extends StatelessWidget {
  const AddName({Key? key}) : super(key: key);

  //
  // DbHelper dbHelper = DbHelper();

  //
  @override
  Widget build(BuildContext context) {

String name = '';
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
      //
      // backgroundColor: Color(0xffe2e7ef),
      //
      body: Padding(
        padding: const EdgeInsets.all(
          12.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              padding: const EdgeInsets.all(
                16.0,
              ),
              child: Image.asset(
                "assets/Icon.png",
                width: 64.0,
                height: 64.0,
              ),
            ),
            //
            const SizedBox(
              height: 20.0,
            ),
            //
            const Text(
              "What should we Call You ?",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            //
            const SizedBox(
              height: 20.0,
            ),
            //
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Your Name",
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                maxLength: 16,
                onChanged: (val) async{
               name =  val;
               await nameBox.put("name", name);
                },
              ),
            ),
            //
            const SizedBox(
              height: 20.0,
            ),
            //
            SizedBox(
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          label: "OK",
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                        backgroundColor: Colors.white,
                        content: const Text(
                          "Please enter your name",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    );
                  } else {
                    //  DbHelper dbHelper = DbHelper();
                    //  await dbHelper.addName(name);
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //     builder: (context) => Homepage(),
                    //   ),
                    // );
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const RegistrationScreen()));
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Let's Start",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(
                      Icons.arrow_right_alt,
                      size: 24.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
