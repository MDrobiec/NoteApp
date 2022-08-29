import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/note_view_bloc.dart';

class NoteView extends StatefulWidget {
  const NoteView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteView();
}

class _NoteView extends State<NoteView> {
  final NoteViewBloc noteViewBloc = NoteViewBloc();
  @override
  void initState() {
    noteViewBloc.add(LoadNoteView());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => noteViewBloc,
        child: BlocListener<NoteViewBloc, NoteViewState>(
          listener: (context, state) {},
          child: BlocBuilder<NoteViewBloc, NoteViewState>(
            builder: (context, state) {
              if (state is NoteViewInitial) {
              } else if (state is NoteViewLoading) {
              } else if (state is NoteViewLoaded) {
                return buildView();
              } else if (state is NoteViewError) {}
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
