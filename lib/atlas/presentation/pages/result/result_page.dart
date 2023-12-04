import 'package:atlas_web_final/atlas/presentation/pages/result/widget/result_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors/colors_manager.dart';
import '../../services/file_helper/save_file.dart';
import '../../widgets/background.dart';
import '../../widgets/top_menu.dart';


class ResultScreen extends StatefulWidget {
  final Map<String, dynamic> results;
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
      ResultCard(
        title: 'Arabic Transcription',
        content: widget.results['ar_script'] ?? '',
        color: widget.color,),
      ResultCard(
        title: 'English Transcription',
        content: widget.results['en_script'] ?? '',
        color: widget.color,),
      ResultCard(title: 'Arabic Summary',
        content: widget.results['ar_summary'] ?? '',
        color: widget.color,),
      ResultCard(title: 'English Summary',
        content: widget.results['en_summary'] ?? '',
        color: widget.color,),
      ResultCard(title: 'Transcription with Timestamp',
        content: widget.results['transcribe_with_timestamp'].toString() ?? '',
        color: widget.color,),
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
    var size = MediaQuery
        .of(context)
        .size;

    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: null,
          toolbarHeight: 130,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TopMenu(size: size,iconColor: widget.color,),
          // Assuming TopMenu is a custom widget for the title
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
}
