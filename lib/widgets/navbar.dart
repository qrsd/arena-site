import 'package:flutter_web/material.dart';

class NavBar extends StatelessWidget {
  final navLinks = ['Home', 'Leaderboards', 'Talents'];

  List<Widget> navItems() {
    return navLinks.map((text) {
      return Padding(
        padding: EdgeInsets.only(left: 18),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.blue,
            fontFamily: 'Montserrat-Bold',
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 38),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[...navItems()]..add(Text('test')),
        ),
      ),
    );
  }
}
