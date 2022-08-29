class ModelNotes {
  int id = 0;
  String noteName = '';
  String topicNoteName = '';
  DateTime noteDate = DateTime.now();
  String contents = '';
  int state = 0;

  ModelNotes(
      {required this.id,
      required this.noteName,
      required this.topicNoteName,
      required this.noteDate,
      required this.contents,
      required this.state});

  factory ModelNotes.fromJson(Map<String, dynamic> json) => ModelNotes(
      id: json["id"],
      noteName: json["noteName"],
      topicNoteName: json["topicNoteName"],
      noteDate: json["noteDate"],
      contents: json["contents"],
      state: json["state"]);
}
