import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'note_view_event.dart';
part 'note_view_state.dart';

class NoteViewBloc extends Bloc<NoteViewEvent, NoteViewState> {
  NoteViewBloc() : super(const NoteViewInitial()) {
    on<LoadNoteView>((event, emit) {
      try {
        emit(const NoteViewLoading());
        emit(const NoteViewLoaded());
      } catch (error) {
        emit(const NoteViewError());
      }
    });
  }
}
