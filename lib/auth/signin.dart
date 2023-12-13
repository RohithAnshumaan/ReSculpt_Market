// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resculpt/auth/forgot_password.dart';
import 'package:resculpt/constants.dart';
import 'package:resculpt/screens/home.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signinUser() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
        _emailController.clear();
        _passwordController.clear();
      } on FirebaseAuthException catch (e) {
        // print(e.code);
        showAlertDialog(context, "Invalid Input", e.code);
      } catch (e) {
        // print("something bad happened");
        // print(e
        //     .runtimeType); //this will give the type of exception that occured
        // print(e);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else if (email.isEmpty) {
      showAlertDialog(context, "Invalid Input", "please enter email");
    } else if (password.isEmpty) {
      showAlertDialog(context, "Invalid Input", "please enter password");
    }
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
                "Email",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Field cannot be empty";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.mail,
                    color:  primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color:  primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Enter your email',
              ),
            ),
          ),
        const Text(
                "Password",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Field cannot be empty";
                }
                return null;
              },
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.lock,
                    color:  primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color:  primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPassword(),
                  ),
                );
              },
              child: const Text("Forgot password", style: TextStyle(color: primaryColor),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ElevatedButton.icon(
            onPressed: _isLoading ? null : signinUser,
            style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: const Size(double.infinity, 56),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                    ),
                    icon: const Icon(
                      CupertinoIcons.arrow_right,
                      color: Colors.white,
                    ),
                    label: const Text("Sign In", style: TextStyle(color: Colors.white),),
          ),
        ),        
      ],
    );
  }
}
