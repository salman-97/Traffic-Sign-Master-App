// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';

class CustomTextField extends StatefulWidget {
  final String? initialValue;
  final TextEditingController controller;
  final label;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextStyle? textStyle;
  final TextStyle? errorTextStyle;

  const CustomTextField({
    this.initialValue,
    required this.controller,
    this.label,
    this.prefixIcon,
    required this.validator,
    required this.keyboardType,
    this.textStyle,
    this.errorTextStyle,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  Color? _labelColor;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _labelColor = Colors.black54;
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus && widget.controller.text.isEmpty == true) {
      setState(() {
        _labelColor = Colors.black54;
      });
    } else {
      _labelColor = AppColors.buttonColor;
    }
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      controller: widget.controller,
      focusNode: _focusNode,
      onTap: _requestFocus,
      decoration: InputDecoration(
        label: Text(widget.label),
        labelStyle: TextStyle(
            color: _focusNode.hasFocus ? AppColors.buttonColor : _labelColor),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(
          widget.prefixIcon,
          size: 22,
          color: _focusNode.hasFocus ? AppColors.buttonColor : _labelColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.buttonColor),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE4DFDF)),
          borderRadius: BorderRadius.circular(12),
        ),
        errorStyle: widget.errorTextStyle,
      ),
      validator: widget.validator,
      style: widget.textStyle,
      keyboardType: widget.keyboardType,
    );
  }
}
