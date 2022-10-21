import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isPressed = false;
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isDarkMode
        ? const Color(0xFF2E3239)
        : Color.fromARGB(228, 249, 248, 248);
    Offset distance = _isPressed ? const Offset(10, 10) : const Offset(30, 30);
    double blur = _isPressed ? 5.0 : 30.0;
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "DarkMode",
                        style: TextStyle(
                            fontSize: 24,
                            color: _isDarkMode ? Colors.white : Colors.black45),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isDarkMode = !_isDarkMode;
                            });
                          },
                          icon: _isDarkMode
                              ? const Icon(
                                  Icons.toggle_off,
                                  size: 40,
                                )
                              : const Icon(
                                  Icons.toggle_on,
                                  size: 40,
                                )),
                    ],
                  ),
                )),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Listener(
                onPointerUp: (_) {
                  setState(() => _isPressed = false);
                },
                onPointerDown: (_) => setState(() => _isPressed = true),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  //BoxDecoration used to decorate the box
                  decoration: BoxDecoration(
                      //BorderRadius causes the container to be round
                      borderRadius: BorderRadius.circular(40),
                      color: backgroundColor,
                      boxShadow: [
                        //create a shadow box at the right hand of the box
                        BoxShadow(
                          blurRadius: blur,
                          offset: -distance,
                          color: _isDarkMode
                              ? const Color(0xFF35393F)
                              : Colors.white,
                          inset: _isPressed,
                        ),
                        //create a shadow at the left of the box
                        BoxShadow(
                            blurRadius: blur,
                            offset: distance,
                            color: _isDarkMode
                                ? Color(0xFF23262A)
                                : Color(0xFFA7A9AF),
                            inset: _isPressed),
                      ]),
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Center(
                        child: _isPressed ? const Text("") : const Text("GO")),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
