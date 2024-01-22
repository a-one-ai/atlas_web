import 'package:atlas_web/core/utils/image_constant.dart';
import 'package:atlas_web/presentation/widgets/custom_button.dart';
import 'package:atlas_web/presentation/widgets/custom_image_view.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import '../../../../services/file_helper/save_file.dart';

class ResultCard extends StatefulWidget {
  final String content;
  final String translation;
  final Color color;

  const ResultCard({
    Key? key,
    required this.content,
    required this.color,
    required this.translation,
  }) : super(key: key);

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (widget.translation.isNotEmpty)
              CustomButton(
                  width: 200,
                  text: "Translate",
                  onTap: () => cardKey.currentState?.toggleCard(),
                  margin: const EdgeInsets.all(20),
                  variant: ButtonVariant.fillBlack900,
                  shape: ButtonShape.Square),
            CustomImageView(
                onTap: () => (cardKey.currentState?.isFront ?? false)
                    ? saveToFile("Transcription", widget.content)
                    : saveToFile("Translation", widget.translation),
                margin: const EdgeInsets.all(20),
                height: 35,
                width: 35,
                svgPath: ImageConstant.txtFileIcon)
          ],
        ),
        FlipCard(
          key: cardKey,
          flipOnTouch: false,
          front: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: widget.color, width: 5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.content,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          back: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: widget.color, width: 5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.translation,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
