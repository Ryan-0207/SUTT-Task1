import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    title: 'Tip Calculator',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('Next'),
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => SecondPage(
                      amount: amountController.text,
                    )),
          );
        },
      ),
      appBar: AppBar(
        title: Text('Tip Calculator'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Center(
        child: TextField(
          controller: amountController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Amount:',
            hintText: 'Enter the amount',
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final String amount;
  SecondPage({Key key, @required this.amount}) : super(key: key);

  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController tipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Second Page"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(' Back '),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Text('amount:${widget.amount}'),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: tipController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tip%',
                  hintText: 'Enter Tip%',
                ),
              ),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text('Next'),
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Final Amount"),
                      // Retrieve the text which the user has entered by
                      // using the TextEditingController.
                      content: Text(
                          'Amount:${double.parse(widget.amount)}  Tip:${0.01 * double.parse(tipController.text) * double.parse(widget.amount)} Total:${double.parse(widget.amount) + 0.01 * double.parse(tipController.text) * double.parse(widget.amount)}'),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
