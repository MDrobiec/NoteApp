import 'package:flutter/material.dart';

class ErrorView extends StatefulWidget {
  final String nameError;
  const ErrorView({Key? key, required this.nameError}) : super(key: key);

  @override
  _ErrorView createState() => _ErrorView();
}

class _ErrorView extends State<ErrorView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          child: Text(widget.nameError),
        )
      ]),
    );
  }
}
