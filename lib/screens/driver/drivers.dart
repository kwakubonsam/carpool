import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:carpool/constants.dart';
import 'package:carpool/services/database.dart';

class Driver extends StatefulWidget {
  @override
  final FirebaseAuth auth;
  final ValueChanged<String> onChanged;
  const Driver({
    Key key,
    this.auth,
    this.onChanged,
  }) : super(key: key);
  _DriverState createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  final _formKey = GlobalKey<FormBuilderState>();
  String _name;
  String _number;
  String _price;
  String _destination;
  String _payment;
  int _date;

  @override
  Widget build(BuildContext context) {
    CollectionReference rides = FirebaseFirestore.instance.collection('ridz');
    return Scaffold(
        appBar: AppBar(
          title: Text("Trip Info"),
          backgroundColor: kPrimaryColor,
        ),
        body: Container(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      name: 'name',
                      decoration: InputDecoration(
                        labelText: '  Enter your name',
                      ),
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                      onSaved: (String value) {
                        _name = value.trim();
                      },
                    ),
                    FormBuilderTextField(
                      name: 'destination',
                      decoration:
                          InputDecoration(labelText: '  Enter your destination'),
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                      onSaved: (String value) {
                        _destination = value.trim();
                      },
                    ),
                    FormBuilderTextField(
                      name: 'number',
                      decoration:
                          InputDecoration(labelText: '  Enter your phone number'),
                      valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                        validateMobile,
                      ]),
                      onSaved: (String value) {
                        _number = value;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    FormBuilderChoiceChip(
                      name: 'payment',
                      decoration: InputDecoration(
                        labelText: '  Payment Method',
                        hoverColor: Color(0xFF6F35A5),
                      ),
                      options: [
                        FormBuilderFieldOption(
                            value: 'paypal', child: Text('PayPal')),
                        FormBuilderFieldOption(
                            value: 'cash', child: Text('cash')),
                        FormBuilderFieldOption(
                            value: 'cashapp', child: Text('cashApp')),
                        FormBuilderFieldOption(
                            value: 'vemno', child: Text('venmo')),
                      ],
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                      onSaved: (String value) {
                        _payment = value;
                      },
                    ),
                    FormBuilderTextField(
                      name: 'price',
                      decoration: InputDecoration(labelText: '  Price'),
                      valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                        FormBuilderValidators.max(context, 500),
                      ]),
                      onSaved: (String value) {
                        _price = value;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    FormBuilderDateTimePicker(
                      name: 'date',
                      // onChanged: _onChanged,
                      inputType: InputType.both,
                      decoration: InputDecoration(
                        labelText: '  Trip date and time',
                      ),
                      firstDate: DateTime.now(),
                      enabled: true,
                      validator:  FormBuilderValidators.required(context),
                      onSaved: (DateTime value) {
                        _date = value.millisecondsSinceEpoch.toInt();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color: Color(0xFF6F35A5),
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _formKey.currentState.validate();
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Database(rides: rides).addTodo(
                            time: _date,
                            name: _name,
                            destination: _destination,
                            number: _number,
                            payment: _payment,
                            price: _price,
                          );
                          _formKey.currentState.reset();
                        } else {
                          print("validation failed");
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: MaterialButton(
                      color: Color(0xFF6F35A5),
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
        )));
  }
}

String validateMobile(String value) {
  if (value.length != 10)
    return 'Enter a valid phone number';
  else
    return null;
}
