part of 'note_view_bloc.dart';

abstract class NoteViewEvent extends Equatable {
  const NoteViewEvent();

  @override
  List<Object> get props => [];
}

class LoadNoteView extends NoteViewEvent {
  @override
  List<Object> get props => [];
}

class SaveNewNote extends NoteViewEvent {
  const SaveNewNote(this.context, this.noteName, this.topicNoteName,
      this.noteDate, this.contents, this.state);
  final BuildContext context;
  final String noteName;
  final String topicNoteName;
  final DateTime noteDate;
  final String contents;
  final int state;
  @override
  List<Object> get props => [];
}
