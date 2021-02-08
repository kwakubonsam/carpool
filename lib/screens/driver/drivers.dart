import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:carpool/constants.dart';

class Driver extends StatefulWidget {
  @override
  final ValueChanged<String> onChanged;
  const Driver({
    Key key,
    this.onChanged,
  }) : super(key: key);
  _DriverState createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drivers"),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: <Widget>[
          FormBuilder(
            key: _formKey,
            child: Column(
              children: <Widget>[
                FormBuilderFilterChip(
                  name: 'filter_chip',
                  decoration: InputDecoration(
                    labelText: 'Select many options',
                  ),
                  options: [
                    FormBuilderFieldOption(value: 'Test', child: Text('Test')),
                    FormBuilderFieldOption(
                        value: 'Test 1', child: Text('Test 1')),
                    FormBuilderFieldOption(
                        value: 'Test 2', child: Text('Test 2')),
                    FormBuilderFieldOption(
                        value: 'Test 3', child: Text('Test 3')),
                    FormBuilderFieldOption(
                        value: 'Test 4', child: Text('Test 4')),
                  ],
                ),
                FormBuilderChoiceChip(
                  name: 'choice_chip',
                  decoration: InputDecoration(
                    labelText: 'Select an option',
                  ),
                  options: [
                    FormBuilderFieldOption(value: 'Test', child: Text('Test')),
                    FormBuilderFieldOption(
                        value: 'Test 1', child: Text('Test 1')),
                    FormBuilderFieldOption(
                        value: 'Test 2', child: Text('Test 2')),
                    FormBuilderFieldOption(
                        value: 'Test 3', child: Text('Test 3')),
                    FormBuilderFieldOption(
                        value: 'Test 4', child: Text('Test 4')),
                  ],
                ),
                FormBuilderColorPickerField(
                  name: 'color_picker',
                  // initialValue: Colors.yellow,
                  colorPickerType: ColorPickerType.MaterialPicker,
                  decoration: InputDecoration(labelText: 'Pick Color'),
                ),
                FormBuilderDateTimePicker(
                  name: 'date',
                  // onChanged: _onChanged,
                  inputType: InputType.time,
                  decoration: InputDecoration(
                    labelText: 'Appointment Time',
                  ),
                  initialTime: TimeOfDay(hour: 8, minute: 0),
                  // initialValue: DateTime.now(),
                  // enabled: true,
                ),
                FormBuilderTextField(
                  name: 'age',
                  decoration: InputDecoration(
                    labelText:
                        'This value is passed along to the [Text.maxLines] attribute of the [Text] widget used to display the hint text.',
                  ),
                  // valueTransformer: (text) => num.tryParse(text),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.numeric(context),
                    FormBuilderValidators.max(context, 70),
                  ]),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  color: Theme.of(context).accentColor,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _formKey.currentState.save();
                    if (_formKey.currentState.validate()) {
                      print(_formKey.currentState.value);
                    } else {
                      print("validation failed");
                    }
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: MaterialButton(
                  color: Theme.of(context).accentColor,
                  child: Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _formKey.currentState.reset();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
