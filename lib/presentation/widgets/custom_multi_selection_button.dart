import 'package:atlas_web/core/app/app_export.dart';

class CustomMultiSelectionButton extends StatefulWidget {
  const CustomMultiSelectionButton(
      {super.key,
      required this.items,
      required this.selectedItems,
      required this.onSelection,
      required this.title});

  final List<String> items;
  final List<String> selectedItems;

  final String title;

  final void Function(List<String> selectedItems) onSelection;

  @override
  State<CustomMultiSelectionButton> createState() =>
      _CustomMultiSelectionButtonState();
}

class _CustomMultiSelectionButtonState
    extends State<CustomMultiSelectionButton> {
  List<bool> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.items.map((item) {
      if (widget.selectedItems.contains(item)) {
        return true;
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(top: 5, start: 5, end: 5),
      // constraints: BoxConstraints(minHeight: getVerticalSize(56)),
      // decoration: BoxDecoration(
      //     border: Border.all(color: Theme.of(context).dividerColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: getPadding(bottom: 5),
            child: Text(widget.title,
                style: TextStyle(
                    fontSize: getFontSize(
                  16,
                ))),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: getPadding(top: 3, start: 3, end: 3),
              child: Row(
                children: [
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      // All buttons are selectable.
                      setState(() {
                        _selectedItems[index] = !_selectedItems[index];
                      });

                      List<String> items = [];
                      for (int index = 0;
                          index < _selectedItems.length;
                          index++) {
                        if (_selectedItems[index] == true) {
                          items.add(widget.items[index]);
                        }
                      }

                      widget.onSelection(items);
                    },
                    selectedBorderColor: ColorConstant.mainBlue,
                    selectedColor: ColorConstant.whiteA700,
                    fillColor: ColorConstant.mainBlue,
                    color: ColorConstant.mainBlue,
                    // constraints: BoxConstraints(minHeight: getVerticalSize(53)),
                    isSelected: _selectedItems,
                    children: widget.items
                        .map((item) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(item),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
