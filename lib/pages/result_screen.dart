import 'package:atlas/components/background.dart';
import 'package:flutter/material.dart';

import '../components/constants.dart';
import '../components/top_menu.dart';
import '../services/save_file.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, String> results;
  final Color color;

  ResultScreen({required this.results, required this.color});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Widget> resultCards;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _initializeResultCards();
  }

  void _initializeResultCards() {
    resultCards = [
      _buildResultCard('Arabic Transcription', widget.results['ar_transcribe'] ?? ''),
      _buildResultCard('English Transcription', widget.results['en_transcribe'] ?? ''),
      _buildResultCard('Arabic Summary', widget.results['ar_summary'] ?? ''),
      _buildResultCard('English Summary', widget.results['en_summary'] ?? ''),
      _buildResultCard('Transcription with Timestamp', widget.results['transcribe_with_time_stamp'] ?? ''),
    ];
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TopMenu(size: size,), // Assuming TopMenu is a custom widget for the title
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: widget.color,
              labelColor: widget.color,
              unselectedLabelColor: Colors.grey,
              tabs: [
                _buildTab("Arabic Transcription"),
                _buildTab("English Transcription"),
                _buildTab("Arabic Summary"),
                _buildTab("English Summary"),
                _buildTab("Transcription with Timestamp"),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20),
              resultCards[_tabController.index],
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
      ),
    );
  }

  Widget _buildTab(String title) {
    return Tab(
      child: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildResultCard(String title, String content) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: kbBackgroundColor,
        border: Border.all(color: widget.color, width: 5),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.file_download_outlined, color: Colors.black),
              onPressed: () {
                // Logic to save file
                var name = title.replaceAll(' ', '_').toLowerCase();
                saveToFile(name, content);
              },
            ),
          ],
        ),
      ),
    );
  }
}
