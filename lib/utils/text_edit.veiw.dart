import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hospital_managements/utils/app_styles.dart';

class TextEditView extends StatefulWidget {
  final TextEditController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final List<TextInputFormatter> inputFormatter;
  final String? initialValue;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final Color? cursorColor;
  final Duration debounceDuration;
  final String? Function(String?)? validator;
  final String? hint, label;
  final List<Widget Function(BuildContext context)>? labelActions;
  final EdgeInsets margin;
  final double? width, height, maxWidth, maxHeight;
  final Color? backgroundColor;
  final IconData? prefixIcon, suffixIcon;
  final Function()? onPrefixPress, onSuffixPress;
  final bool multiLine;
  final DateTime? firstDate, lastDate;

  const TextEditView({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onSaved,
    this.onEditingComplete,
    this.inputFormatter = const [],
    this.initialValue,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.cursorColor,
    this.debounceDuration = const Duration(milliseconds: 400),
    this.validator,
    this.hint,
    this.label,
    this.labelActions,
    this.margin = const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.backgroundColor,
    this.prefixIcon,
    this.suffixIcon,
    this.onPrefixPress,
    this.onSuffixPress,
    this.multiLine = false,
    this.firstDate,
    this.lastDate,
  })  : assert(
          !(controller != null && initialValue != null),
          'controller and initialValue cannot be used at the same time',
        ),
        assert(
            !(keyboardType == TextInputType.datetime &&
                (firstDate == null || lastDate == null)),
            'You have to pass firstDate and lastDate when keyboardType is datetime');

  @override
  State<TextEditView> createState() => _TextEditViewState();
}

class _TextEditViewState extends State<TextEditView> {
  final LayerLink _layerLink = LayerLink();
  late TextEditController _controller;
  // bool _hasOpenedOverlay = false;
  // OverlayEntry? _overlayEntry;
  // Iterable<String> _suggestions = [];
  // Timer? _debounce;
  // String? _previousAsyncText;
  late FocusNode _focusNode;
  late TextInputType _keyboardType;
  bool _hideText = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _keyboardType = widget.keyboardType;
    _hideText = _keyboardType == TextInputType.visiblePassword;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      //   if (_focusNode.hasFocus) {
      //     openOverlay();
      //   } else {
      //     Future.delayed(const Duration(milliseconds: 150))
      //         .then((_) => closeOverlay());
      //   }
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _controller =
        widget.controller ?? TextEditController(text: widget.initialValue);

    _controller.addListener(() {
      //   updateSuggestions(_controller.text);
      _currentState?.didChange(_controller.text);
    });
  }

  // void pickDate() async {
  //   DateTime initialDateTIme =
  //       MDateTime.fromString(_controller.text) ?? DateTime.now();
  //   DateTime? date = await Get.dialog(DatePickerDialog(
  //     initialDate: initialDateTIme,
  //     firstDate: widget.firstDate!,
  //     lastDate: widget.lastDate!,
  //   ));
  //   TimeOfDay? time = await Get.dialog(TimePickerDialog(
  //     initialTime: TimeOfDay.fromDateTime(initialDateTIme),
  //   ));
  //   MDateTime dateTime = MDateTime.fromDateAndTImeOfDay(
  //     date ?? initialDateTIme,
  //     time ?? TimeOfDay.fromDateTime(initialDateTIme),
  //     format: 'yyyy-MM-dd HH:mm:ss',
  //   );
  //   _controller.text = '$dateTime';
  // }

  // void pickAddress() async {
  //   print(await Get.to(const MapLocationPicker(
  //     apiKey: 'AIzaSyCHYTCYmSyk9Y4tuyRL6sR7e07xFHw0Mew',
  //     onNext: print,
  //   )));
  // }

  // void openOverlay() {
  //   if (_overlayEntry == null) {
  //     RenderBox renderBox = context.findRenderObject() as RenderBox;
  //     var size = renderBox.size;
  //     var offset = renderBox.localToGlobal(Offset.zero);

  //     _overlayEntry ??= OverlayEntry(
  //       builder: (context) => Positioned(
  //         left: offset.dx,
  //         top: offset.dy
  //         // +
  //         //     size.height -
  //         //     (widget.margin.top + widget.margin.bottom) +
  //         //     2
  //         ,
  //         width: size.width - (widget.margin.left + widget.margin.right),
  //         child: CompositedTransformFollower(
  //           link: _layerLink,
  //           showWhenUnlinked: false,
  //           offset: Offset(
  //             0.0,
  //             size.height -
  //                 (widget.margin.top +
  //                     widget.margin.bottom +
  //                     (widget.label != null ? 30 : 0)) +
  //                 2,
  //           ),
  //           child: FilterableList(
  //             items: _suggestions,
  //             onItemTapped: (value) {
  //               _controller.value = TextEditingValue(
  //                 text: value,
  //                 selection: TextSelection.collapsed(offset: value.length),
  //               );
  //               widget.onChanged?.call(value);
  //               widget.onSubmitted?.call(value);
  //               closeOverlay();
  //               _focusNode.unfocus();
  //             },
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   if (!_hasOpenedOverlay) {
  //     Overlay.of(context).insert(_overlayEntry!);
  //     setState(() => _hasOpenedOverlay = true);
  //   }
  // }

  // void closeOverlay() {
  //   if (_hasOpenedOverlay) {
  //     _overlayEntry!.remove();
  //     setState(() {
  //       _hasOpenedOverlay = false;
  //     });
  //   }
  // }

  // Future<void> updateSuggestions(String text) async {
  //   reBuildOverlay();
  //   if (_controller.canGetSuggestions) {
  //     if (_previousAsyncText == text) return;
  //     if (_debounce != null && _debounce!.isActive) _debounce!.cancel();

  //     setState(() {
  //       _previousAsyncText = text;
  //     });

  //     _debounce = Timer(
  //       widget.debounceDuration,
  //       () async {
  //         _suggestions = await _controller.getSuggestions(text);
  //         reBuildOverlay();
  //       },
  //     );
  //   }
  // }

  // void reBuildOverlay() {
  //   if (_overlayEntry != null) _overlayEntry!.markNeedsBuild();
  // }

  FormFieldState<String>? _currentState;

  TextButton _buildIconButton(
    BuildContext context, {
    required IconData icon,
    Color? color,
    Function()? onPressed,
  }) =>
      TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Icon(
          icon,
          color: color,
          size: 25,
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (widget.multiLine) _keyboardType = TextInputType.multiline;
    return FormField<String>(
      validator: widget.validator,
      initialValue: _controller.text,
      onSaved: (newValue) {
        widget.onSaved?.call(newValue);
        _controller.saveSuggestions();
      },
      builder: (state) {
        _currentState = state;
        return Container(
          margin: widget.margin,
          width: widget.width,
          height: widget.height,
          constraints: BoxConstraints(
            maxWidth: widget.maxWidth ?? double.infinity,
            maxHeight: widget.maxHeight ?? double.infinity,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.label != null) ...[
                if (widget.labelActions != null)
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        widget.label!,
                        style: TextStyle(
                          color:  Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      for (final action in widget.labelActions!)
                        action(context),
                    ],
                  )
                else
                  Text(
                    widget.label!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const Gap(5),
              ],
              CompositedTransformTarget(
                link: _layerLink,
                child: TextField(
                  onEditingComplete: widget.onEditingComplete,
                  focusNode: _focusNode,
                  obscureText: _hideText,
                  controller: _controller,
                  keyboardType: _keyboardType,
                  maxLines: widget.multiLine ? null : 1,
                  autofocus: widget.autofocus,
                  inputFormatters: widget.inputFormatter,
                  textCapitalization: widget.textCapitalization,
                  cursorColor: widget.cursorColor,
                  onChanged: widget.onChanged,
                  style: TextStyle(color: const Color.fromARGB(255, 35, 35, 35)),
                  // onEditingComplete: closeOverlay,
                  onSubmitted: (value) {
                    widget.onSubmitted?.call(value);
                    // closeOverlay();
                    _focusNode.unfocus();
                  },
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    fillColor: widget.backgroundColor ?? Colors.white,
                    filled: true,
                    prefixIcon: widget.prefixIcon != null
                        ? (widget.onPrefixPress != null
                            ? _buildIconButton(
                                context,
                                onPressed: widget.onPrefixPress,
                                icon: widget.prefixIcon!,
                                color: _isFocused
                                    ? const Color.fromARGB(255, 51, 51, 51)
                                    : Colors.grey,
                              )
                            : Icon(
                                widget.prefixIcon,
                                color: _isFocused
                                    ? const Color.fromARGB(255, 51, 51, 51)
                                    : Colors.grey,
                              ))
                        : null,
                    suffixIcon: widget.suffixIcon != null
                        ? (widget.onSuffixPress != null
                            ? _buildIconButton(
                                context,
                                onPressed: widget.onSuffixPress,
                                icon: widget.suffixIcon!,
                                color: _isFocused
                                    ? AppTheme.blue
                                    : Colors.grey,
                              )
                            : Icon(
                                widget.suffixIcon,
                                color:_isFocused
                                    ? AppTheme.blue
                                    : Colors.grey,
                              ))
                        : _keyboardType == TextInputType.visiblePassword
                            ? _buildIconButton(
                                context,
                                icon: _hideText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onPressed: () => setState(() {
                                  _hideText = !_hideText;
                                }),
                                color:_isFocused
                                    ? AppTheme.blue
                                    : Colors.grey,
                              )
                            // :
                            //  _keyboardType == TextInputType.datetime
                            //     ? _buildIconButton(
                            //         context,
                            //         onPressed: pickDate,
                            //         icon: Icons.calendar_month_outlined,
                            //         color: _isFocused
                            //         ? const Color.fromARGB(255, 51, 51, 51)
                            //         : Colors.grey,
                            //       )

                                // : _keyboardType == TextInputType.streetAddress
                                //     ? TextButton(
                                //         style: ButtonStyle(
                                //           shape:
                                //               MaterialStateProperty.resolveWith(
                                //             (states) => RoundedRectangleBorder(
                                //               borderRadius:
                                //                   BorderRadius.circular(50),
                                //             ),
                                //           ),
                                //         ),
                                //         onPressed: pickAddress,
                                //         child: Icon(
                                //           Icons.location_on_outlined,
                                //           color: Colors.fieldFocus,
                                //           size: 25,
                                //         ),
                                //       )
                                : null,
                    contentPadding: widget.prefixIcon == null
                        ? const EdgeInsets.only(top: 15, left: 15)
                        : const EdgeInsets.only(top: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.8,
                        color: state.hasError
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.8,
                        color: state.hasError
                            ? Colors.red
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.8,
                        color: state.hasError
                            ? Colors.red
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey, width: 0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              if (state.hasError) ...[
                const Gap(4),
                Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 15,
                          ),
                        ),
                      ),
                      TextSpan(text: state.errorText!),
                    ],
                  ),
                  style: TextStyle(color: Colors.red),
                )
              ]
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    try {
      // if (_overlayEntry != null) _overlayEntry!.dispose();

      // if (_debounce != null) _debounce?.cancel();
      if (widget.focusNode == null) {
        // _focusNode.removeListener(() {
        //   if (_focusNode.hasFocus) {
        //     openOverlay();
        //   } else {
        //     closeOverlay();
        //   }
        // });
        _focusNode.dispose();
      }
      // _controller.removeListener(() => updateSuggestions(_controller.text));
      _controller.dispose();
    } catch (e) {
      print(e);
    }
    super.dispose();
  }
}

class FilterableList extends StatelessWidget {
  final Iterable<String> items;
  final Function(String) onItemTapped;
  final double elevation;
  final double maxListHeight;

  const FilterableList({
    super.key,
    required this.items,
    required this.onItemTapped,
    this.elevation = 5,
    this.maxListHeight = 150,
  });

  @override
  Widget build(BuildContext context) => Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey,
        child: Container(
          constraints: BoxConstraints(maxHeight: maxListHeight),
          child: Visibility(
            visible: items.isNotEmpty,
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              itemCount: items.length,
              itemBuilder: (context, index) => Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      items.elementAt(index),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  onTap: () => onItemTapped(items.elementAt(index)),
                ),
              ),
            ),
          ),
        ),
      );
}

class TextEditController extends TextEditingController {
  final Future<List<String>> Function()? moreSuggestions;
  // final List<String> _names = [];

  // final List<ViewSessions<List>> _sessions = [];
  final List<String> _suggestions = [];

  TextEditController({
    super.text,
    // String? name,
    this.moreSuggestions,
  })
  /*: assert(
          name != null && RegExp(r'^[a-zA-Z0-9_,\s-]*$').hasMatch(name),
          'Invalid controller name',
        ),
        assert(
          name != null &&
              (name.endsWith(',') ||
                  name.endsWith(',') && !RegExp(r'[_,\s-]$').hasMatch(name)),
          'Invalid controller name, trailing comma not allowed',
        )*/
  {
    // if (name != null) {
    //   name = name.trim();
    //   if (!RegExp(r'^[a-zA-Z0-9_,\s-]*$').hasMatch(name)) {
    //     throw Exception('Invalid controller name');
    //   } else if (name.endsWith(',')) {
    //     throw Exception('Invalid controller name, trailing comma not allowed');
    //   }
    //   for (String name in name.split(', ')) {
    //     if (_names.contains(name)) {
    //       throw Exception("Name \"$name\" is deduplicated");
    //     }
    //     _names.add(name);
    //   }
    //   initSessions();
    // }
  }

  // Future initSessions() async {
  //   for (String name in _names) {
  //     try {
  //       final sessions = await ViewSessions.instance('ui-text_edit-$name', []);
  //       _suggestions.addAll(List<String>.from(sessions.data));
  //       _sessions.add(sessions);
  //     } catch (e) {}
  //   }
  // }

  Future<Iterable<String>> getSuggestions(String text) async {
    final suggestions = _suggestions;

    for (String suggestion in (await moreSuggestions?.call()) ?? []) {
      if (!suggestions.contains(suggestion)) {
        suggestions.add(suggestion);
      }
    }

    return text.isEmpty
        ? suggestions
        : suggestions.where((element) =>
            element.toLowerCase().trim().contains(text.toLowerCase().trim()));
  }

  // bool get canGetSuggestions => _sessions.isNotEmpty;
  bool get canGetSuggestions => false;

  Future saveSuggestions() async {
    // if (text.isNotEmpty) {
    //   for (ViewSessions<List> sessions in _sessions) {
    //     if (!sessions.data.contains(text)) sessions.data.add(text);
    //     await sessions.saveData();
    //   }
    // }
  }
}