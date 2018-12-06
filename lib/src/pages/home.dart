import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tipPercent = 15, tipPrice = 0.00, totalPrice = 0.00;

  final TextEditingController price = new TextEditingController();

  void pressOnSubmit() {
    setState(() {
      tipPrice = double.parse(price.text) * tipPercent * 0.01;
      totalPrice = tipPrice + double.parse(price.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget inputSection = Container(
      margin: const EdgeInsets.fromLTRB(0, 60, 20, 0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          hintText: "\$ 0.00",
          border: InputBorder.none,
        ),
        textAlign: TextAlign.right,
        controller: price,
        onEditingComplete: pressOnSubmit,
        style: TextStyle(
          fontSize: 70,
          color: Colors.black,
        ),
        textDirection: TextDirection.rtl,
      ),
    );

    Widget tipSection = Container(
      margin: const EdgeInsets.fromLTRB(0, 30, 20, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Tip ($tipPercent%)',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minWidth: 120,
            ),
            child: Text(
              '\$ $tipPrice',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );

    Widget totalSection = Container(
      margin: const EdgeInsets.fromLTRB(0, 00, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Total',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minWidth: 120,
            ),
            child: Text(
              '\$ $totalPrice',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Column(children: [
            inputSection,
            tipSection,
            totalSection,
          ]),
        ));
  }
}
