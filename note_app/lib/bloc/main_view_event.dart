part of 'main_view_bloc.dart';

abstract class MainViewEvent extends Equatable {
  const MainViewEvent();

  @override
  List<Object> get props => [];
}

class LoadMainView extends MainViewEvent {
  const LoadMainView(this.date, this.state0, this.state1, this.state2);
  final String date;
  final int state0;
  final int state1;

  final int state2;

  @override
  List<Object> get props => [];
}

class NavToNoteView extends MainViewEvent {
  const NavToNoteView(this.context);
  final BuildContext context;
  @override
  List<Object> get props => [];
}

class ArchiveNote extends MainViewEvent {
  const ArchiveNote(
      this.context, this.id, this.date, this.state0, this.state1, this.state2);
  final BuildContext context;
  final int id;
  final String date;
  final int state0;
  final int state1;

  final int state2;
  @override
  List<Object> get props => [];
}
