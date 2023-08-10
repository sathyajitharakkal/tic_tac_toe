import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/UI/home_screen.dart';
import 'package:tic_tac_toe/minmax_algorthm/minmax.dart';
import 'package:tic_tac_toe/utils/colors.dart';
import 'package:tic_tac_toe/utils/style.dart';
import 'package:tic_tac_toe/utils/utils.dart';
import 'package:tic_tac_toe/widgets/progress_indicator.dart';

class TicTacToeScreen extends StatefulWidget {
  final bool system;
  final SharedPreferences prefs;

  const TicTacToeScreen({Key? key, required this.system, required this.prefs})
      : super(key: key);

  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<List<String>> _board = List.generate(3, (_) => List.filled(3, ""));
  String _currentPlayer = "X";
  late TicTacToeAI _ai;

  @override
  void initState() {
    //load data from local storage to get saved data
    _loadGameState();
    if (widget.system) {
      _ai = TicTacToeAI("O", "X");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          widget.system ? "AI" : "DUO",
          style: boldTextStyle,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!widget.system)
              Column(
                children: [
                  Text(
                    'Turn : Player $_currentPlayer',
                    style: boldTextStyle.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  final row = index ~/ 3;
                  final col = index % 3;
                  return GestureDetector(
                    onTap: () => _makeMove(row, col),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: Center(
                          child: _board[row][col] == "O"
                              ? Image.asset(
                                  "assets/O.png",
                                  color: shadeBlueNeon,
                                  height: 50,
                                  width: 50,
                                )
                              : _board[row][col] == "X"
                                  ? Image.asset(
                                      "assets/X.png",
                                      color: shadeRedNeon,
                                      height: 50,
                                      width: 50,
                                    )
                                  : Container()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text(
            'Game Over',
            style: boldTextStyle,
          ),
          content: Text(
            result,
            style: semiBoldTextStyle,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _resetBoard();
                Navigator.pop(context);
              },
              child: Text(
                'Play Again',
                style: semiBoldTextStyle.copyWith(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
    _resetBoard(); //reset board once game is over
  }

  void _saveGameState() {
    //save data to shared preference
    widget.prefs.setString(prefsKey, json.encode(_board));
    widget.prefs.setString('current_player', _currentPlayer);
  }

  void _loadGameState() {
    //Retreive stored data from shared preference
    String gameState = widget.prefs.getString(prefsKey) ?? "";
    if (gameState != "") {
      setState(() {
        List<List> temp = List<List>.from(json.decode(gameState));
        _board = convertListOfLists(temp);
        _currentPlayer = widget.prefs.getString('current_player') ?? "X";
      });
    }
  }

  void _makeMove(int row, int col) {
    //initiate a move if AI or ask 2nd player to make a move
    if (_board[row][col] == "") {
      setState(() {
        _board[row][col] = _currentPlayer;
        _currentPlayer = (_currentPlayer == "X") ? "O" : "X";
      });
    }

    // Check for a win or draw
    if (_checkForWin("X")) {
      // X wins
      _showResultDialog("X Wins!");
    } else if (_checkForWin("O")) {
      // O wins
      _showResultDialog("O Wins!");
    } else if (_isBoardFull()) {
      // Draw
      _showResultDialog("It's a Draw!");
    }

    if (widget.system) {
      if (_currentPlayer == "O") {
        _makeAiMove();
      }
    }
    _saveGameState();
  }

  bool _isBoardFull() {
    //Check if there is space remaining in the board
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == "") {
          //empty space available, board not full
          return false;
        }
      }
    }
    //didnt found empty space, board is  full
    return true;
  }

  void _resetBoard() {
    //Reset board on game over
    setState(() {
      _board = List.generate(3, (_) => List.filled(3, ""));
      _currentPlayer = "X";
      _saveGameState();
    });
  }

  void _makeAiMove() {
    //Iniiate a move by AI
    Move bestMove = _ai.findBestMove(_board);
    if (bestMove.row != -1 && bestMove.col != -1) {
      _makeMove(bestMove.row, bestMove.col);
    }
  }

  bool _checkForWin(String player) {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] == player &&
          _board[i][1] == player &&
          _board[i][2] == player) {
        //won in row[i]
        return true;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (_board[0][i] == player &&
          _board[1][i] == player &&
          _board[2][i] == player) {
        //won in column[i]
        return true;
      }
    }

    // Check diagonals
    if (_board[0][0] == player &&
        _board[1][1] == player &&
        _board[2][2] == player) {
      //won in right diagonal
      return true;
    }
    if (_board[0][2] == player &&
        _board[1][1] == player &&
        _board[2][0] == player) {
      //won in left diagonal
      return true;
    }

    //match continues
    return false;
  }
}
