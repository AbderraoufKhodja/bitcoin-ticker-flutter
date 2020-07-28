import 'package:bitcoin_ticker/services/rates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'coin_data.dart';
import 'price_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getRateData() async {
    var exchangeRate =
        await ExchangeRates(crypto: cryptoList[0]).getCurrentRate();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PriceScreen(
            exchangeRate: exchangeRate,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getRateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
