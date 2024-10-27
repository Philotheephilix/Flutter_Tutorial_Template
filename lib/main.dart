import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _noScreenshot = NoScreenshot.instance;

  @override
  void initState() {
    super.initState();
    _noScreenshot.screenshotStream.listen((value) {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Digital Privacy Protection Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  bool result = await _noScreenshot.screenshotOff();
                  debugPrint('Screenshot Off: $result');
                },
                child: const Text('Disable Screenshot'),
              ),
              ElevatedButton(
                onPressed: () async {
                  bool result = await _noScreenshot.screenshotOn();
                  debugPrint('Enable Screenshot: $result');
                },
                child: const Text('Enable Screenshot'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}