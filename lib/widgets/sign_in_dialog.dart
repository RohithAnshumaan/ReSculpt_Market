// import 'package:flutter/material.dart';
// import 'package:resculpt/auth/signin.dart';
// import 'package:resculpt/widgets/sign_up_dialog.dart';

// void showCustomDialog2(BuildContext context, {required ValueChanged onValue}) {
//   showGeneralDialog(
//     context: context,
//     transitionDuration: const Duration(milliseconds: 400),
//     pageBuilder: (_, __, ___) {
//       return Scaffold(
//         backgroundColor: Colors.black.withOpacity(0.5),
//         body: Center(
//           child: Container(
//             height: MediaQuery.of(context).size.height * 0.8,
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.80),
//               borderRadius: BorderRadius.circular(40),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.3),
//                   offset: const Offset(0, 30),
//                   blurRadius: 60,
//                 ),
//                 const BoxShadow(
//                   color: Colors.black45,
//                   offset: Offset(0, 30),
//                   blurRadius: 60,
//                 ),
//               ],
//             ),
//             child: Container(
//               color: const  Color(0xFFEEF1F8),
//               child: Center(
//                   child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           const Text(
//                             "Sign in",
//                             style: TextStyle(
//                               fontSize: 34,
//                               fontFamily: "Poppins",
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.symmetric(vertical: 16),
//                             child: Text(
//                               "Access to lots of Innovative products. Buy Products, Share, Encourage UpCycling!!",
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                           const Signin(),
//                           const Row(
//                             children: [
//                               Expanded(
//                                 child: Divider(),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 16),
//                                 child: Text(
//                                   "OR",
//                                   style: TextStyle(
//                                     color: Colors.black26,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(child: Divider()),
//                             ],
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(left: 45, right: 45, top: 35),
//                             child: Row(
//                               children: [
//                                 const Text(
//                                   "Doesn't have an Account,",
//                                   style: TextStyle(color: Colors.black54),
//                                 ),
//                                 TextButton(
//                                   child: const Text("Sign Up",
//                                       style: TextStyle(
//                                           color: Colors.black, fontSize: 15)),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                     showCustomDialog(
//                                       context,
//                                       onValue: (_) {},
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//             ),
//             ),
//       );
//     },
//     transitionBuilder: (_, anim, __, child) {
//       Tween<Offset> tween;
//       // if (anim.status == AnimationStatus.reverse) {
//       //   tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
//       // } else {
//       //   tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
//       // }

//       tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

//       return SlideTransition(
//         position: tween.animate(
//           CurvedAnimation(parent: anim, curve: Curves.easeInOut),
//         ),
//         // child: FadeTransition(
//         //   opacity: anim,
//         //   child: child,
//         // ),
//         child: child,
//       );
//     },
//   ).then(onValue);
// }
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:resculpt/auth/signin.dart';
import 'package:resculpt/widgets/sign_up_dialog.dart';

void showCustomDialog2(BuildContext context, {required ValueChanged onValue}) {
  showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Center(
          child: Container(            
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 30),
                  blurRadius: 60,
                ),
                const BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 30),
                  blurRadius: 60,
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: const Color(0xFFEEF1F8),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Lottie.asset(
                      'assets/signin.json',
                      fit: BoxFit.cover,height: 220,
                    ),
                      const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 34,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Access to lots of Innovative products. Buy Products, Share, Encourage UpCycling!!",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Signin(),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "OR",
                              style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Text(
                              "Doesn't have an Account?",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          TextButton(
                            child: const Text("Sign Up",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              showCustomDialog(
                                context,
                                onValue: (_) {},
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      // if (anim.status == AnimationStatus.reverse) {
      //   tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      // } else {
      //   tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      // }

      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: anim, curve: Curves.easeInOut),
        ),
        // child: FadeTransition(
        //   opacity: anim,
        //   child: child,
        // ),
        child: child,
      );
    },
  ).then(onValue);
}
