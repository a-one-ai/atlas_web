import '../app/app_export.dart';

/// A widget that allows for responsive design by rendering different content
/// based on the screen width.
class Responsive extends StatelessWidget {
  /// Widget to be displayed on mobile devices.
  final Widget mobile;

  /// Widget to be displayed on tablet devices. Can be null if not provided.
  final Widget? tablet;

  /// Widget to be displayed on desktop devices.
  final Widget desktop;

  /// Creates a [Responsive] widget.
  ///
  /// The [mobile], [tablet], and [desktop] parameters are required, and they
  /// represent the widgets to be displayed on different screen sizes.
  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  // This size works fine on my design, maybe you need some customization depending on your design

  /// Returns true if the screen width is less than 650 pixels, indicating a mobile device.
  static bool isMobile(BuildContext context) => context.width < 650;

  /// Returns true if the screen width is less than 1100 pixels and greater than or equal to 650 pixels, indicating a tablet device.
  static bool isTablet(BuildContext context) =>
      context.width < 1100 && context.width >= 650;

  /// Returns true if the screen width is greater than or equal to 1100 pixels, indicating a desktop device.
  static bool isDesktop(BuildContext context) => context.width >= 1100;

  @override
  Widget build(BuildContext context) {
    // If our width is more than 1100 pixels, then we consider it a desktop
    if (context.width >= 1100) {
      return desktop;
    }
    // If the width is less than 1100 pixels and more than or equal to 650 pixels, we consider it as a tablet
    else if (context.width >= 650 && tablet != null) {
      return tablet!;
    }
    // Otherwise, for widths less than 650 pixels, we consider it a mobile device
    else {
      return mobile;
    }
  }
}
