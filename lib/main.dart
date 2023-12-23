import 'dart:io';

class TicTacToe {
  List<List<String>> board;
  String currentPlayer;

  TicTacToe()
      : board = List.generate(3, (_) => List.filled(3, ' ')),
        currentPlayer = 'X';

  void printBoard() {
    for (var i = 0; i < 3; i++) {
      print(board[i].join(' | '));
      if (i < 2) {
        print('---------');
      }
    }
  }

  bool makeMove(int position) {
    if (position < 1 || position > 9) {
      print('Invalid input. Please enter a number between 1 and 9.');
      return false;
    }

    int row = (position - 1) ~/ 3;
    int col = (position - 1) % 3;

    if (board[row][col] != ' ') {
      print('Cell already occupied. Please choose an empty cell.');
      return false;
    }

    board[row][col] = currentPlayer;
    return true;
  }

  bool checkWin() {
    for (var i = 0; i < 3; i++) {
      if ((board[i][0] == currentPlayer &&
              board[i][1] == currentPlayer &&
              board[i][2] == currentPlayer) ||
          (board[0][i] == currentPlayer &&
              board[1][i] == currentPlayer &&
              board[2][i] == currentPlayer)) {
        return true;
      }
    }

    if ((board[0][0] == currentPlayer &&
            board[1][1] == currentPlayer &&
            board[2][2] == currentPlayer) ||
        (board[0][2] == currentPlayer &&
            board[1][1] == currentPlayer &&
            board[2][0] == currentPlayer)) {
      return true;
    }

    return false;
  }

  bool checkDraw() {
    return board.every((row) => row.every((cell) => cell != ' '));
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  void play() {
    print('Welcome to Tic-Tac-Toe!');
    printBoard();

    while (true) {
      stdout.write('Player $currentPlayer, enter your move (1-9): ');
      String? input = stdin.readLineSync();

      if (input == null) {
        print('Invalid input. Please try again.');
        continue;
      }

      int? position = int.tryParse(input);

      if (position == null || !makeMove(position)) {
        print('Invalid move. Please try again.');
        continue;
      }

      printBoard();

      if (checkWin()) {
        print('Player $currentPlayer wins!');
        break;
      }

      if (checkDraw()) {
        print('The game is a draw!');
        break;
      }

      switchPlayer();
    }
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.play();
}
