import 'package:flutter/material.dart';

import 'hexcolor.dart';

class BilSplitter extends StatefulWidget {
  const BilSplitter({Key? key}) : super(key: key);

  @override
  _BiilSplitterState createState() => _BiilSplitterState();
}

class _BiilSplitterState extends State<BilSplitter> {
  @override
  int tipPercentage = 0;
  int personCounter = 1;
  double billAmount = 0.0;
  Color purple = HexColor("#6908D6");
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: purple.withOpacity(0.1),
                //  Colors.purpleAccent.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Per Person',
                    style: TextStyle(fontSize: 17.0, color: purple),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '\$ ${calculateTotalPerPerson(billAmount, personCounter, tipPercentage)}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34.0,
                          color: purple),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade100,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  TextField(
                    cursorColor: purple,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: purple),
                    decoration: InputDecoration(
                        prefixText: 'Bill Amount',
                        prefixIcon: Icon(
                          Icons.attach_money,
                          color: purple,
                        ),
                        hoverColor: purple,
                        focusColor: purple,
                        fillColor: purple),
                    onChanged: (String value) {
                      try {
                        billAmount = double.parse(value);
                      } catch (exception) {
                        billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Split',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (personCounter > 1) {
                                  personCounter--;
                                } else {}
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: purple.withOpacity(0.1)),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                    color: purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$personCounter",
                            style: TextStyle(
                              color: purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                personCounter++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: purple.withOpacity(0.1)),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                    color: purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tip',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          '\$ ${(calculateTotalTip(billAmount, personCounter, tipPercentage)).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: purple,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '$tipPercentage',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          divisions: 10,
                          activeColor: purple,
                          inactiveColor: Colors.grey,
                          value: tipPercentage.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              tipPercentage = newValue.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) /
            splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}
