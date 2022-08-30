part of 'main_view_bloc.dart';

abstract class MainViewEvent extends Equatable {
  const MainViewEvent();

  @override
  List<Object> get props => [];
}

class LoadMainView extends MainViewEvent {
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
  const ArchiveNote(this.context, this.id);
  final BuildContext context;
  final int id;
  @override
  List<Object> get props => [];
}
