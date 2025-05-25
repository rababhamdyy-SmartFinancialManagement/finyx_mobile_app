import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_text.dart';

class CustomContainerButton extends StatefulWidget {
  final String text;
  final bool isSwitch;
  final bool isLanguageSwitch; // جديد
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
    this.isLanguageSwitch = false, // جديد
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
                  ).textTheme.bodyMedium!.color!.withAlpha(50),
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
                    ? widget.isLanguageSwitch
                        ? Container(
                          width: 70,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: Stack(
                            children: [
                              AnimatedAlign(
                                alignment:
                                    selected
                                        ? (Directionality.of(context) ==
                                                TextDirection.rtl
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight)
                                        : (Directionality.of(context) ==
                                                TextDirection.rtl
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft),

                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,

                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? const Color(0xFFDA9220)
                                            : const Color(0xFF3E0555),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    selected ? 'EN' : 'AR',
                                    style: const TextStyle(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),

                              Row(
                                children: const [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'AR',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'EN',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    setState(() {
                                      selected = !selected;
                                    });
                                    if (widget.onSwitchChanged != null) {
                                      widget.onSwitchChanged!(selected);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                        : Switch(
                          value: selected,
                          activeColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? const Color(0xFFDA9220)
                                  : const Color(0xFF3E0555),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey.withOpacity(0.3),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
