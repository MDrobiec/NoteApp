import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/main_view_bloc.dart';
import 'package:note_app/const/const.dart';
import 'package:note_app/model/notes.dart';
import 'package:note_app/screen/error_view.dart';
import 'package:note_app/screen/loading_view.dart';
import 'package:note_app/screen/note_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MainView();
}

class _MainView extends State<MainView> {
  final MainViewBloc mainViewBloc = MainViewBloc();
  Color _colors = Colors.red;

  @override
  void initState() {
    mainViewBloc.add(LoadMainView());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note list'),
        backgroundColor: colorAppBar,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: colorAppBar,
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
              } else if (state is MainViewLoadedNav) {
                return buildView([]);
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
          child: Container(
        height: 700,
        padding: const EdgeInsets.only(top: 20),
        child: RawScrollbar(
            child: RefreshIndicator(
          onRefresh: () async {
            mainViewBloc.add(LoadMainView());
          },
          child: ListView.builder(
              itemCount: listNote.length,
              itemBuilder: ((context, index) {
                ModelNotes modelNotes = listNote[index];
                if (modelNotes.state == 0) {
                  _colors = Colors.blueAccent;
                } else if (modelNotes.state == 1) {
                  _colors = Colors.greenAccent;
                } else if (modelNotes.state == 2) {
                  _colors = Colors.redAccent;
                }
                return Column(
                  children: [
                    GestureDetector(
                      onDoubleTap: (() async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NoteView(id: modelNotes.id!)));
                      }),
                      child: ListTile(
                        title: Card(
                            color: _colors,
                            child: ClipPath(
                              clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Column(children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Text('  Notes name: '),
                                    Text(
                                      modelNotes.state.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('  Notes date: '),
                                    Text(modelNotes.noteDate),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          return showDialog(
                                              context: context,
                                              builder: (cts) => AlertDialog(
                                                    title: const Text(
                                                        "Archive note"),
                                                    content: const Text(
                                                        "Do you want to archive note"),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .green)),
                                                          onPressed: () {
                                                            Navigator.of(cts)
                                                                .pop();
                                                            mainViewBloc.add(
                                                                ArchiveNote(
                                                                    context,
                                                                    modelNotes
                                                                        .id!));
                                                          },
                                                          child: const Text(
                                                              'Yes')),
                                                      ElevatedButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .red)),
                                                          onPressed: () {
                                                            Navigator.of(cts)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text('No'))
                                                    ],
                                                  ));
                                        },
                                        icon: const Icon(
                                          Icons.archive,
                                          color: Colors.white,
                                        ))
                                  ],
                                )
                              ]),
                            )),
                      ),
                    )
                  ],
                );
              })),
        )),
      ));
}
