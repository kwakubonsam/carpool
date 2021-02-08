import 'package:flutter/material.dart';
import 'package:carpool/components/text_field_container.dart';
import 'package:carpool/constants.dart';

class RoundedPasswordFieldd extends StatefulWidget {
  @override
  final ValueChanged<String> onChanged;
  final TextEditingController password;
  const RoundedPasswordFieldd({
    Key key,
    this.onChanged,
    this.password,
  }) : super(key: key);
  _RoundedPasswordFielddState createState() => _RoundedPasswordFielddState();
}

class _RoundedPasswordFielddState extends State<RoundedPasswordFieldd> {
  bool _isHidden = true;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        key: const ValueKey("password"),
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        controller: widget.password,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffix: InkWell(
            onTap: _togglePasswordView,
            child: Icon(
              _isHidden
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),

          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
      _obscureText = !_obscureText;
    });
  }
}
