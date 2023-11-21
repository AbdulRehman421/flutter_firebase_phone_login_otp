import 'package:firebase_phone_otp/verify.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+92";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img1.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      // Navigator.pushNamed(context, 'verify');

                      setState(() {
                        loading = true;
                      });

                      auth.verifyPhoneNumber(
                          phoneNumber: countryController.text,
                          verificationCompleted: (_){
                            setState(() {
                              loading = false;
                            });

                          },
                          verificationFailed: (e){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Verification failed: ${e.toString()}'),
                              ),
                            );
                          },
                          codeSent:  (String verificationId, int? token) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyVerify(verificationId: verificationId),));
                            setState(() {
                              loading = false;
                            });
                          },
                          codeAutoRetrievalTimeout:  (e){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Code Time Out: ${e.toString()}'),
                              ),
                            );
                      },

                      );

                    },
                    child: Text("Login")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
