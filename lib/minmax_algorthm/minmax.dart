import 'dart:math';

class TicTacToeAI {
  String player;
  String opponent;

  TicTacToeAI(this.player, this.opponent);

  Move findBestMove(List<List<String>> board) {
    int bestScore = -1000;
    Move bestMove = Move(-1, -1);

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == "") {
          board[i][j] = player;

          int score = _minimax(board, 0, false);

          board[i][j] = "";

          if (score > bestScore) {
            bestScore = score;
            bestMove = Move(i, j);
          }
        }
      }
    }

    return bestMove;
  }

  int _evaluate(List<List<String>> board) {
    if (_checkForWin(player, board)) {
      return 10;
    } else if (_checkForWin(opponent, board)) {
      return -10;
    } else {
      return 0;
    }
  }

  int _minimax(List<List<String>> board, int depth, bool isMax) {
    int score = _evaluate(board);

    if (score == 10 || score == -10) {
      return score;
    }

    if (!_isMovesLeft(board)) {
      return 0;
    }

    if (isMax) {
      int best = -1000;

      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == "") {
            board[i][j] = player;
            best = max(best, _minimax(board, depth + 1, !isMax));
            board[i][j] = "";
          }
        }
      }

      return best;
    } else {
      int best = 1000;

      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == "") {
            board[i][j] = opponent;
            best = min(best, _minimax(board, depth + 1, !isMax));
            board[i][j] = "";
          }
        }
      }

      return best;
    }
  }

  bool _isMovesLeft(List<List<String>> board) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == "") {
          return true;
        }
      }
    }
    return false;
  }

  bool _checkForWin(String player, List<List<String>> board) {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == player &&
          board[i][1] == player &&
          board[i][2] == player) {
        return true;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[0][i] == player &&
          board[1][i] == player &&
          board[2][i] == player) {
        return true;
      }
    }

    // Check diagonals
    if (board[0][0] == player &&
        board[1][1] == player &&
        board[2][2] == player) {
      return true;
    }
    if (board[0][2] == player &&
        board[1][1] == player &&
        board[2][0] == player) {
      return true;
    }

    return false;
  }
}

class Move {
  int row;
  int col;

  Move(this.row, this.col);
}
