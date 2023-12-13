import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resculpt/auth/my_account.dart';
import 'package:resculpt/widgets/get_data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchController = TextEditingController();

  // list to store required document ids
  List<String> docIds = [];

  // get required docIds
  Future<void> getDocIds(String searchQuery) async {
    docIds.clear(); // Clear the previous list

    if (searchQuery.isEmpty) {
      // Retrieve all documents
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('innovations').get();
      querySnapshot.docs.forEach((document) {
        docIds.add(document.reference.id);
      });
    } else {
      // Retrieve documents based on the search query
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('innovations').get();
      querySnapshot.docs.forEach((document) {
        String title = document['Title'] ?? '';
        if (title.toLowerCase().contains(searchQuery.toLowerCase())) {
          docIds.add(document.reference.id);
        }
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Innovative Products'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  // Remove the following line to avoid duplicate calls
                  // getDocIds(_searchController.text);

                  setState(() {
                    // This will trigger the FutureBuilder to rebuild and call getDocIds
                  });
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getDocIds(_searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    itemCount: docIds.length,
                    itemBuilder: (context, index) {
                      return GetData(documentId: docIds[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyAccount(),
            ),
          );
        },
        child: const Text("account"),
      ),
    );
  }
}
