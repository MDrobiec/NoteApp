import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/note_view_bloc.dart';
import 'package:note_app/const/const.dart';
import 'package:note_app/screen/error_view.dart';
import 'package:note_app/screen/loading_view.dart';
import 'package:note_app/screen/main_view.dart';

class NoteView extends StatefulWidget {
  const NoteView({Key? key, this.id}) : super(key: key);
  final int? id;
  @override
  State<StatefulWidget> createState() => _NoteView();
}

class _NoteView extends State<NoteView> {
  final NoteViewBloc noteViewBloc = NoteViewBloc();
  final _formKey = GlobalKey<FormState>();

  String noteName = '';
  String topicNoteName = '';
  String contents = '';
  String dateAdd = '';
  int stat = 0;
  int id = 0;
  @override
  void initState() {
    if (widget.id == null) {
      noteViewBloc.add(const LoadNoteNewView());
    } else {
      noteViewBloc.add(LoadNoteView(widget.id!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (widget.id == null) {
                } else {
                  noteViewBloc.add(ArchiveNote(context, id));
                }
              },
              icon: const Icon(Icons.save)),
          IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  noteViewBloc.add(SaveNewNote(context, noteName, topicNoteName,
                      dateAdd.toString(), contents, stat, id));
                }
              },
              icon: const Icon(Icons.archive))
        ],
        backgroundColor: colorAppBar,
        title: const Text('Details notes'),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainView())),
        ),
      ),
      body: BlocProvider(
        create: (_) => noteViewBloc,
        child: BlocListener<NoteViewBloc, NoteViewState>(
          listener: (context, state) {},
          child: BlocBuilder<NoteViewBloc, NoteViewState>(
            builder: (context, state) {
              if (state is NoteViewInitial) {
                return const LoadingView();
              } else if (state is NoteViewLoading) {
                return const LoadingView();
              } else if (state is NoteViewLoaded) {
                dateAdd = state.date;
                stat = state.stateid;
                id = state.id;
                return buildView(state.stateid, state.date, state.state,
                    state.name, state.context);
              } else if (state is NoteViewError) {
                return ErrorView(nameError: state.errorName);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildView(state, date, stateDesc, name, context) =>
      SingleChildScrollView(
          child: Container(
        height: 500,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    readOnly: (state == 2 || state == 1) ? true : false,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.title),
                      hintText: name,
                    ),
                    onChanged: ((value) {
                      setState(() {
                        noteName = value;
                      });
                    }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter value';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: 5,
                    readOnly: (state == 2 || state == 1),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.description),
                      hintText: context,
                    ),
                    onChanged: (value) {
                      setState(() {
                        contents = value;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter value';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: state == 3 ? false : true,
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  icon: const Icon(Icons.date_range),
                  hintText: date.toString(),
                ),
              ),
            ),
            Visibility(
              visible: state == 3 ? false : true,
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  icon: const Icon(Icons.near_me),
                  hintText: stateDesc,
                ),
              ),
            ),
          ],
        ),
      ));
}
