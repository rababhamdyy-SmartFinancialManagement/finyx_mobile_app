import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_text.dart';

class CustomContainerButton extends StatefulWidget {
  final String text;
  final bool isSwitch;
  final IconData icon;
  final Function(bool)? onSwitchChanged;
  final Function() onPressed;
  final double iconSize;
  final bool initialSelected;

  const CustomContainerButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.isSwitch = false,
    this.onSwitchChanged,
    this.iconSize = 0.02,
    this.initialSelected = false,
  });

  @override
  State<CustomContainerButton> createState() => _CustomContainerButtonState();
}

class _CustomContainerButtonState extends State<CustomContainerButton> {
  late bool selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(16),
          splashColor: Theme.of(context).primaryColor.withAlpha(50),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.color!.withValues(alpha: 0.2),
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text
                CustomText(text: widget.text, fontSize: 0.045, isBold: false),

                // Icon or Switch
                widget.isSwitch
                    ? Switch(
                      value: selected,
                      activeColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFFDA9220)
                              : const Color(0xFF3E0555),

                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey.withOpacity(0.3),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (bool value) {
                        setState(() {
                          selected = value;
                        });
                        if (widget.onSwitchChanged != null) {
                          widget.onSwitchChanged!(value);
                        }
                      },
                    )
                    : CircleAvatar(
                      radius: 18,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFFDA9220)
                              : const Color(0xFF3E0555).withAlpha(120),
                      child: Icon(
                        widget.icon,
                        size:
                            MediaQuery.of(context).size.height *
                            widget.iconSize,
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
