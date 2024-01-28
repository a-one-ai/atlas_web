import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../core/app/app_export.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget(
      {super.key,
      required this.items,
      required this.onChange,
      this.initialItem,
      this.hintText});

  final List<String> items;
  final void Function(String? value) onChange;
  final String? initialItem;
  final String? hintText;

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: getMargin(top: 10),
      decoration: BoxDecoration(color: ColorConstant.gray20001),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          value: _selectedItem,
          alignment: AlignmentDirectional.centerEnd,
          hint: Row(children: [
            Text(
              widget.hintText ?? '',
              style: TextStyle(
                color: ColorConstant.gray500,
                fontSize: getFontSize(15),
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w400,
                height: getVerticalSize(1.53),
              ),
            )
          ]),
          iconStyleData: IconStyleData(
              iconDisabledColor: ColorConstant.gray500,
              iconEnabledColor: ColorConstant.gray500,
              openMenuIcon: const Icon(
                Icons.arrow_drop_up,
              )),
          menuItemStyleData: const MenuItemStyleData(),
          isExpanded: true,
          style: TextStyle(color: ColorConstant.black900),
          onChanged: (String? newValue) {
            setState(() => _selectedItem = newValue!);

            widget.onChange(_selectedItem);
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: _selectedItem == value
                  ? Container(
                      width: double.infinity,
                      color: ColorConstant.gray20001,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: ColorConstant.black900,
                          fontSize: getFontSize(15),
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w400,
                          height: getVerticalSize(1.53),
                        ), // Custom text color
                      ),
                    )
                  : Text(
                      value,
                      style: TextStyle(
                        color: ColorConstant.gray500,
                        fontSize: getFontSize(15),
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        height: getVerticalSize(1.53),
                      ), // Custom text color
                    ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
