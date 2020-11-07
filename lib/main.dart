import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Interest calculator",
    home: InterestCalculator(),
    theme: ThemeData(
        //brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class InterestCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InterestCalcuState();
  }
}

class _InterestCalcuState extends State<InterestCalculator> {
  var _formKey =
      GlobalKey<FormState>(); // this _formKey will act as a key for our Form

  var _currencies = ['taka', 'dollar', 'euro', 'dinar'];
  var _currentItemSelected = 'taka';
  String result = "";

  TextEditingController principalController = TextEditingController();   // this takes input from the textfield and control them
  TextEditingController roController = TextEditingController();
  TextEditingController termsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text("Interest Calculator"),
      ),
      body: Form(
        key: _formKey, // using this key we will get our current form
        child: Padding(
          // margin: EdgeInsets.all(20.0),
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: TextFormField(  // textFormField is used instead of TextField for validation
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  validator: (String value) {  // it validates our input
                    if (value.isEmpty) {
                      return 'Please enter principal amount';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Principal amount',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter rate of interest';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Rate',
                      hintText: 'Rate of interest',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termsController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter Terms';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Term',
                              hintText: 'Term in years',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                      ),
                      Container(
                        width: 10.0,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String stringItem) {
                            return DropdownMenuItem<String>(
                              value: stringItem,
                              child: Text(stringItem),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            setState(() {
                              this._currentItemSelected = newValueSelected;
                            });
                          },
                          value: _currentItemSelected,
                        ),
                      )
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorLight,
                          textColor: Colors.white,
                          child: Text(
                            "Calculate",
                            style: textStyle,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                result = resultCalculate();
                              }
                            });
                          },
                        ),
                      ),
                      Container(   // this container is used for some space between two buttons
                        width: 10.0,
                      ),
                      Expanded( // expand is used for overflow exception in width
                        child: RaisedButton(
                          //color: Colors.black,
                          textColor: Colors.white,
                          child: Text(
                            "Reset",
                            style: textStyle,
                          ),
                          onPressed: () {
                            setState(() {
                              resetAll();
                            });
                          },
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  result,
                  style: textStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/interest.png');
    Image image = Image(
      image: assetImage,
      width: 125,
      height: 125,
    );
    return Container(
      child: image,
    );
  }

  String resultCalculate() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(roController.text);
    double terms = double.parse(termsController.text);

    double finalPrincipal = principal + (principal * rate * terms) / 100;
    String result =
        "After $terms years, your principal will be $finalPrincipal $_currentItemSelected";
    return result;
  }

  void resetAll() {
    principalController.text = "";
    roController.text = "";
    termsController.text = "";
    _currentItemSelected = _currencies[0];
    result = "";
  }
}
