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
    this.iconSize = 0.03,
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
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        // vertical: MediaQuery.of(context).size.height * 0.005,
      ),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.015,
            horizontal: MediaQuery.of(context).size.width * 0.03,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: widget.text,
                color: Colors.black,
                fontSize: 0.05,
              ),
              widget.isSwitch
                  ? Switch(
                value: selected,
                activeColor: const Color(0xFFDA9220),
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
                  : Icon(
                widget.icon,
                color: const Color(0xFF4B4B4B),
                size: MediaQuery.of(context).size.height * widget.iconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}