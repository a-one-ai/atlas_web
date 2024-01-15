import 'package:atlas_web/core/app/app_export.dart';
import 'package:atlas_web/core/utils/adaptive.dart';

class ActionCardWidget extends StatefulWidget {
  const ActionCardWidget(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title,
      required this.color});

  final void Function() onTap;
  final IconData icon;
  final String title;
  final Color color;

  @override
  State<ActionCardWidget> createState() => _ActionCardWidgetState();
}

class _ActionCardWidgetState extends State<ActionCardWidget>
    with TickerProviderStateMixin {
  late Color _unSelectedColor;
  late Color _selectedColor;
  late Color _containerColor;
  late final AnimationController _controller = AnimationController(
    animationBehavior: AnimationBehavior.preserve,
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _unSelectedColor = widget.color;
    _selectedColor = widget.color.withOpacity(0.7);
    _containerColor = widget.color;
    _controller.forward(); // Play the animation forward only once
  }

  @override
  Widget build(BuildContext context) {
    double? width = isDisplayDesktop(context) ? 250 : null;
    double? height = isDisplayDesktop(context) ? 300 : null;

    return InkWell(
      customBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: widget.onTap,
      child: FadeTransition(
        opacity: _animation,
        child: MouseRegion(
          onEnter: (event) => setState(() => _containerColor = _selectedColor),
          onExit: (event) => setState(() => _containerColor = _unSelectedColor),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: _containerColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: ColorConstant.whiteA700,
                            fontSize: getFontSize(18),
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w700,
                            height: getVerticalSize(1.50),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: ColorConstant.whiteA700,
                        )
                      ],
                    ),
                  ),
                  if (isDisplayDesktop(context))
                    Expanded(
                      child: Icon(
                        widget.icon,
                        size: 60,
                        color: ColorConstant.whiteA700,
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
