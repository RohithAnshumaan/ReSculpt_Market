import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resculpt/screens/cart_screen.dart';
import 'package:resculpt/screens/payment.dart';

class GetData extends StatefulWidget {
  const GetData({
    super.key,
    required this.documentId,
  });

  final String documentId;

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  CollectionReference dbData =
      FirebaseFirestore.instance.collection('innovations');

  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> addToCart(User? currentUser, String documentId) async {
    if (currentUser != null) {
      // Update the 'cartProdIds' array in the 'users' collection
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: currentUser.email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.update({
            'cartProdIds': FieldValue.arrayUnion([documentId]),
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference dbData =
    //     FirebaseFirestore.instance.collection('innovations');

    // User? currentUser = FirebaseAuth.instance.currentUser;
    return FutureBuilder<DocumentSnapshot>(
      future: dbData.doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              Text(data['Title']),
              Text(data['Category']),
              Text(data['Description']),
              Text(data['Price'].toString()),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(),
                    ),
                  );
                },
                child: const Text('Buy'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(widget.documentId);
                  if (currentUser != null) {
                    await addToCart(currentUser, widget.documentId);
                    print('Item added to cart!');
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                child: const Text('add to cart'),
              ),
              SizedBox(height: 30),
            ],
          );
        }
        return Text("loading...");
      },
    );
  }
}
