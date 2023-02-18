import 'dart:convert';
import 'package:laguu/state_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _word = '';

  void _generateWord() async {
    final uri = Uri.parse('https://random-word-api.herokuapp.com/word');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      setState(() {
        final jsonResponse = json.decode(response.body);
        _word = jsonResponse[0];
      });
    } else {
      throw Exception('Failed to load word');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _word,
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _generateWord,
              child: Text('Generate Word'),
            ),
          ],
        ),
      ),
    );
  }
}
