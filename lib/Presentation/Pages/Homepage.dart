import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Models/game.dart';

import 'SettingsPage.dart';
import 'StartPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String lastvalue = "X";

  bool gameover = false;
  int turn = 0;
  String result = " ";
  List<int> scorboard = [0, 0, 0, 0, 0, 0, 0, 0];

  Game game = Game();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  dynamic selectedOption = const Color(0xFF00061a); // Set a default option

  List<dynamic> backgroundOptions = [
    Colors.white, // Default option
    const Color(0xFF00061a),
    'imgs/bg2.png',
    'imgs/bg3.png',
    'imgs/bg4.png',
  ];

  int _currentIndex = 0;

  void onOptionSelected(dynamic option) {
    setState(() {
      selectedOption = option;
    });
  }

  void navigateToStartPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StartPage(),
      ),
    );
  }

  void showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text(result),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  game.board = Game.initGameBoard();
                  lastvalue = "X";
                  gameover = false;
                  result = " ";
                  scorboard = [0, 0, 0, 0, 0, 0, 0, 0];
                });
                Navigator.of(context).pop();
              },
              child: const Text('Replay Game'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: 410,
        decoration: BoxDecoration(
          color: selectedOption is Color ? selectedOption : null,
          image: selectedOption is String
              ? DecorationImage(
                  image: AssetImage(selectedOption),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15.0)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                  child: Text(
                    "X",
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w500,
                        color: Colors.lightBlue),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                "It's ${lastvalue} Turn".toUpperCase(),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15.0)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  child: Text(
                    "O",
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w500,
                        color: Colors.lightGreen),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: boardWidth,
              height: boardWidth,
              child: GridView.count(
                crossAxisCount: Game.boardlengh ~/ 3,
                padding: const EdgeInsets.all(16.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(Game.boardlengh, (index) {
                  return InkWell(
                    onTap: gameover
                        ? null
                        : () {
                            if (game.board![index] == " ") {
                              setState(() {
                                game.board![index] = lastvalue;
                                turn++;
                                gameover = game.winnerCheck(
                                    lastvalue, index, scorboard, 3);
                                if (gameover) {
                                  result = "$lastvalue is the winner";
                                  showResultDialog(
                                      result); // Show result in alert dialog
                                } else if (!gameover && turn == 9) {
                                  result = "It's a tie";
                                  gameover = true;
                                  showResultDialog(
                                      result); // Show result in alert dialog
                                }
                                if (lastvalue == "X") {
                                  lastvalue = "o";
                                } else {
                                  lastvalue = "X";
                                }
                              });
                            }
                          },
                    child: Container(
                      width: Game.blocsize,
                      height: Game.blocsize,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.lightBlueAccent
                                : Colors.lightGreen,
                            fontSize: 64.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Text(
            //   result,
            //   style: const TextStyle(color: Colors.white, fontSize: 40),
            // ),
            ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    game.board = Game.initGameBoard();
                    lastvalue = "X";
                    gameover = false;
                    result = " ";
                    scorboard = [0, 0, 0, 0, 0, 0, 0, 0];
                  });
                },
                icon: const Icon(Icons.replay),
                label: const Text("Replay Game"))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            navigateToStartPage();
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(
                  onOptionSelected: onOptionSelected,
                ),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
