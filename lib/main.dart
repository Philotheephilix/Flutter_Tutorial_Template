import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static const title = 'Chat Application Example';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const MyHomePage(
          title: title,
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const styleSomebody = BubbleStyle(
    nip: BubbleNip.leftCenter,
    color: Colors.white,
    borderColor: Colors.blue,
    borderWidth: .1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, right: 50),
    alignment: Alignment.topLeft,
  );

  static const styleMe = BubbleStyle(
    nip: BubbleNip.rightCenter,
    color: Color.fromARGB(255, 225, 255, 199),
    borderColor: Colors.blue,
    borderWidth: .1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, left: 50),
    alignment: Alignment.topRight,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(widget.title),
        ),
        body: Container(
          color: Colors.yellow.withAlpha(64),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Bubble(
                alignment: Alignment.center,
                color: const Color.fromARGB(255, 212, 234, 244),
                borderColor: Colors.black,
                borderWidth: .2,
                margin: const BubbleEdges.only(top: 8),
                child: const Text(
                  'TODAY',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Bubble(
                style: styleSomebody,
                child: const Text(
                    'Hi Jason. Sorry to bother you. I have a queston for you.'),
              ),
              Bubble(
                style: styleMe,
                child: const Text("Whats'up?"),
              ),
              Bubble(
                style: styleSomebody,
                child:
                    const Text("I've been having a problem with my computer."),
              ),
              Bubble(
                style: styleSomebody,
                margin: const BubbleEdges.only(top: 4),
                showNip: false,
                child: const Text('Can you help me?'),
              ),
              Bubble(
                style: styleMe,
                child: const Text('Ok'),
              ),
              Bubble(
                style: styleMe,
                showNip: false,
                margin: const BubbleEdges.only(top: 4),
                child: const Text("What's the problem?"),
              ),
              Bubble(
                alignment: Alignment.center,
                color: const Color.fromARGB(255, 212, 234, 244),
                margin: const BubbleEdges.only(top: 32, bottom: 16),
                child: const Text("Use this to Display common Details"),
              ),
            ],
          ),
        ),
      );
}