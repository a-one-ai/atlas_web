import 'package:atlas_web/core/app/app_export.dart';
import 'package:intl/intl.dart' as intl;

import 'show_date_picker.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.width,
      this.margin,
      this.controller,
      this.focusNode,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.hintText,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.validator,
      this.onSelectDate});

  TextFormFieldShape? shape;

  TextFormFieldPadding? padding;

  TextFormFieldVariant? variant;

  TextFormFieldFontStyle? fontStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  TextEditingController? controller;

  FocusNode? focusNode;

  bool? isObscureText;

  TextInputAction? textInputAction;

  TextInputType? textInputType;

  int? maxLines;

  String? hintText;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  Widget? suffix;

  BoxConstraints? suffixConstraints;

  FormFieldValidator<String>? validator;
  void Function(String value)? onSelectDate;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(context: context),
          )
        : _buildTextFormFieldWidget(context: context);
  }

  _buildTextFormFieldWidget({required BuildContext context}) {
    return Container(
      height: getVerticalSize(50),
      width: width ?? double.maxFinite,
      margin: margin,
      child: TextFormField(
        onTap: (onSelectDate != null)
            ? () async {
                DateTime? date = await openShowDatePicker(context);
                String stringDate = date.toString();
                if (stringDate.isNotEmpty) {
                  final intl.DateFormat displayFormatter =
                      intl.DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
                  final intl.DateFormat serverFormatter =
                      intl.DateFormat('yyyy-MM-dd');
                  final DateTime displayDate =
                      displayFormatter.parse(stringDate);
                  final String formatted = serverFormatter.format(displayDate);
                  onSelectDate!(formatted);
                }
              }
            : null,
        controller: controller,
        focusNode: focusNode,
        readOnly: onSelectDate != null,
        style: TextStyle(
          color:
              _setFilled() ? ColorConstant.black900 : ColorConstant.whiteA700,
          fontSize: getFontSize(15),
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w400,
          height: getVerticalSize(1.53),
        ),
        obscureText: isObscureText!,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        validator: validator,
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: _setFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: const EdgeInsets.all(15),
    );
  }

  _setFontStyle() {
    switch (fontStyle) {
      case TextFormFieldFontStyle.InterRegular14:
        return TextStyle(
          color: ColorConstant.gray500,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w400,
          height: getVerticalSize(
            1.21,
          ),
        );
      case TextFormFieldFontStyle.CairoRegular14Gray500:
        return TextStyle(
          color: ColorConstant.gray500,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w400,
          height: getVerticalSize(
            1.50,
          ),
        );
      default:
        return TextStyle(
          color: ColorConstant.gray500,
          fontSize: getFontSize(
            15,
          ),
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w400,
          height: getVerticalSize(
            1.53,
          ),
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      case TextFormFieldShape.Square:
        return BorderRadius.zero;
      case TextFormFieldShape.RoundedBorder16:
        return BorderRadius.circular(
          getHorizontalSize(
            16.00,
          ),
        );
      case TextFormFieldShape.RoundedBorder5:
        return BorderRadius.circular(
          getHorizontalSize(
            5.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            10.00,
          ),
        );
    }
  }

  _setBorderStyle() {
    switch (variant) {
      case TextFormFieldVariant.OutlinePrimary:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.primaryColor,
            width: 1,
          ),
        );
      case TextFormFieldVariant.OutlineGray20004:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.gray20004,
            width: 1,
          ),
        );
      case TextFormFieldVariant.OutlineGray10001:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.gray10001,
            width: 1,
          ),
        );
      case TextFormFieldVariant.FillGray20005:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.None:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
    }
  }

  _setFillColor() {
    switch (variant) {
      case TextFormFieldVariant.OutlineGray20004:
        return ColorConstant.whiteA700;
      case TextFormFieldVariant.FillGray20005:
        return ColorConstant.gray20005;
      default:
        return ColorConstant.gray20001;
    }
  }

  _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.OutlineGray20004:
        return true;
      case TextFormFieldVariant.OutlineGray10001:
        return false;
      case TextFormFieldVariant.FillGray20005:
        return true;
      case TextFormFieldVariant.None:
        return false;
      default:
        return true;
    }
  }

  _setPadding() {
    switch (padding) {
      case TextFormFieldPadding.PaddingT14:
        return getPadding(
          start: 14,
          top: 14,
          bottom: 14,
        );
      case TextFormFieldPadding.PaddingT17:
        return getPadding(
          start: 16,
          top: 17,
          end: 16,
          bottom: 17,
        );
      case TextFormFieldPadding.PaddingAll4:
        return getPadding(
          all: 5,
        );
      default:
        return getPadding(
          all: 14,
        );
    }
  }
}

enum TextFormFieldShape {
  RoundedBorder10,
  RoundedBorder16,
  RoundedBorder5,
  Square
}

enum TextFormFieldPadding {
  PaddingAll14,
  PaddingT14,
  PaddingT17,
  PaddingAll4,
}

enum TextFormFieldVariant {
  None,
  FillGray20001,
  OutlineGray20004,
  OutlineGray10001,
  FillGray20005,
  OutlinePrimary
}

enum TextFormFieldFontStyle {
  CairoRegular15Gray500,
  InterRegular14,
  CairoRegular14Gray500,
}
