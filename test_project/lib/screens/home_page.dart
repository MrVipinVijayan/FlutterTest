import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_project/widgets/error_txt.dart';
import 'package:test_project/widgets/title_txt.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  final _formKey = GlobalKey<FormState>();
  StreamController<String> _nameStreamController;
  TextEditingController _nameController;
  static const String MSG = 'Please enter something.';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nameStreamController = StreamController<String>.broadcast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Test'),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          color: Theme.of(context).backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TitleTxt(text: 'Form Validation using Streams'),
                StreamBuilder(
                  stream: _nameStreamController.stream,
                  builder: (context, snapshot) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Enter Something',
                          ),
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          child: Text('Validate using stream'),
                          onPressed: () {
                            if (_nameController.text.trim().isEmpty) {
                              _nameStreamController.sink.add('');
                              return;
                            }
                            // Nvaigate to next screen
                          },
                        ),
                        Visibility(
                          visible: null != snapshot && null != snapshot.data,
                          child: ErrorTxt(text: MSG),
                        ),
                        TitleTxt(text: 'Form Validation'),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Something',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return MSG;
                                  }
                                  return null;
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            // Navigate to next screen
                          },
                          child: Text('Validate'),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameStreamController.close();
  }
}
