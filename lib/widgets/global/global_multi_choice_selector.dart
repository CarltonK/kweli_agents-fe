import 'package:flutter/material.dart';
import '../../utilities/utilities.dart';

List<String> userSelection = [];

class GlobalMultiChoiceSelector extends StatefulWidget {
  final List<String> selectionItems;
  const GlobalMultiChoiceSelector({
    Key? key,
    required this.selectionItems,
  }) : super(key: key);

  @override
  _GlobalMultiChoiceSelectorState createState() =>
      _GlobalMultiChoiceSelectorState();
}

class _GlobalMultiChoiceSelectorState extends State<GlobalMultiChoiceSelector> {
  bool isIncluded(String value) {
    return userSelection.contains(value) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Which goods are sold?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Wrap(
            direction: Axis.horizontal,
            children: widget.selectionItems
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 3,
                      ),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: isIncluded(e),
                        onSelected: (newValue) {
                          if (!userSelection.contains(e)) {
                            userSelection.add(e);
                          } else {
                            userSelection.remove(e);
                          }
                          setState(() {});
                        },
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
