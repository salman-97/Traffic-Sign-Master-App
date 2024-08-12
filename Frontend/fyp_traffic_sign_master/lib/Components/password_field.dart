// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';

class CustomPasswordField extends StatefulWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final label;
  final String? Function(String?)? validator;
  final Function(bool)? onSuffixIconPressed;
  final TextStyle? errorTextStyle;

  const CustomPasswordField({
    super.key,
    this.initialValue,
    this.controller,
    this.label,
    this.validator,
    this.onSuffixIconPressed,
    this.errorTextStyle,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool obscurePassword = true;
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
    if (!_focusNode.hasFocus && widget.controller?.text.isEmpty == true) {
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
          color: _focusNode.hasFocus ? AppColors.buttonColor : _labelColor,
        ),
        prefixIcon: Icon(
          Icons.lock_outline,
          size: 22,
          color: _focusNode.hasFocus ? AppColors.buttonColor : _labelColor,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
          child: Icon(
            obscurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
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
      obscureText: obscurePassword,
      validator: widget.validator,
      keyboardType: TextInputType.text,
    );
  }
}
