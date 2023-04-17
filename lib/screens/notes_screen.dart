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
  bool _isLoading = false;
  final User? user = authInstance.currentUser;
  @override
  // void initState() {
  //   getUserNoteData();
  //   super.initState();
  // }

  // Future<void> getUserNoteData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   if (user == null) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     return;
  //   }
  //   try {
  //     String _uid = user!.uid;

  //     // final notedata =
  //     //     await FirebaseFirestore.instance.collection('users').doc(_uid).get();

  //     // print(notedata);

  //     final DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //         .collection('notes')
  //         .where("userId", isEqualTo: _uid);
  //     if (userDoc == null) {
  //       return;
  //     } else {
  //       note = userDoc.get('note');
  //       noteId = userDoc.get('noteId');
  //       createdAt = userDoc.get('createdAt');
  //     }
  //   } catch (error) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     GlobalMethods.errorDialog(subtitle: '$error', context: context);
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final noteProvider = Provider.of<NoteProvider>(context);
    // final noteList = noteProvider.getAllNotes.values.toList().reversed.toList();

    // Map<String, dynamic> allNotes = noteProvider.getAllNotes;
    return Container(
      child: StreamBuilder(
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
      ),
    );
  }
}
