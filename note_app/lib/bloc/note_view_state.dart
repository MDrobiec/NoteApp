part of 'note_view_bloc.dart';

abstract class NoteViewState extends Equatable {
  const NoteViewState();

  @override
  List<Object> get props => [];
}

class NoteViewInitial extends NoteViewState {
  const NoteViewInitial();
  @override
  List<Object> get props => [];
}

class NoteViewLoading extends NoteViewState {
  const NoteViewLoading();
  @override
  List<Object> get props => [];
}

class NoteViewLoaded extends NoteViewState {
  final String state;
  final int stateid;
  final String date;
  final String name;
  final String context;
  final int id;
  const NoteViewLoaded(
      this.state, this.date, this.stateid, this.name, this.context, this.id);
  @override
  List<Object> get props => [];
}

class NoteViewError extends NoteViewState {
  const NoteViewError(this.errorName);
  final String errorName;
  @override
  List<Object> get props => [];
}
