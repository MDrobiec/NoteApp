part of 'note_view_bloc.dart';

abstract class NoteViewEvent extends Equatable {
  const NoteViewEvent();

  @override
  List<Object> get props => [];
}

class LoadNoteNewView extends NoteViewEvent {
  const LoadNoteNewView();
  @override
  List<Object> get props => [];
}

class LoadNoteView extends NoteViewEvent {
  const LoadNoteView(this.id);
  final int id;
  @override
  List<Object> get props => [];
}

class SaveNewNote extends NoteViewEvent {
  const SaveNewNote(this.context, this.noteName, this.topicNoteName,
      this.noteDate, this.contents, this.state, this.id);
  final BuildContext context;
  final String noteName;
  final String topicNoteName;
  final String noteDate;
  final String contents;
  final int state;
  final int id;
  @override
  List<Object> get props => [];
}

class ArchiveNote extends NoteViewEvent {
  const ArchiveNote(this.context, this.id);
  final BuildContext context;
  final int id;
  @override
  List<Object> get props => [];
}
