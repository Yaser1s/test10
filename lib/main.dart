import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test10/pages/mobile.dart';
import 'package:test10/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test10/provider/user_provider.dart';
import 'package:test10/shared/snackbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return UserProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              // return Home();
              return const Mobile(); // home() OR verify email
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
// // ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print, unused_import, unused_local_variable, annotate_overrides, unnecessary_brace_in_string_interps

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:test10/Pages/login.dart';
// import 'package:test10/shared/colors.dart';
// import 'package:test10/shared/custom_textfield.dart';
// import 'package:test10/shared/snackbar.dart';
// import 'package:email_validator/email_validator.dart';

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   final _formKey = GlobalKey<FormState>();
//   // addNewUser() {
//   //   setState(() {
//   //     allUsers.add(
//   //       Users(
//   //           UserName: UserNameCnt.text,
//   //           Name: NameCnt.text,
//   //           NumberOfUser: NumberOfUserCnt.text,
//   //           Email: EmailOfUserCnt.text,
//   //           Password: PasswordOfUserCnt.text,
//   //           Type: "موظف",
//   //           State: "غير معتمد"),
//   //     );
//   //   });
//   // }
//   registor() async {
//     if (hasDigits == true &&
//         hasUppercase == true &&
//         hasLowercase == true &&
//         isPassword8Char == true) {
//       setState(() {
//         isLoding = true;
//       });

//       try {
//         final credential =
//             await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: EmailOfUserCnt.text,
//           password: PasswordOfUserCnt.text,
//         );
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'weak-password') {
//           showSnackBar(context, "The password provided is too weak.");
//         } else if (e.code == 'email-already-in-use') {
//           showSnackBar(context, "الايميل المدخل لقد تم استخدامه من قبل");
//         } else {
//           showSnackBar(context, "ERROR - حاول في وقت لاحق");
//         }
//       } catch (err) {
//         showSnackBar(context, err.toString());
//       }

//       setState(() {
//         isLoding = false;
//       });
//     }
//   }

//   // final UserNameCnt = TextEditingController();
//   // final NameCnt = TextEditingController();
//   // final NumberOfUserCnt = TextEditingController();
//   final EmailOfUserCnt = TextEditingController();
//   final PasswordOfUserCnt = TextEditingController();
//   bool isLoding = false;
//   bool isVisable = true;

//   void dispose() {
//     EmailOfUserCnt.dispose();
//     PasswordOfUserCnt.dispose();
//     super.dispose();
//   }

//   bool isPassword8Char = false;
//   bool hasLowercase = false;
//   bool hasUppercase = false;
//   bool hasDigits = false;

//   // bool hasSpecialCharacters = false;

//   onPasswordChanged(String password) {
//     isPassword8Char = false;
//     hasLowercase = false;
//     hasUppercase = false;
//     hasDigits = false;
//     setState(() {
//       if (password.contains(RegExp(r'.{8,}'))) {
//         isPassword8Char = true;
//         // "${wrongPassword} ادخل ثمانية حروف على الاقل ";
//       }

//       if (password.contains(RegExp(r'[a-z]'))) {
//         hasLowercase = true;
//         // "${wrongPassword} ادخل حرف واحد صغير على الاقل ";
//       }

//       if (password.contains(RegExp(r'[A-Z]'))) {
//         hasUppercase = true;
//         // "${wrongPassword} ادخل حرف واحد كبير على الاقل ";
//       }

//       if (password.contains(RegExp(r'[0-9]'))) {
//         hasDigits = true;
//         // "${wrongPassword} ادخل رقم واحد على الاقل ";
//       }
//     });
//   }

//   onPasswordChanged1(String password) {
//     onPasswordChanged(password);
//     setState(() {
//       if (isPassword8Char == true &&
//           hasLowercase == true &&
//           hasUppercase == true &&
//           hasDigits == true) {
//         wrongPasswordd = true;
//       } else {
//         wrongPasswordd = false;
//       }
//     });
//   }

//   String wrongPassword = "الرمز ضعيف";
//   bool wrongPasswordd = false;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: backgrond,
//         body: SizedBox(
//           height: double.infinity,
//           width: double.infinity,
//           child: SingleChildScrollView(
//             child: Stack(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 40),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const SizedBox(
//                           height: 60,
//                         ),
//                         Text(
//                           "انشاء حساب",
//                           style: TextStyle(
//                               fontSize: 35,
//                               fontFamily: "myfont",
//                               color: Colors.grey[800]),
//                         ),
//                         const SizedBox(
//                           height: 230,
//                         ),
//                         // Container(
//                         //   decoration: BoxDecoration(
//                         //     color: Color.fromARGB(157, 212, 156, 130),
//                         //     borderRadius: BorderRadius.circular(66),
//                         //   ),
//                         //   width: 266,
//                         //   padding: const EdgeInsets.symmetric(horizontal: 16),
//                         //   child: TextField(
//                         //     textInputAction: TextInputAction.next,
//                         //     controller: NameCnt,
//                         //     decoration: InputDecoration(
//                         //         icon: Icon(
//                         //           Icons.person,
//                         //           color: Color.fromARGB(255, 243, 220, 209),
//                         //         ),
//                         //         hintText: "الاسم الثلاثي :",
//                         //         border: InputBorder.none),
//                         //   ),
//                         // ),
//                         // const SizedBox(
//                         //   height: 23,
//                         // ),
//                         // Container(
//                         //   decoration: BoxDecoration(
//                         //     color: Color.fromARGB(157, 212, 156, 130),
//                         //     borderRadius: BorderRadius.circular(66),
//                         //   ),
//                         //   width: 266,
//                         //   padding: const EdgeInsets.symmetric(horizontal: 16),
//                         //   child: TextField(
//                         //     textInputAction: TextInputAction.next,
//                         //     controller: UserNameCnt,
//                         //     decoration: InputDecoration(
//                         //         icon: Icon(
//                         //           Icons.person,
//                         //           color: Color.fromARGB(255, 243, 220, 209),
//                         //         ),
//                         //         hintText: "اسم المستخدم :",
//                         //         border: InputBorder.none),
//                         //   ),
//                         // ),
//                         // const SizedBox(
//                         //   height: 23,
//                         // ),
//                         // Container(
//                         //   decoration: BoxDecoration(
//                         //     color: Color.fromARGB(157, 212, 156, 130),
//                         //     borderRadius: BorderRadius.circular(66),
//                         //   ),
//                         //   width: 266,
//                         //   padding: const EdgeInsets.symmetric(horizontal: 16),
//                         //   child: TextField(
//                         //     textInputAction: TextInputAction.next,
//                         //     keyboardType: TextInputType.phone,
//                         //     controller: NumberOfUserCnt,
//                         //     decoration: InputDecoration(
//                         //         icon: Icon(
//                         //           Icons.phone,
//                         //           color: Color.fromARGB(255, 243, 220, 209),
//                         //         ),
//                         //         hintText: "رقم الجوال :",
//                         //         border: InputBorder.none),
//                         //   ),
//                         // ),
//                         // const SizedBox(
//                         //   height: 23,
//                         // ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 26, left: 12),
//                           child: Form(
//                               child: Column(
//                             children: [
//                               TextFormField(
//                                   // we return "null" when something is valid
//                                   validator: (email) {
//                                     return email!.contains(RegExp(
//                                             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
//                                         ? null
//                                         : "ادخل ايميل صحيح";
//                                   },
//                                   autovalidateMode:
//                                       AutovalidateMode.onUserInteraction,
//                                   controller: EmailOfUserCnt,
//                                   textInputAction: TextInputAction.next,
//                                   keyboardType: TextInputType.emailAddress,
//                                   obscureText: false,
//                                   decoration: decorationTextfield.copyWith(
//                                     icon: Icon(
//                                       Icons.email,
//                                       color: Colors.grey[700],
//                                       size: 19,
//                                     ),
//                                     hintText: "ادخل ايميلك : ",
//                                   )),
//                               const SizedBox(
//                                 height: 23,
//                               ),
//                               TextFormField(
//                                   onChanged: (password) {
//                                     onPasswordChanged(password);
//                                     onPasswordChanged1(password);
//                                   },
//                                   validator: (password) {
//                                     return wrongPasswordd
//                                         ? null
//                                         : wrongPassword;
//                                   },
//                                   autovalidateMode:
//                                       AutovalidateMode.onUserInteraction,
//                                   textInputAction: TextInputAction.done,
//                                   controller: PasswordOfUserCnt,
//                                   obscureText: isVisable ? true : false,
//                                   decoration: decorationTextfield.copyWith(
//                                     suffix: IconButton(
//                                         onPressed: () {
//                                           setState(() {
//                                             isVisable = !isVisable;
//                                           });
//                                         },
//                                         icon: isVisable
//                                             ? Icon(Icons.visibility,
//                                                 color: Colors.grey[700])
//                                             : Icon(
//                                                 Icons.visibility_off,
//                                                 color: Colors.lightBlue,
//                                               )),
//                                     icon: Icon(
//                                       Icons.lock,
//                                       color: Colors.grey[700],
//                                       size: 19,
//                                     ),
//                                     hintText: "الرقم السري : ",
//                                   )),
//                             ],
//                           )),
//                         ),
//                         SizedBox(
//                           height: 40,
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               registor();
//                             } else {
//                               showSnackBar(context, "ERROR");
//                             }
//                           },

//                           //
//                           //
//                           //     {
//                           //   if (_formKey.currentState!.validate()) {
//                           //     register();
//                           //   } else {
//                           //     showSnackBar(context, "ERROR");
//                           //   }

//                           // },
//                           //
//                           //
//                           // async {
//                           //   await registor();
//                           //   if (!mounted) return;
//                           //   Navigator.pushReplacement(
//                           //       context,
//                           //       MaterialPageRoute(
//                           //         builder: (context) => const Login(),
//                           //       ));
//                           // },
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all(
//                                 Color.fromARGB(104, 107, 40, 6)),
//                             padding: MaterialStateProperty.all(
//                                 const EdgeInsets.symmetric(
//                                     horizontal: 70, vertical: 10)),
//                             shape: MaterialStateProperty.all(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(27))),
//                           ),
//                           child: isLoding
//                               ? CircularProgressIndicator(color: Colors.white)
//                               : Text("تسجيل الحساب",
//                                   style: TextStyle(fontSize: 24)),
//                         ),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => const Login(),
//                                     ));
//                               },
//                               child: const Text(
//                                 "لتسجيل الدخول",
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             const Text("  عندك حساب ؟ "),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: 0,
//                   child: Image.asset(
//                     "assets/images/logo-2.jpeg",
//                     width: 100,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // InputDecoration(
// //                               suffix: Icon(
// //                                 Icons.visibility,
// //                                 color: Color.fromARGB(131, 243, 220, 209),
// //                               ),
// //                               icon: Icon(
// //                                 Icons.lock,
// //                                 color: Color.fromARGB(255, 243, 220, 209),
// //                                 size: 19,
// //                               ),
// //                               hintText: "الرقم السري :",
// //                               border: InputBorder.none),
//                           // addNewUser();
//                           // Navigator.pushReplacementNamed(context, "/");
//                           // showDialog(
//                           //     context: context,
//                           //     builder: (BuildContext context) {
//                           //       return Dialog(
//                           //         child: Container(
//                           //           padding: const EdgeInsets.all(22),
//                           //           child: Row(
//                           //             mainAxisAlignment:
//                           //                 MainAxisAlignment.center,
//                           //             children: const [
//                           //               Text(
//                           //                 "سيتم التواصل معك بعد اعتماد حسابك",
//                           //                 style: TextStyle(
//                           //                     fontWeight: FontWeight.bold,
//                           //                     fontSize: 16),
//                           //               )
//                           //             ],
//                           //           ),
//                           //         ),
//                           //       );
//                           //     });