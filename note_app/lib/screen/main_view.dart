import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/main_view_bloc.dart';
import 'package:note_app/model/notes.dart';
import 'package:note_app/screen/error_view.dart';
import 'package:note_app/screen/loading_view.dart';

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
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_circle),
          onPressed: () {
            mainViewBloc.add(NavToNoteView(context));
          }),
      body: BlocProvider(
        create: (_) => mainViewBloc,
        child: BlocListener<MainViewBloc, MainViewState>(
          listener: (context, state) {},
          child: BlocBuilder<MainViewBloc, MainViewState>(
            builder: (context, state) {
              if (state is MainViewInitial) {
                return const LoadingView();
              } else if (state is MainViewLoading) {
                return const LoadingView();
              } else if (state is MainViewLoaded) {
                return buildView(state.listNote);
              } else if (state is MainViewError) {
                return ErrorView(nameError: state.errorName);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildView(List listNote) => SingleChildScrollView(
        child: RawScrollbar(
            child: RefreshIndicator(
          onRefresh: () async {
            mainViewBloc.add(LoadMainView());
          },
          child: ListView.builder(
              itemCount: listNote.length,
              itemBuilder: ((context, index) {
                ModelNotes modelNotes = listNote[index];
                return Column(
                  children: [
                    ListTile(
                      title: Card(
                          child: ClipPath(
                        child: Column(children: [
                          Row(
                            children: [Text(modelNotes.topicNoteName)],
                          )
                        ]),
                      )),
                    )
                  ],
                );
              })),
        )),
      );
}
