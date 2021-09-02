import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = '6B71A09D-3DC3-43DD-B24E-42F3172145F6';
const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for(String crypto in cryptoList) {
      String requestUrl = '$coinApiUrl/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response =await http.get(Uri.parse(requestUrl));
      if(response.statusCode == 200) {
        double price = jsonDecode(response.body)['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      }else {
        print(response.statusCode);
        throw 'Problem with the get request over http';
      }
    }
    return cryptoPrices;
  }
}