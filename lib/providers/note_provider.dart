import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gptNote/models/note_model.dart';

import '../consts/firebase_consts.dart';

class NoteProvider with ChangeNotifier {
  Map<String, NoteModel> _noteProvider = {};

  Map<String, NoteModel> get getAllNotes {
    return _noteProvider;
  }

  final users = FirebaseFirestore.instance.collection('users');

  Future<void> fetchNotes() async {
    final User? user = authInstance.currentUser;
    final DocumentSnapshot userDoc = await users.doc(user!.uid).get();
    if (userDoc == null) {
      return;
    }

    // final noteData =
    //     snapshot.docs.map((e) => NoteModel.fromSnapshot(e)).toList();

    // return noteData;
    final leng = userDoc.get('notes').length;
    for (int i = 0; i < leng; i++) {
      _noteProvider.putIfAbsent(
          userDoc.get('notes')[i]['noteId'],
          () => NoteModel(
                note: userDoc.get('notes')[i]['note'],
                noteId: userDoc.get('notes')[i]['noteId'],
                createdAt: userDoc.get('notes')[i]['createdAt'],
              ));
    }
    // print(_noteProvider);
    notifyListeners();
  }
}
