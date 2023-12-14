import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resculpt/screens/cart_screen.dart';
import 'package:resculpt/screens/payment.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  final storage = FirebaseStorage.instance.ref();

  Future<String> getImageUrl(dynamic id) async {
    final prod = storage.child('products');
    // final mail = waste.child('$userEmail');
    final imgRef = prod.child('$id.png');
    final networkImgUrl = await imgRef.getDownloadURL();
    print(networkImgUrl);
    return networkImgUrl;
  }

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
    CollectionReference dbData =
        FirebaseFirestore.instance.collection('innovations');
    return FutureBuilder<DocumentSnapshot>(
      future: dbData.doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String imgId = data['ImgId'];
          // print(imgId);
          return FutureBuilder(
              future: getImageUrl(imgId),
              builder: ((context, urlSnapshot) {
                if (urlSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (urlSnapshot.hasError) {
                  print('Error loading image: ${urlSnapshot.error}');
                  return const Text('Error loading image');
                } else if (!urlSnapshot.hasData || urlSnapshot.data == null) {
                  return const Text('No image available');
                } else {
                  return ListTile(
                    subtitle: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Card(
                              elevation: 7,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image on the left
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(
                                        urlSnapshot
                                            .data!, // Use the retrieved URL here
                                        fit: BoxFit
                                            .cover, // Adjust as per your UI requirement
                                      ),
                                    ),
                                  ),
                                  // Text on the right
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data['Title']),
                                          Text(data['Description']),
                                          Text(data['Category']),
                                          Text(data['City']),
                                          Text(data['State']),
                                          Text(data['Price'].toString()),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PaymentScreen(
                                                    amount: data['Price'],
                                                    title: data['Title'],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Text('Buy'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              // print(widget.documentId);
                                              if (currentUser != null) {
                                                await addToCart(currentUser,
                                                    widget.documentId);
                                                print('Item added to cart!');
                                              }
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CartScreen(),
                                                ),
                                              );
                                            },
                                            child: const Text('add to cart'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  );
                }
              }));
          // return Column(
          //   children: [
          //     Text(data['Title']),
          //     Text(data['Category']),
          //     Text(data['Description']),
          //     Text(data['Price'].toString()),
          //     SizedBox(height: 30),
          //   ],
          // );
        }
        return Text("loading...");
      },
    );
  }
}
