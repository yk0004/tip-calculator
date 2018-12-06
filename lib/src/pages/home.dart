import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var inputPrice = 0.0, tipPercent = 15.0, tipPrice = 0.0, totalPrice = 0.0;

  final TextEditingController price = new TextEditingController();

  void pressOnSubmit() {
    setState(() {
      inputPrice = double.parse(price.text);
      tipPrice = inputPrice * tipPercent * 0.01;
      totalPrice = inputPrice + tipPrice;
      price.text = "\$${inputPrice.toStringAsFixed(2)}";
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

 void handleSlider(var position) {
    setState(() {
      tipPercent = position;
      if(price.text != "") {
        tipPrice = inputPrice * position * 0.01;
        totalPrice = inputPrice + tipPrice;
      }
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
            'Tip (${tipPercent.round()}%)',
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
          value: tipPercent,
          min: 0,
          max: 100,
          divisions: 100,
          onChanged: handleSlider,
          inactiveColor: Colors.black12,
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
            sliderSection,
          ]),
        ));
  }
}
