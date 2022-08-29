part of 'main_view_bloc.dart';

abstract class MainViewState extends Equatable {
  const MainViewState();

  @override
  List<Object> get props => [];
}

class MainViewInitial extends MainViewState {
  const MainViewInitial();
  @override
  List<Object> get props => [];
}

class MainViewLoading extends MainViewState {
  const MainViewLoading();
  @override
  List<Object> get props => [];
}

class MainViewLoaded extends MainViewState {
  const MainViewLoaded();
  @override
  List<Object> get props => [];
}

class MainViewError extends MainViewState {
  const MainViewError();
  @override
  List<Object> get props => [];
}
