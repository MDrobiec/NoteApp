import 'package:flutter/material.dart';
import 'package:note_app/const/const.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  _ErrorView createState() => _ErrorView();
}

class _ErrorView extends State<LoadingView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: const [
        SizedBox(
          height: margin,
        ),
        SizedBox(
          child: CircularProgressIndicator(),
        )
      ]),
    );
  }
}
