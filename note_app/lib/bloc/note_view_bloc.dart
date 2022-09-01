import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/db/db_request.dart';
import 'package:note_app/model/notes.dart';
import 'package:note_app/screen/main_view.dart';

part 'note_view_event.dart';
part 'note_view_state.dart';

class NoteViewBloc extends Bloc<NoteViewEvent, NoteViewState> {
  NoteViewBloc() : super(const NoteViewInitial()) {
    on<LoadNoteView>((event, emit) async {
      String stateName = '';
      int stateid = 0;
      int id = 0;
      final response = await DBRequest().getOneNotes(event.id);
      if (response.isEmpty) {
      } else {
        ModelNotes modelNotes = response[0];
        id = modelNotes.id!;
        if (modelNotes.state == 0) {
          stateName = 'Notatka w edycji';
        } else if (modelNotes.state == 1) {
          stateName = 'Notatka zaakceptowana';
        } else if (modelNotes.state == 2) {
          stateName = 'Notatka archiwalna';
        }
        try {
          emit(const NoteViewLoading());
          emit(NoteViewLoaded(stateName, modelNotes.noteDate, stateid,
              modelNotes.noteName, modelNotes.contents, id));
        } catch (error) {
          emit(NoteViewError(error.toString()));
        }
      }
    });
    on<SaveNewNote>((event, emit) async {
      try {
        if (event.state == 3) {
          emit(const NoteViewLoading());

          List<ModelNotes> modelNotes = [];
          modelNotes.add(ModelNotes(
              noteName: event.noteName,
              topicNoteName: event.noteName,
              noteDate: event.noteDate,
              contents: event.contents,
              state: 0));
          await DBRequest().insertNotes(modelNotes);
          Navigator.pushReplacement(event.context,
              MaterialPageRoute(builder: (context) => const MainView()));
        } else if (event.state == 0) {
          await DBRequest()
              .updateNoteOne(event.id, event.noteName, event.contents);
          Navigator.pushReplacement(event.context,
              MaterialPageRoute(builder: (context) => const MainView()));
        } else {
          Navigator.pushReplacement(event.context,
              MaterialPageRoute(builder: (context) => const MainView()));
        }
      } catch (error) {
        emit(NoteViewError(error.toString()));
      }
    });
    on<LoadNoteNewView>((event, emit) async {
      try {
        emit(const NoteViewLoading());
        DateTime now = DateTime.now();
        String stateName = '';
        int stateid = 3;
        String name = '';
        String context = '';
        int id = 0;
        var date = DateFormat('yyyy-MM-dd  HH:mm').format(now);
        emit(NoteViewLoaded(stateName, date, stateid, name, context, id));
      } catch (error) {
        emit(NoteViewError(error.toString()));
      }
    });
    on<ArchiveNote>(((event, emit) async {
      try {
        emit(const NoteViewLoading());
        await DBRequest().updateNote(event.id);
        Navigator.pushReplacement(event.context,
            MaterialPageRoute(builder: (context) => const MainView()));
      } catch (error) {
        emit(NoteViewError(error.toString()));
      }
    }));
  }
}
