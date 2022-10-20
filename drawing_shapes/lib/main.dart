import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isSuffixIconPressed = false;
  bool _initbuttonstate = false;
  late TextEditingController _textController;
  var text = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController.dispose();
  }

//change the textfield text to * and the icon button
  void changeIcon() {
    text = _textController.text;
    setState(() {
      _isSuffixIconPressed = true;
      _initbuttonstate = true;
    });
    _textController.text = "*" * _textController.text.length;
  }

  //change the textfield text and suffix button to initial state
  void changeIcontoInitState() {
    if (_textController.text.isNotEmpty) {
      if (_initbuttonstate) {
        setState(() {
          _textController.text = text;
          _initbuttonstate = false;
          _isSuffixIconPressed = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: _initbuttonstate
                                ? changeIcontoInitState
                                : changeIcon,
                            icon: _isSuffixIconPressed
                                ? Icon(Icons.energy_savings_leaf_sharp)
                                : Icon(Icons.remove_red_eye)),
                        hintText: "input text here"),
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
