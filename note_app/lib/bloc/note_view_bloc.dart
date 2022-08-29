import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'note_view_event.dart';
part 'note_view_state.dart';

class NoteViewBloc extends Bloc<NoteViewEvent, NoteViewState> {
  NoteViewBloc() : super(NoteViewInitial()) {
    on<NoteViewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
