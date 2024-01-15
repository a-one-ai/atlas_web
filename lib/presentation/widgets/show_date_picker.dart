import 'package:atlas_web/core/app/app_export.dart';

Future<DateTime?> openShowDatePicker(context) async {
  return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: 'Cairo',
                    bodyColor: ColorConstant.whiteA700,
                  ),
              colorScheme: ColorScheme.dark(
                primary: ColorConstant.black900, // header background color
                onPrimary: Colors.white, // header text color
                // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: ColorConstant.whiteA700, // button text color
                ),
              ),
            ),
            child: child!,
          ));
}
