import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:note_app/db/db_request.dart';
import 'package:note_app/function/navigator.dart';

part 'main_view_event.dart';
part 'main_view_state.dart';

class MainViewBloc extends Bloc<MainViewEvent, MainViewState> {
  MainViewBloc() : super(const MainViewInitial()) {
    on<LoadMainView>((event, emit) async {
      try {
        emit(const MainViewLoading());
        List listNote;
        final response = await DBRequest().getAllNotes();
        if (response.isEmpty) {
          listNote = [];
        } else {
          listNote = response;
        }
        emit(MainViewLoaded(listNote));
      } catch (error) {
        emit(MainViewError(error.toString()));
      }
    });
    on<NavToNoteView>(((event, emit) {
      try {
        emit(const MainViewLoading());
        NavigatorFunction.navigator(event.context, '');
      } catch (error) {
        emit(MainViewError(error.toString()));
      }
    }));
  }
}
