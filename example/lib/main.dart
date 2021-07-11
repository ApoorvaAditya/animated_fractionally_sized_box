import 'package:animated_fractionally_sized_box/animated_fractionally_sized_box.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Fractionally Sized Box Exaple',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int min = 0;
  final int max = 10;
  final double height = 10;
  late int counter;

  @override
  void initState() {
    counter = min;
    super.initState();
  }

  void increment() {
    setState(() {
      counter++;
      counter = counter.clamp(min, max);
    });
  }

  void decrement() {
    setState(() {
      counter--;
      counter = counter.clamp(min, max);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: height,
                  color: Colors.black,
                ),
                AnimatedFractionallySizedBox(
                  duration: Duration(milliseconds: 500),
                  widthFactor: counter / max,
                  child: Container(
                    height: height,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            ElevatedButton(onPressed: increment, child: Text('Increment')),
            ElevatedButton(onPressed: decrement, child: Text('Decrement')),
          ],
        ),
      ),
    );
  }
}
