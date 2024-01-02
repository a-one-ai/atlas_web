
import 'package:atlas_web/Atlas/presentation/result/widget/result_card.dart';
import 'package:flutter/material.dart';

import '../widgets/background.dart';
import '../widgets/top_title.dart';





class ResultScreen extends StatefulWidget {
  final Map<String, dynamic> results;
  final Color color;

  const ResultScreen({super.key, required this.results, required this.color});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length:2, vsync: this);
    _tabController.addListener(_handleTabSelection);

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

    List<Widget> resultCards = [
      // ResultCard(title: 'Script',
      //     content: widget.results['script'] ?? '',
      //     color: widget.color),
      ResultCard(
        title: 'Arabic Transcription',
        content: widget.results['ar_script'] ?? '',
        color: widget.color,),
      ResultCard(
        title: 'English Transcription',
        content: widget.results['en_script'] ?? '',
        color: widget.color,),
      // ResultCard(title: 'Arabic Summary',
      //   content: widget.results['ar_summary'] ?? '',
      //   color: widget.color,),
      // ResultCard(title: 'English Summary',
      //   content: widget.results['en_summary'] ?? '',
      //   color: widget.color,),


    ];

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
          title: TopMenu(iconColor: widget.color,),
          // Assuming TopMenu is a custom widget for the title
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: widget.color,
              labelColor: widget.color,
              unselectedLabelColor: Colors.grey,
              tabs: [
                // _buildTab("Transcription"),
                _buildTab("Arabic Transcription"),
                _buildTab("English Transcription"),
                // _buildTab("Arabic Summary"),
                // _buildTab("English Summary"),

              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              resultCards[_tabController.index],

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
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
