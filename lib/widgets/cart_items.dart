import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartItems extends StatefulWidget {
  const CartItems({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  final String documentId;

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  CollectionReference cartData =
      FirebaseFirestore.instance.collection('innovations');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: cartData.doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? cartItems =
              snapshot.data?.data() as Map<String, dynamic>?;

          if (cartItems != null) {
            return Column(
              children: [
                Text(cartItems['Title']),
                Text(cartItems['Category']),
                Text(cartItems['Description']),
                Text(cartItems['Price'].toString()),
              ],
            );
          } else {
            // Handle the case where data is null (document not found or other issues)
            return Text('No data available');
          }
        } else {
          // Handle other connection states, e.g., ConnectionState.waiting
          return CircularProgressIndicator();
        }
      },
    );
  }
}
