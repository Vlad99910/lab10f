import 'package:flutter/material.dart';
import 'preview_screen.dart';

void main() {
  runApp(TextPreviewApp());
}

class TextPreviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Previewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _textController = TextEditingController();
  double _fontSize = 16.0;

  Future<void> _showDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToPreview() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(
          text: _textController.text,
          fontSize: _fontSize,
        ),
      ),
    );

    if (result == 'ok') {
      _showDialog('Cool!');
    } else if (result == 'cancel') {
      _showDialog('Let’s try something else');
    } else {
      _showDialog("Don't know what to say");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Previewer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Enter text'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Font size: ${_fontSize.toStringAsFixed(1)}'),
                Expanded(
                  child: Slider(
                    min: 10.0,
                    max: 50.0,
                    value: _fontSize,
                    onChanged: (newSize) {
                      setState(() {
                        _fontSize = newSize;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToPreview,
              child: Text('Preview'),
            ),
          ],
        ),
      ),
    );
  }
}
