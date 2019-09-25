import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                leading: IconButton(
                  icon: Icon(FontAwesomeIcons.alignLeft),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.cogs),
                  )
                ],
              ),
              SliverFillRemaining(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Text('Feed'),
                    Container(
                      height: 100,
                      color: Colors.red,
                    ),
                    Container(
                      height: 100,
                      color: Colors.black54,
                    ),
                    Container(height: 100, color: Colors.orange),
                    Container(
                      height: 100,
                      color: Colors.red,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
    // Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //     leading: IconButton(
    //       icon: Icon(Icons.menu),
    //     ),
    //     actions: <Widget>[
    //       IconButton(
    //         icon: Icon(Icons.settings),
    //       )
    //     ],
    //   ),
    // );
  }
}
