import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/UI/board.dart';
import 'package:tic_tac_toe/utils/colors.dart';
import 'package:tic_tac_toe/utils/style.dart';
const String prefsKey = 'game_state';

class HomeScreen extends StatelessWidget {
  SharedPreferences prefs;
  HomeScreen({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                //set navigation parameter as false since not playing with AI
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TicTacToeScreen(system: false, prefs: prefs)));
              },
              child: Container(
                width: 120,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(12),
                decoration:  getBoxDecoration(
                    color: bgColor,
                    border: lightRedNeon,
                    shadow: shadeRedNeon),
                child: Center(
                  child: Text(
                    'DUO',
                    style: boldTextStyle
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //set navigation parameter as true since playing with AI
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TicTacToeScreen(system: true, prefs: prefs,)));
              },
              child: Container(
                width: 120,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(12),
                decoration: getBoxDecoration(
                    color: bgColor,
                    border: lightBlueNeon,
                    shadow: shadeBlueNeon),
                child: Center(
                  child: Text(
                    'AI',
                    style: boldTextStyle
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
