import 'package:flutter/material.dart';
import 'package:wave_project/screens/main_page/local_widgets/wave_widget.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(),
              WaveWidget()
            ],
          ),
        ));
  }
}
