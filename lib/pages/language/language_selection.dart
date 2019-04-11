import 'package:flutter/material.dart';

class SelectLanguageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguageScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text('Language'),
      ),
      body: SingleChildScrollView(
        child: IntrinsicWidth(
          child: Column(

          ),
        ),
      ),
    );
  }

}