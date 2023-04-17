import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class NoteModel with ChangeNotifier {
  final String note, noteId;
  final Timestamp createdAt;

  NoteModel({
    required this.note,
    required this.noteId,
    required this.createdAt,
  });
}

//'noteId': noteId,
            // 'note': note,
            // 'createdAt': Timestamp.now(),
