const String databaseName = 'dbNote';
const String scriptGenerateNoteTable = '''
create table note (
  note_id INTEGER PRIMAY KEY AUTOINCREMENT,
  note_name TEXT,
  topic_note_name TEXT,
  note_date DATETIME,
  contents TEXT,
  state INT
  )
  ''';
