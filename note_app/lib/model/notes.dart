class ModelNotes {
  int? id = 0;
  String noteName = '';
  String topicNoteName = '';
  String noteDate = '';
  String contents = '';
  int state = 0;

  ModelNotes(
      {this.id,
      required this.noteName,
      required this.topicNoteName,
      required this.noteDate,
      required this.contents,
      required this.state});

  factory ModelNotes.fromJson(Map<String, dynamic> json) => ModelNotes(
      id: json["note_id"],
      noteName: json["note_name"],
      topicNoteName: json["topic_note_name"],
      noteDate: json["note_date"],
      contents: json["contents"],
      state: json["state"]);

  Map<String, dynamic> toMap() => {
        "note_name": noteName,
        "topic_note_name": topicNoteName,
        "note_date": noteDate,
        "contents": contents,
        "state": state
      };
}
