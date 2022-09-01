import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/main_view_bloc.dart';
import 'package:note_app/const/const.dart';
import 'package:note_app/function/getDate.dart';
import 'package:note_app/function/menuItemGenerator.dart';
import 'package:note_app/model/notes.dart';
import 'package:note_app/screen/error_view.dart';
import 'package:note_app/screen/loading_view.dart';
import 'package:note_app/screen/note_view.dart';

enum MenuItem { item1, item2, item3, item4 }

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MainView();
}

class _MainView extends State<MainView> {
  final MainViewBloc mainViewBloc = MainViewBloc();
  List<dynamic> duplicateList = <dynamic>[];
  Color _colors = Colors.red;
  DateTime date = DateTime.now();
  bool stat = false;
  List menuBuilder = [0, 1, 2];

  @override
  void initState() {
    mainViewBloc.add(LoadMainView(date.toString().substring(0, 10),
        menuBuilder[0], menuBuilder[1], menuBuilder[2]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note list'),
        backgroundColor: colorAppBar,
        actions: [
          IconButton(
              onPressed: () async {
                date = await GetDate().selectDate(context, date);
                mainViewBloc.add(LoadMainView(date.toString().substring(0, 10),
                    menuBuilder[0], menuBuilder[1], menuBuilder[2]));
              },
              icon: const Icon(Icons.date_range)),
          PopupMenuButton(
              onSelected: (value) {
                if (value == MenuItem.item1) {
                  menuBuilder = MenuItemGenerator().menuGenerator(0);
                  mainViewBloc.add(LoadMainView(
                      date.toString().substring(0, 10),
                      menuBuilder[0],
                      menuBuilder[1],
                      menuBuilder[2]));
                } else if (value == MenuItem.item2) {
                  menuBuilder = MenuItemGenerator().menuGenerator(1);

                  mainViewBloc.add(LoadMainView(
                      date.toString().substring(0, 10),
                      menuBuilder[0],
                      menuBuilder[1],
                      menuBuilder[2]));
                } else if (value == MenuItem.item3) {
                  menuBuilder = MenuItemGenerator().menuGenerator(2);

                  mainViewBloc.add(LoadMainView(
                      date.toString().substring(0, 10),
                      menuBuilder[0],
                      menuBuilder[1],
                      menuBuilder[2]));
                } else if (value == MenuItem.item4) {
                  menuBuilder = MenuItemGenerator().menuGenerator(3);

                  mainViewBloc.add(LoadMainView(
                      date.toString().substring(0, 10),
                      menuBuilder[0],
                      menuBuilder[1],
                      menuBuilder[2]));
                }
              },
              itemBuilder: ((context) => [
                    const PopupMenuItem(
                      value: MenuItem.item1,
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: MenuItem.item2,
                      child: Text('Confirm'),
                    ),
                    const PopupMenuItem(
                      value: MenuItem.item3,
                      child: Text('Archive'),
                    ),
                    const PopupMenuItem(
                      value: MenuItem.item4,
                      child: Text('All'),
                    )
                  ]))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          key: const Key('floatingActionButton'),
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
          child: Column(
        children: [
          SizedBox(
            child: TextFormField(
              minLines: 1,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.send,
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
              ),
              onChanged: (value) {
                if (value.length >= 3) {
                  List<dynamic> dynamicList = <dynamic>[];
                  if (stat == false) {
                    duplicateList.clear();
                    duplicateList.addAll(listNote);
                  }
                  dynamicList.addAll(duplicateList);
                  if (value.isNotEmpty) {
                    List<ModelNotes> dynamicModelList = <ModelNotes>[];
                    if (value.contains(' ')) {
                      var vvalue = value.split(' ');
                      dynamicList.forEach((item) {
                        if (item.noteName.contains(vvalue[0]) &&
                            item.contents.contains(vvalue[1])) {
                          dynamicModelList.add(item);
                        }
                      });
                      setState(() {
                        stat = true;
                        listNote.clear();
                        listNote.addAll(dynamicModelList);
                      });
                      return;
                    } else {
                      setState(() {
                        stat = false;
                        mainViewBloc.add(LoadMainView(
                            date.toString().substring(0, 10),
                            menuBuilder[0],
                            menuBuilder[1],
                            menuBuilder[2]));
                      });
                    }
                  }
                }
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter value';
                }
                return null;
              },
            ),
          ),
          Container(
            height: heihtViewNotMain,
            padding: const EdgeInsets.only(top: margin),
            child: RawScrollbar(
                child: RefreshIndicator(
              onRefresh: () async {
                mainViewBloc.add(LoadMainView(date.toString().substring(0, 10),
                    menuBuilder[0], menuBuilder[1], menuBuilder[2]));
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
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Column(children: [
                                    const SizedBox(
                                      height: sizedMargin,
                                    ),
                                    Row(
                                      children: [
                                        const Text('  Notes name: '),
                                        Text(
                                          modelNotes.noteName.toString(),
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
                                                                      MaterialStateProperty.all(
                                                                          Colors
                                                                              .green)),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        cts)
                                                                    .pop();
                                                                mainViewBloc.add(ArchiveNote(
                                                                    context,
                                                                    modelNotes
                                                                        .id!,
                                                                    date
                                                                        .toString(),
                                                                    menuBuilder[
                                                                        0],
                                                                    menuBuilder[
                                                                        1],
                                                                    menuBuilder[
                                                                        2]));
                                                              },
                                                              child: const Text(
                                                                  'Yes')),
                                                          ElevatedButton(
                                                              style: ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all(
                                                                          Colors
                                                                              .red)),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        cts)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  'No'))
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
          )
        ],
      ));
}
