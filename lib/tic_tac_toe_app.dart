
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/UI/board.dart';
import 'package:tic_tac_toe/UI/home_screen.dart';
import 'package:tic_tac_toe/UI/loader_screen.dart';

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      home: AppLoader(),
    );
  }
}