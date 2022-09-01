const String databaseName = 'dbNote.db';
const String databaseTableName = 'note';
const String scriptGenerateNoteTable = '''
create table note (
  note_id integer primary key autoincrement,
  note_name TEXT,
  topic_note_name TEXT,
  note_date DATETIME,
  contents TEXT,
  state INT
  )
  ''';
