import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/note_view_bloc.dart';
import 'package:note_app/screen/error_view.dart';
import 'package:note_app/screen/loading_view.dart';

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
      appBar: AppBar(
        title: const Text('Details notes'),
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
                return buildView();
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

  Widget buildView() => SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ));
}
