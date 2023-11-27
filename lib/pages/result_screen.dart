import 'package:flutter/material.dart';

import '../components/top_menu.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, String> results;
  final Color color;

  ResultScreen({required this.results, required this.color});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TopMenu(size: size),
            _buildResultCard('Arabic Transcription', results['ar_transcribe'] ?? ''),
            _buildResultCard('English Transcription', results['en_transcribe'] ?? ''),
            _buildResultCard('Arabic Summary', results['ar_summary'] ?? ''),
            _buildResultCard('English Summary', results['en_summary'] ?? ''),
            _buildResultCard('Transcription with Timestamp', results['transcribe_with_time_stamp'] ?? ''),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to save files and generate STR
              },
              child: Text('Save & Generate Files'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(String title, String content) {
    return Card(
      elevation: 4,
      color: color,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.file_download, color: Colors.white),
                  onPressed: () {
                    // Logic to save file
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
