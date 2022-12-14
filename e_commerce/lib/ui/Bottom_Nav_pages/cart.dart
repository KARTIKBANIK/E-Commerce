import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/ui/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-card-items")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Somthing is wrong"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
                return Card(
                  elevation: 5.0,
                  child: ListTile(
                    leading: Text(_documentSnapshot["name"]),
                    title: Text(
                      "\$ ${_documentSnapshot["price"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection("users-card-items")
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection("items")
                            .doc(
                              _documentSnapshot.id,
                            )
                            .delete();
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.remove,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
