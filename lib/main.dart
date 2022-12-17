import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.black,
        primaryColorDark: Colors.purple,
        primarySwatch: Colors.blueGrey,
      ),
      home: const TicTacToeHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class TicTacToeHomePage extends StatefulWidget {
  const TicTacToeHomePage({super.key, required this.title});

  final String title;

  @override
  State<TicTacToeHomePage> createState() => _TicTacToeHomePageState();
}

class _TicTacToeHomePageState extends State<TicTacToeHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Tic Tac Toe"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black38, Colors.black, Colors.black38],
              ),
            ),
          ),
        ),
        body: Center(
            child: Container(
                width: 500,
                height: 500,
                constraints: const BoxConstraints(
                  maxHeight: 500,
                  maxWidth: 500,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.indigo,
                          blurRadius: 20,
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 0,
                          offset: Offset(0, -30))
                    ],
                    // gradient: const LinearGradient(
                    //   //tileMode: TileMode.,
                    //     colors: [Color.fromARGB(255, 150, 150, 200), Color.fromARGB(255, 0 , 0, 100)],
                    //     begin: Alignment.topCenter,
                    //     end: Alignment.bottomCenter),
                    color: Colors.indigoAccent,
                    border: Border.all(
                        width: 2,
                        color: Colors.black45,
                        style: BorderStyle.solid)),
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      var txt = [
                        '',
                        'Single Player',
                        'Two Player',
                        'Against Computer'
                      ];

                      List<Widget> onPresses = [
                        Container(),
                        Container(),
                        const TwoPlayer(),
                        Container(),
                      ];

                      if (index == 0) {
                        return const Center(
                            child: Text(
                              "Playing Mode",
                              style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontSize: 30,
                                color: Colors.yellow,
                              ),
                            ));
                      }

                      return ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => onPresses[index]));
                        },
                        child: Text(txt[index]),
                      );
                    }))));
  }
}

class TwoPlayer extends StatefulWidget {
  const TwoPlayer({super.key});
  @override
  State<StatefulWidget> createState() => _TwoPlayerState();
}

class _TwoPlayerState extends State<TwoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Tic Tac Toe"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black38, Colors.black, Colors.black38],
            ),
          ),
        ),
      ),
      body: const Board(),
    );
  }
}

class Board extends StatefulWidget {
  const Board({super.key});
  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  var clickedIndexOut = -1;
  var clickedIndexIn = -1;
  var currentIndex = -1;
  var url=Uri.https("localhost:8080",'');

  void setCurrentIndex(int index) {
    //print(index);

    setState(() {
      currentIndex = index;
    });
  }

  List<List<String>> winListOuter = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  List<List<List<String>>> lst = [
    [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ],
    [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ],
    [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ],
    [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ],
    [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ],
    [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ],
    [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ],
    [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ],
    [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ],
  ];

  String won(List<List<String>> lst) {
    for (var i = 0; i < 3; i++) {
      if (listEquals(lst[i], ['O', 'O', 'O']) ||
          listEquals([lst[0][i], lst[1][i], lst[2][i]], ['O', 'O', 'O']) ||
          listEquals([lst[0][0], lst[1][1], lst[2][2]], ['O', 'O', 'O']) ||
          listEquals([lst[0][2], lst[1][1], lst[2][0]], ['O', 'O', 'O'])) {

        return 'O';
      } else if (listEquals(lst[i], ['X', 'X', 'X']) ||
          listEquals([lst[0][i], lst[1][i], lst[2][i]], ['X', 'X', 'X']) ||
          listEquals([lst[0][0], lst[1][1], lst[2][2]], ['X', 'X', 'X']) ||
          listEquals([lst[0][2], lst[1][1], lst[2][0]], ['X', 'X', 'X'])) {
        return 'X';
      }
    }
    return 'None';
  }

  String wonOut(List<List<List<String>>> list, indexOut) {
    //print("Inside won Function");
    //print(lst[0]);
    var temp = list[indexOut];
    return won(temp);
  }

  void setEmpty() {
    setState(() {
      turn = 'O';
      clickedIndexOut = -1;
      clickedIndexIn = -1;
      currentIndex = -1;
      winListOuter = [
        ['', '', ''],
        ['', '', ''],
        ['', '', ''],
      ];
      lst = [
        [
          ['', '', ''],
          ['', '', ''],
          ['', '', ''],
        ],
        [
          ['', '', ''],
          ['', '', ''],
          ['', '', ''],
        ],
        [
          ['', '', ''],
          ['', '', ''],
          ['', '', ''],
        ],
        [
          ['', '', ''],
          ['', '', ''],
          ['', '', ''],
        ],
        [
          ['', '', ''],
          ['', '', ''],
          ['', '', ''],
        ],
        [
          ['', '', ''],
          ['', '', ''],
          ['', '', ''],
        ],
        [
          ['', '', ''],
          ['', '', ''],
          ['', '', ''],
        ],
        [
          ['', '', ''],
          ['', '', ''],
          ['', '', ''],
        ],
        [
          ['', '', ''],
          ['', '', ''],
          ['', '', ''],
        ],
      ];
    });
  }

  void setLst(indexOut, i, j, winner) {
    setState(() {
      lst[indexOut][i][j] = winner;
    });
  }

  bool checkListFilled(List<List<String>> lst) {
    for (var i = 0; i < lst.length; i++) {
      for (var j = 0; j < lst[i].length; j++) {
        if (lst[i][j] == '') {
          return false;
        }
      }
    }
    return true;
  }

  void winListChange(i, j, winner) {
    setState(() {
      winListOuter[i][j] = winner;
    });
  }

  var turn = 'O';
  void changeTurn() {
    setState(() {
      if (turn == 'O') {
        turn = 'X';
      } else {
        turn = 'O';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //setEmpty();
    return Center(child:AspectRatio(aspectRatio:1,child:Center(

      //child: AspectRatio(aspectRatio: 1,
      child:Container(
          width: 500,
          height: 500,

          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400,),
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color(0x88aaaaaa),
                Color(0x777700aa),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 100,
                    spreadRadius: 40,
                    offset: Offset(0, 0),
                    color: Color(0x777700aa))
              ]),

          //aspectRatio:1,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: 9,
              itemBuilder: (BuildContext context, indexout) {
                return Padding(
                    padding: const EdgeInsets.all(0.5),
                    child: Stack(children: [
                      Container(
                        width: 200,
                        constraints: const BoxConstraints(maxWidth: 150,),
                        decoration: BoxDecoration(
                          color: (winListOuter[indexout ~/ 3]
                          [indexout % 3] !=
                              '' ||
                              checkListFilled(lst[indexout]))
                              ? Colors.black26
                              : Colors.transparent,
                          border: Border.all(
                              width: 1,
                              color: (currentIndex == -1 ||
                                  (winListOuter[indexout ~/ 3]
                                  [indexout % 3] ==
                                      '' &&
                                      ((winListOuter[currentIndex ~/ 3]
                                      [
                                      currentIndex %
                                          3] ==
                                          '' &&
                                          currentIndex ==
                                              indexout) ||
                                          (winListOuter[currentIndex ~/ 3]
                                          [currentIndex % 3] !=
                                              '' &&
                                              currentIndex != indexout))) &&
                                      !checkListFilled(lst[indexout]))
                                  ? Colors.white
                                  : Colors.transparent,
                              style: BorderStyle.solid),
                        ),
                        child: GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                            itemCount: 9,
                            itemBuilder: (BuildContext context, indexin) {
                              return Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white24,
                                          border: Border.all(
                                              width: 1,
                                              color: (clickedIndexOut ==
                                                  indexout &&
                                                  clickedIndexIn ==
                                                      indexin)
                                                  ? Colors.white70
                                                  : Colors.transparent,
                                              style: BorderStyle.solid)),
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            //print(currentIndex);
                                            if (currentIndex == -1 ||
                                                (winListOuter[indexout ~/ 3][
                                                indexout % 3] ==
                                                    '' &&
                                                    ((winListOuter[currentIndex ~/ 3][currentIndex %
                                                        3] ==
                                                        '' &&
                                                        currentIndex ==
                                                            indexout) ||
                                                        (winListOuter[currentIndex ~/ 3][
                                                        currentIndex %
                                                            3] !=
                                                            '' &&
                                                            currentIndex !=
                                                                indexout)) &&
                                                    !checkListFilled(
                                                        lst[indexout]))) {
                                              setCurrentIndex(indexin);
                                              if (lst[indexout]
                                              [indexin ~/ 3]
                                              [indexin % 3] ==
                                                  '') {
                                                //lst[indexin ~/ 3][indexin % 3] = turn;
                                                //print('$turn, $indexout, $indexin');
                                                setLst(
                                                    indexout,
                                                    indexin ~/ 3,
                                                    indexin % 3,
                                                    turn);
                                                changeTurn();

                                                clickedIndexIn = indexin;
                                                clickedIndexOut = indexout;
                                              }

                                              //print(won(lst));
                                              if (won(lst[indexout]) !=
                                                  'None') {
                                                winListChange(
                                                    indexout ~/ 3,
                                                    indexout % 3,
                                                    won(lst[indexout]));
                                                //print('$lst $winListOuter');
                                                //print("Inside Someone Won");
                                                var winner =
                                                won(lst[indexout]);
                                                // Container(
                                                //   alignment: Alignment.center,
                                                //   width: 300,
                                                //   height: 300,
                                                //   decoration:
                                                //       const BoxDecoration(color: Colors.blue),
                                                //   child: Text('Player having $winner won'),
                                                // );
                                                if (won(winListOuter) !=
                                                    'None') {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(

                                                        child: Container(
                                                            width: 300,
                                                            height: 300,
                                                            constraints: const BoxConstraints(
                                                              minHeight: 300,
                                                              maxWidth: 300,
                                                            ),
                                                            child:Column(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .min,
                                                              children: [
                                                                Text(
                                                                    'Player playing $winner Won'),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    // Reset the game here
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                    setEmpty();
                                                                  },
                                                                  child: const Text(
                                                                      'Play again'),
                                                                ),
                                                              ],
                                                            )),
                                                      );
                                                    },
                                                  );
                                                }
                                              }
                                            }
                                          });
                                        },
                                        child: Text(
                                          lst[indexout][indexin ~/ 3]
                                          [indexin % 3],
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: CupertinoColors.black,
                                          ),
                                        ),
                                      )));
                            }),
                      ),
                    ]));
              })),
    )));
  }
}
