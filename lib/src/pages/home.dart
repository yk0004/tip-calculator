import 'package:flutter/material.dart';

class TipCalculator extends StatefulWidget {
  TipCalculator({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  var inputPrice = 0.0, rate = 15.0, tipPrice = 0.0, totalPrice = 0.0;
  final TextEditingController price = new TextEditingController();

  void _showDialog(String notice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alarm"),
          content: new Text(notice),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _calcTotalPriceAndTip() {
    tipPrice = inputPrice * rate / 100;
    totalPrice = tipPrice + inputPrice;
  }

  double _validateInputPrice(String text) {
    double value = double.parse(text);
    if (value < 0) {
      throw ("input price must be >= 0");
    }
    return value;
  }

  void _onSumit() {
    if (price.text == "") {
      _showDialog("Enter price!");
      return;
    }
    setState(() {
      try {
        inputPrice = _validateInputPrice(price.text);
        _calcTotalPriceAndTip();
        price.text = "\$${inputPrice.toStringAsFixed(2)}";
      } catch (exception) {
        if (exception == "input price must be >= 0") {
          _showDialog(exception);
        } else {
          _showDialog("Please enter valid number");
        }
        price.text = "";
        inputPrice = 0.0;
      }
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

  void _onTap() {
    if (price.text != "") {
      try {
        inputPrice = _validateInputPrice(price.text);
      } catch (exception) {
        price.text = "${inputPrice.round()}";
      }
    }
  }

  void _onSliderChanged(var position) {
    if (price.text == "") {
      _showDialog("Enter price!");
      return;
    }
    setState(() {
      rate = position;
      _calcTotalPriceAndTip();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget inputSection = Container(
      margin: const EdgeInsets.only(top: 40, right: 20),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          hintText: "\$ 0.00",
          border: InputBorder.none,
        ),
        textAlign: TextAlign.right,
        controller: price,
        onEditingComplete: _onSumit,
        onTap: _onTap,
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
            'Tip (${rate.round()}%)',
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
              '\$ ${tipPrice.toStringAsFixed(2)}',
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
      margin: const EdgeInsets.only(right: 20),
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
              '\$ ${totalPrice.toStringAsFixed(2)}',
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

    Widget sliderSection = Container(
      margin: const EdgeInsets.only(top: 30),
      child: Slider(
        value: rate,
        min: 0,
        max: 100,
        divisions: 100,
        onChanged: _onSliderChanged,
        inactiveColor: Colors.black12,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: [
          inputSection,
          tipSection,
          totalSection,
          sliderSection,
        ]),
      ),
    );
  }
}
