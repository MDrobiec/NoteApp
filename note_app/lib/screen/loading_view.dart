import 'package:flutter/material.dart';

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
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          child: CircularProgressIndicator(),
        )
      ]),
    );
  }
}
