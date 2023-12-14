import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final storage = FirebaseStorage.instance.ref();
  User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> itemList = [];

  @override
  void initState() {
    super.initState();
    if (user != null) {
      getCartItems(user!);
    }
  }

  Future<void> getCartItems(User currentUser) async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: currentUser.email)
        .get();

    if (snap.docs.isNotEmpty) {
      Map<String, dynamic> doc = snap.docs.first.data() as Map<String, dynamic>;
      if (doc["cartProdIds"] != null) {
        List<dynamic> cartItems = doc["cartProdIds"];
        List<Future<void>> futures = [];

        for (var item in cartItems) {
          await getExactItem(item);
        }
        await Future.wait(futures);
      }
    }
  }

  Future<String> getImageUrl(dynamic id) async {
    final prod = storage.child('products');
    final imgRef = prod.child('$id.png');
    final networkImgUrl = await imgRef.getDownloadURL();
    return networkImgUrl;
  }

  Future<void> getExactItem(dynamic docId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('innovations')
        .doc(docId)
        .get();

    if (doc.exists) {
      Map<String, dynamic> itemData = doc.data() as Map<String, dynamic>;
      String imageUrl = await getImageUrl(itemData['ImgId']);
      itemData['imageUrl'] = imageUrl;
      setState(() {
        itemList.add(itemData);
      });
    } else {
      setState(() {
        itemList.add({});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: itemList.isEmpty
          ? const Text('No items in your cart')
          : ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                final item = itemList[index];
                if (item.isEmpty) {
                  return const Text("Item doesn't exist");
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(
                                        item['imageUrl'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item['Title']),
                                          Text(item['Description']),
                                          Text(item['Category']),
                                          Text(item['City']),
                                          Text(item['State']),
                                          Text(item['Price'].toString()),
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
              },
            ),
    );
  }
}
