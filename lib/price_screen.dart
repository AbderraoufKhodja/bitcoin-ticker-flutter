import 'package:bitcoin_ticker/services/rates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  final exchangeRate;

  PriceScreen({this.exchangeRate});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var exchangeList;
  String chosenCrypto = cryptoList[0];
  @override
  void initState() {
    super.initState();
    updateUI(widget.exchangeRate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: Center(child: buildCupertinoPicker())),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: buildAndroidDropdownButton(),
          ),
        ],
      ),
    );
  }

  DropdownButton<String> buildAndroidDropdownButton() {
    return DropdownButton<String>(
      value: chosenCrypto,
      onChanged: (cryptoName) async {
        exchangeRate.setCurrency(cryptoName);
        var rateData = await exchangeRate.getCurrentRate();
        updateUI(rateData);
        setState(() {});
      },
      items: makeDropdownItems(),
    );
  }

  CupertinoPicker buildCupertinoPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      children: makePickerItems(),
    );
  }

  void updateUI(dynamic data) {
    exchangeList = data['rates'];
  }

  ExchangeRates exchangeRate = ExchangeRates();

  List<DropdownMenuItem> makeDropdownItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String crypto in cryptoList) {
      items.add(
        DropdownMenuItem(
          child: Text(crypto),
          value: crypto,
        ),
      );
    }
    return items;
  }

  List<dynamic> makePickerItems() {
    List<Row> items = [];
    for (dynamic exchangeData in exchangeList) {
      double rate = exchangeData['rate'].toDouble();
      items.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 60.0,
            ),
            Container(
              width: 70.0,
              child: Text(
                '${exchangeData['asset_id_quote']}',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Container(
              child: Text(
                '| ${rate.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
    }
    return items;
  }
}

class PaddedRateCard extends StatelessWidget {
  const PaddedRateCard({
    Key key,
    @required this.btcRate,
    @required this.chosenCurrency,
  }) : super(key: key);

  final String btcRate;
  final String chosenCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 BTC = $btcRate $chosenCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
