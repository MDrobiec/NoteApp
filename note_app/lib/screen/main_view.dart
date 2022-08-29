import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/main_view_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainView();
}

class _MainView extends State<MainView> {
  final MainViewBloc mainViewBloc = MainViewBloc();

  @override
  void initState() {
    mainViewBloc.add(LoadMainView());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => mainViewBloc,
        child: BlocListener<MainViewBloc, MainViewState>(
          listener: (context, state) {},
          child: BlocBuilder<MainViewBloc, MainViewState>(
            builder: (context, state) {
              if (state is MainViewInitial) {
              } else if (state is MainViewLoading) {
              } else if (state is MainViewLoaded) {
                return buildView();
              } else if (state is MainViewError) {}
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildView() => SingleChildScrollView(
        child: Container(),
      );
}
