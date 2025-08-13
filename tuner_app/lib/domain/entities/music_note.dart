// dominio/entidades/nota_musical.dart

class MusicNote {
  final int pitchClass; 
  final int octave;

  MusicNote(this.pitchClass, this.octave);

  String name({
    bool useLatin = true,
    bool useSharp = true,
  }) {
    const nombresLatinosSost = [
      "Do", "Do#", "Re", "Re#", "Mi", "Fa",
      "Fa#", "Sol", "Sol#", "La", "La#", "Si"
    ];
    const nombresLatinosBemol = [
      "Do", "Reb", "Re", "Mib", "Mi", "Fa",
      "Solb", "Sol", "Lab", "La", "Sib", "Si"
    ];
    const nombresInglesSost = [
      "C", "C#", "D", "D#", "E", "F",
      "F#", "G", "G#", "A", "A#", "B"
    ];
    const nombresInglesBemol = [
      "C", "Db", "D", "Eb", "E", "F",
      "Gb", "G", "Ab", "A", "Bb", "B"
    ];

    List<String> nombres;
    if (useLatin) {
      nombres = useSharp ? nombresLatinosSost : nombresLatinosBemol;
    } else {
      nombres = useSharp ? nombresInglesSost : nombresInglesBemol;
    }

    return "${nombres[pitchClass]}$octave";
  }
}
