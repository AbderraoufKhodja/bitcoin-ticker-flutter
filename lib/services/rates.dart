import 'package:bitcoin_ticker/services/networking.dart';

const apiKey = '13D11655-6867-4D60-B43C-C53BF363CE17';

class ExchangeRates {
  String crypto;

  ExchangeRates({this.crypto});

  Future<dynamic> getCurrentRate() async {
    String url = getURL();
    NetworkingHelper networkingHelper = NetworkingHelper(
      url: url,
    );
    var rateData = await networkingHelper.getData();
    return rateData;
  }

  String getURL() {
    return 'https://rest.coinapi.io/v1/exchangerate/'
        '$crypto/?apikey=$apiKey';
  }

  void setCurrency(String currency) => this.crypto = currency;
}
