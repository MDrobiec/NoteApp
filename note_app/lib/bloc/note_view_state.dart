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
  const NoteViewLoaded();
  @override
  List<Object> get props => [];
}

class NoteViewError extends NoteViewState {
  const NoteViewError();
  @override
  List<Object> get props => [];
}
