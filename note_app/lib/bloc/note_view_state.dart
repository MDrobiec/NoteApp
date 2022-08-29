part of 'note_view_bloc.dart';

abstract class NoteViewState extends Equatable {
  const NoteViewState();
  
  @override
  List<Object> get props => [];
}

class NoteViewInitial extends NoteViewState {}
