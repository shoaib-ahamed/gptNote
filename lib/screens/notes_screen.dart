import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/firebase_consts.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String? note;
  String? noteId;
  Timestamp? createdAt;
  // bool _isLoading = false;
  final User? user = authInstance.currentUser;
  @override
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("notes")
          .where("userId", isEqualTo: user?.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("something error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Text("no data found");
        }
        // ignore: unnecessary_null_comparison
        if (snapshot != null && snapshot.data != null) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var note = snapshot.data!.docs[index]['note'];
                // var createdAt = snapshot.data!.docs[index]['createdAt'];
                return Card(
                    child: ListTile(
                  title: Text(note),
                  // subtitle: Text(createdAt.toString()),
                ));
              });
        }

        return Container();
      },
    );
  }
}
