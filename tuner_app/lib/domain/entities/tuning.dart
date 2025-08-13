import 'package:tuner_app/domain/entities/music_note.dart';

class Tuning {
  final String tuningName;
  final List<MusicNote> tuningNotes;

  const Tuning({required this.tuningName, required this.tuningNotes});

  String getNotes({
    bool useLatin = true,
    bool useSharp = true,
  }){
    var notes = "";

    for (var note in tuningNotes) {
      notes += '${note.name(useLatin: useLatin, useSharp: useSharp)} ';
    }

    return notes;
  }
}