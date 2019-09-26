import 'package:flutter_web/material.dart';
import 'widgets/navbar.dart';
import 'widgets/body.dart';

void main() => runApp(ArenaSite());

class ArenaSite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Arena Test Site',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[NavBar(), Body()],
            ),
          ),
        ),
      ),
    );
  }
}
