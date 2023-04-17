import 'package:flutter/widgets.dart';
import 'package:gptNote/models/note_model.dart';
import 'package:provider/provider.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({super.key});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    final noteModel = Provider.of<NoteModel>(context);

    return Text(
      noteModel.note,
      // maxLines: maxLines,
      // style: TextStyle(
      //     overflow: TextOverflow.ellipsis,
      //     color: color,
      //     fontSize: textSize,
      //     fontWeight: isTitle ? FontWeight.bold : FontWeight.normal),
    );
  }
}
