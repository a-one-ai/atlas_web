import 'package:atlas_web/model/transcription_response.dart';
import 'package:atlas_web/presentation/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/background.dart';
import 'widget/result_card.dart';

class ResultScreen extends StatelessWidget {
  final TranscriptionResponse results;
  final Color color;

  const ResultScreen({super.key, required this.results, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Column(
          children: [
            const LogoWidget(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ResultCard(
                      content: results.data?.script ?? "",
                      translation: results.data?.translation ?? "",
                      color: color,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
