import 'package:flutter/material.dart';
import 'package:carpool/components/text_field_container.dart';
import 'package:carpool/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController password;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        key: const ValueKey("password"),
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        controller: password,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
