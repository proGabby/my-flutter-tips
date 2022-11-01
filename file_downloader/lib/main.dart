import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  void openFile({required String url, String? filename}) async {
    final name = filename ?? url.split("/").last;
    final file = await downloadFile(url, name);

    if (file == null) return;
    print('path: ${file.path}');

    //open the downloaded file for preview
    OpenFilex.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    try {
      //get storage dir path where file will be saved
      final appStorage = await getExternalStorageDirectory();
      //create a file at that path with the file name
      final file = File('${appStorage!.path}/$name');

      //fetch the resource from the url
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ));

      //open the file for write operation
      final ref = file.openSync(mode: FileMode.write);

      //write the resources gotten from the url to the file
      ref.writeFromSync(response.data);
      //close file
      await ref.close();
      return file;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                openFile(
                    url:
                        "https://phpstack-794034-2715115.cloudwaysapps.com/get/qrcode/image/img-feedguru-1662028598.png");
              },
              child: const Text("Download"))),
    );
  }
}
