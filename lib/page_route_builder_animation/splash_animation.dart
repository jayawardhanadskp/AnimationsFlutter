import 'dart:async';

import 'package:flutter/material.dart';

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({super.key});

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    scaleAnimation = Tween<double>(begin: 1, end: 10).animate(controller);

    controller.addListener(() {
      if (controller.isCompleted) {
        Navigator.of(context)
            .push(MyCustomRouteTransition(route: const Destination()));

        // reset zoom after animation
        Timer(const Duration(milliseconds: 500), () {
          controller.reset();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            controller.forward();
            // Navigator.push(context,MaterialPageRoute(builder: (context) => const Destination()));
          },
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Destination extends StatelessWidget {
  const Destination({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Go Back'),
      ),
    );
  }
}

class MyCustomRouteTransition extends PageRouteBuilder {
  final Widget route;
  MyCustomRouteTransition({required this.route})
      : super(pageBuilder: (context, animation, secondaryAnimation) {
          return route;
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut),
          );
          return SlideTransition(
            position: tween,
            child: child,
          );
        });
}

/* 
//
//  DetailView.swift
//  SwiftuiCripto
//
//  Created by I O N Groups Pvt Ltd on 2024-10-25.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?

    var body: some View {
        ZStack {
            if let coin = coin {
                Text(coin.name)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail view for \(coin.name)")
    }
    var body: some View {
        Text("coin.name")
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}

*/

/*
//
//  DetailViewModel.swift
//  SwiftuiCripto
//
//  Created by I O N Groups Pvt Ltd on 2024-10-25.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
     
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink{ (returnedCoinDetails) in
                print("recived coin detail data")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
}

*/

/*
//
//  CoinDetailDataService.swift
//  SwiftuiCripto
//
//  Created by I O N Groups Pvt Ltd on 2024-10-25.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailModel? = nil
    
    var coinDetailSubacription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        
        guard let url = URL(string:"https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false%24market_data%3Dfalse%24community_data%3Dfalse&developer_data=false&sparkline=false") else {return}
        
        coinDetailSubacription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubacription?.cancel()
            })
            
        
    }
}

 */

/*
//
//  CoinDetailModel.swift
//  SwiftuiCripto
//
//  Created by I O N Groups Pvt Ltd on 2024-10-25.
//

import Foundation

/*
URL: https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false$market_data=false$community_data=false&developer_data=false&sparkline=false
 
 RESPONSE: {
 "id": "bitcoin",
 "symbol": "btc",
 "name": "Bitcoin",
 "web_slug": "bitcoin",
 "asset_platform_id": null,
 "platforms": {
     "": ""
 },
 "detail_platforms": {
     "": {
         "decimal_place": null,
         "contract_address": ""
     }
 },
 "block_time_in_minutes": 10,
 "hashing_algorithm": "SHA-256",
 "categories": [
     "Cryptocurrency",
     "Layer 1 (L1)",
     "FTX Holdings",
     "Proof of Work (PoW)",
     "Bitcoin Ecosystem",
     "GMCI 30 Index"
 ],
 "preview_listing": false,
 "public_notice": null,
 "additional_notices": [],
 "description": {
     "en": "Bitcoin is the first successful internet money based on peer-to-peer technology; whereby no central bank or authority is involved in the transaction and production of the Bitcoin currency. It was created by an anonymous individual/group under the name, Satoshi Nakamoto. The source code is available publicly as an open source project, anybody can look at it and be part of the developmental process.\r\n\r\nBitcoin is changing the way we see money as we speak. The idea was to produce a means of exchange, independent of any central authority, that could be transferred electronically in a secure, verifiable and immutable way. It is a decentralized peer-to-peer internet currency making mobile payment easy, very low transaction fees, protects your identity, and it works anywhere all the time with no central authority and banks.\r\n\r\nBitcoin is designed to have only 21 million BTC ever created, thus making it a deflationary currency. Bitcoin uses the <a href=\"https://www.coingecko.com/en?hashing_algorithm=SHA-256\">SHA-256</a> hashing algorithm with an average transaction confirmation time of 10 minutes. Miners today are mining Bitcoin using ASIC chip dedicated to only mining Bitcoin, and the hash rate has shot up to peta hashes.\r\n\r\nBeing the first successful online cryptography currency, Bitcoin has inspired other alternative currencies such as <a href=\"https://www.coingecko.com/en/coins/litecoin\">Litecoin</a>, <a href=\"https://www.coingecko.com/en/coins/peercoin\">Peercoin</a>, <a href=\"https://www.coingecko.com/en/coins/primecoin\">Primecoin</a>, and so on.\r\n\r\nThe cryptocurrency then took off with the innovation of the turing-complete smart contract by <a href=\"https://www.coingecko.com/en/coins/ethereum\">Ethereum</a> which led to the development of other amazing projects such as <a href=\"https://www.coingecko.com/en/coins/eos\">EOS</a>, <a href=\"https://www.coingecko.com/en/coins/tron\">Tron</a>, and even crypto-collectibles such as <a href=\"https://www.coingecko.com/buzz/ethereum-still-king-dapps-cryptokitties-need-1-billion-on-eos\">CryptoKitties</a>."
 },
 "links": {
     "homepage": [
         "http://www.bitcoin.org",
         "",
         ""
     ],
     "whitepaper": "https://bitcoin.org/bitcoin.pdf",
     "blockchain_site": [
         "https://mempool.space/",
         "https://platform.arkhamintelligence.com/explorer/token/bitcoin",
         "https://blockchair.com/bitcoin/",
         "https://btc.com/",
         "https://btc.tokenview.io/",
         "https://www.oklink.com/btc",
         "https://3xpl.com/bitcoin",
         "",
         "",
         ""
     ],
     "official_forum_url": [
         "https://bitcointalk.org/",
         "",
         ""
     ],
     "chat_url": [
         "",
         "",
         ""
     ],
     "announcement_url": [
         "",
         ""
     ],
     "twitter_screen_name": "bitcoin",
     "facebook_username": "bitcoins",
     "bitcointalk_thread_identifier": null,
     "telegram_channel_identifier": "",
     "subreddit_url": "https://www.reddit.com/r/Bitcoin/",
     "repos_url": {
         "github": [
             "https://github.com/bitcoin/bitcoin",
             "https://github.com/bitcoin/bips"
         ],
         "bitbucket": []
     }
 },
 "image": {
     "thumb": "https://coin-images.coingecko.com/coins/images/1/thumb/bitcoin.png?1696501400",
     "small": "https://coin-images.coingecko.com/coins/images/1/small/bitcoin.png?1696501400",
     "large": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"
 },
 "country_origin": "",
 "genesis_date": "2009-01-03",
 "sentiment_votes_up_percentage": 86.74,
 "sentiment_votes_down_percentage": 13.26,
 "watchlist_portfolio_users": 1701166,
 "market_cap_rank": 1,
 "market_data": {
     "current_price": {
         "aed": 248843,
         "ars": 66749207,
         "aud": 102345,
         "bch": 186.607,
         "bdt": 8079049,
         "bhd": 25538,
         "bmd": 67749,
         "bnb": 114.473,
         "brl": 383833,
         "btc": 1.0,
         "cad": 93868,
         "chf": 58651,
         "clp": 64149612,
         "cny": 482699,
         "czk": 1578182,
         "dkk": 467049,
         "dot": 16424,
         "eos": 145079,
         "eth": 27.122627,
         "eur": 62610,
         "gbp": 52273,
         "gel": 184278,
         "hkd": 526482,
         "huf": 25241291,
         "idr": 1059909873,
         "ils": 257125,
         "inr": 5695983,
         "jpy": 10278999,
         "krw": 94024888,
         "kwd": 20754,
         "lkr": 19856125,
         "ltc": 950.77,
         "mmk": 142137661,
         "mxn": 1344231,
         "myr": 294709,
         "ngn": 111213573,
         "nok": 741368,
         "nzd": 113111,
         "php": 3952450,
         "pkr": 18781313,
         "pln": 271997,
         "rub": 6520859,
         "sar": 254477,
         "sek": 716122,
         "sgd": 89416,
         "thb": 2289345,
         "try": 2323375,
         "twd": 2173798,
         "uah": 2788973,
         "usd": 67749,
         "vef": 6783.72,
         "vnd": 1721487312,
         "xag": 2025.75,
         "xau": 24.86,
         "xdr": 50723,
         "xlm": 705833,
         "xrp": 128697,
         "yfi": 13.773585,
         "zar": 1199988,
         "bits": 999934,
         "link": 5746,
         "sats": 99993432
     },
     "total_value_locked": null,
     "mcap_to_tvl_ratio": null,
     "fdv_to_tvl_ratio": null,
     "roi": null,
     "ath": {
         "aed": 270832,
         "ars": 67966504,
         "aud": 111440,
         "bch": 270.677,
         "bdt": 8447272,
         "bhd": 27794,
         "bmd": 73738,
         "bnb": 143062,
         "brl": 395640,
         "btc": 1.003301,
         "cad": 99381,
         "chf": 65815,
         "clp": 70749614,
         "cny": 530375,
         "czk": 1703814,
         "dkk": 502620,
         "dot": 16456,
         "eos": 145203,
         "eth": 624.203,
         "eur": 67405,
         "gbp": 57639,
         "gel": 200913,
         "hkd": 576788,
         "huf": 26873106,
         "idr": 1171203031,
         "ils": 270420,
         "inr": 6110932,
         "jpy": 11230398,
         "krw": 98576718,
         "kwd": 22651,
         "lkr": 22592284,
         "ltc": 1015,
         "mmk": 222355720,
         "mxn": 1409247,
         "myr": 345647,
         "ngn": 118524884,
         "nok": 777707,
         "nzd": 120651,
         "php": 4215196,
         "pkr": 20569197,
         "pln": 288843,
         "rub": 6746469,
         "sar": 276540,
         "sek": 769988,
         "sgd": 98281,
         "thb": 2666077,
         "try": 2380499,
         "twd": 2333691,
         "uah": 2892060,
         "usd": 73738,
         "vef": 8618768857,
         "vnd": 1827754928,
         "xag": 3040.05,
         "xau": 37.72,
         "xdr": 55169,
         "xlm": 731116,
         "xrp": 159288,
         "yfi": 13.904993,
         "zar": 1375794,
         "bits": 1058236,
         "link": 74906,
         "sats": 105823579
     },
     "ath_change_percentage": {
         "aed": -8.08017,
         "ars": -1.74789,
         "aud": -8.13546,
         "bch": -30.99621,
         "bdt": -4.3184,
         "bhd": -8.07657,
         "bmd": -8.08267,
         "bnb": -99.91997,
         "brl": -2.94319,
         "btc": -0.32896,
         "cad": -5.4921,
         "chf": -10.85337,
         "clp": -9.2901,
         "cny": -8.9491,
         "czk": -7.33977,
         "dkk": -7.04433,
         "dot": -0.03127,
         "eos": -0.0647,
         "eth": -95.65552,
         "eur": -7.08931,
         "gbp": -9.27503,
         "gel": -8.24105,
         "hkd": -8.68335,
         "huf": -6.03486,
         "idr": -9.50748,
         "ils": -4.8762,
         "inr": -6.75063,
         "jpy": -8.43784,
         "krw": -4.59988,
         "kwd": -8.33552,
         "lkr": -12.07364,
         "ltc": -6.10025,
         "mmk": -36.04926,
         "mxn": -4.58404,
         "myr": -14.70072,
         "ngn": -6.12867,
         "nok": -4.62128,
         "nzd": -6.18908,
         "php": -6.20386,
         "pkr": -8.65321,
         "pln": -5.79843,
         "rub": -3.30438,
         "sar": -7.93904,
         "sek": -6.94761,
         "sgd": -8.98554,
         "thb": -14.09533,
         "try": -2.35643,
         "twd": -6.82782,
         "uah": -3.52347,
         "usd": -8.08267,
         "vef": -99.99992,
         "vnd": -5.79799,
         "xag": -33.24553,
         "xau": -34.03059,
         "xdr": -8.02063,
         "xlm": -3.27929,
         "xrp": -19.16169,
         "yfi": -0.98883,
         "zar": -12.79502,
         "bits": -5.50159,
         "link": -92.33916,
         "sats": -5.50159
     },
     "ath_date": {
         "aed": "2024-03-14T07:10:36.635Z",
         "ars": "2024-10-21T01:35:22.852Z",
         "aud": "2024-03-14T07:10:36.635Z",
         "bch": "2023-06-10T04:30:21.139Z",
         "bdt": "2024-06-07T12:20:33.049Z",
         "bhd": "2024-03-14T07:10:36.635Z",
         "bmd": "2024-03-14T07:10:36.635Z",
         "bnb": "2017-10-19T00:00:00.000Z",
         "brl": "2024-07-29T11:21:43.812Z",
         "btc": "2019-10-15T16:00:56.136Z",
         "cad": "2024-03-14T07:10:36.635Z",
         "chf": "2024-04-08T12:16:10.708Z",
         "clp": "2024-03-13T09:15:27.924Z",
         "cny": "2024-03-14T07:10:36.635Z",
         "czk": "2024-03-13T09:15:27.924Z",
         "dkk": "2024-03-14T07:10:36.635Z",
         "dot": "2024-10-25T04:36:13.434Z",
         "eos": "2024-10-25T04:36:13.434Z",
         "eth": "2015-10-20T00:00:00.000Z",
         "eur": "2024-03-14T07:10:36.635Z",
         "gbp": "2024-03-14T07:10:36.635Z",
         "gel": "2024-06-10T18:15:34.123Z",
         "hkd": "2024-03-14T07:10:36.635Z",
         "huf": "2024-03-13T08:35:34.668Z",
         "idr": "2024-06-05T18:05:25.718Z",
         "ils": "2024-03-13T09:15:27.924Z",
         "inr": "2024-03-14T07:10:36.635Z",
         "jpy": "2024-06-07T13:55:20.414Z",
         "krw": "2024-06-07T13:55:20.414Z",
         "kwd": "2024-03-14T07:10:36.635Z",
         "lkr": "2024-03-13T09:15:27.924Z",
         "ltc": "2024-08-08T23:11:32.412Z",
         "mmk": "2024-07-22T00:50:47.932Z",
         "mxn": "2021-11-10T17:30:22.767Z",
         "myr": "2024-03-14T07:10:36.635Z",
         "ngn": "2024-03-14T07:10:36.635Z",
         "nok": "2024-04-08T12:16:10.708Z",
         "nzd": "2024-04-08T12:16:10.708Z",
         "php": "2024-06-05T16:15:39.385Z",
         "pkr": "2024-03-14T07:10:36.635Z",
         "pln": "2024-03-13T09:15:27.924Z",
         "rub": "2024-03-13T09:15:27.924Z",
         "sar": "2024-03-14T07:10:36.635Z",
         "sek": "2024-04-12T12:36:25.803Z",
         "sgd": "2024-03-14T07:10:36.635Z",
         "thb": "2024-04-08T12:16:10.708Z",
         "try": "2024-10-21T01:35:22.852Z",
         "twd": "2024-04-08T12:16:10.708Z",
         "uah": "2024-06-07T12:20:33.049Z",
         "usd": "2024-03-14T07:10:36.635Z",
         "vef": "2021-01-03T12:04:17.372Z",
         "vnd": "2024-06-07T12:20:33.049Z",
         "xag": "2024-03-13T09:15:27.924Z",
         "xau": "2021-10-20T14:54:17.702Z",
         "xdr": "2024-03-14T07:10:36.635Z",
         "xlm": "2024-06-18T17:56:17.250Z",
         "xrp": "2021-01-03T07:54:40.240Z",
         "yfi": "2024-10-18T16:21:23.396Z",
         "zar": "2024-03-13T08:35:34.668Z",
         "bits": "2021-05-19T16:00:11.072Z",
         "link": "2017-12-12T00:00:00.000Z",
         "sats": "2021-05-19T16:00:11.072Z"
     },
     "atl": {
         "aed": 632.31,
         "ars": 1478.98,
         "aud": 72.61,
         "bch": 3.513889,
         "bdt": 9390.25,
         "bhd": 45.91,
         "bmd": 121.77,
         "bnb": 52.17,
         "brl": 149.66,
         "btc": 0.99895134,
         "cad": 69.81,
         "chf": 63.26,
         "clp": 107408,
         "cny": 407.23,
         "czk": 4101.56,
         "dkk": 382.47,
         "dot": 991.882,
         "eos": 908.141,
         "eth": 6.779735,
         "eur": 51.3,
         "gbp": 43.9,
         "gel": 102272,
         "hkd": 514.37,
         "huf": 46598,
         "idr": 658780,
         "ils": 672.18,
         "inr": 3993.42,
         "jpy": 6641.83,
         "krw": 75594,
         "kwd": 50.61,
         "lkr": 22646,
         "ltc": 20.707835,
         "mmk": 117588,
         "mxn": 859.32,
         "myr": 211.18,
         "ngn": 10932.64,
         "nok": 1316.03,
         "nzd": 84.85,
         "php": 2880.5,
         "pkr": 17315.84,
         "pln": 220.11,
         "rub": 2206.43,
         "sar": 646.04,
         "sek": 443.81,
         "sgd": 84.47,
         "thb": 5644.35,
         "try": 392.91,
         "twd": 1998.66,
         "uah": 553.37,
         "usd": 67.81,
         "vef": 766.19,
         "vnd": 3672339,
         "xag": 3.37,
         "xau": 0.0531,
         "xdr": 44.39,
         "xlm": 21608,
         "xrp": 9908,
         "yfi": 0.23958075,
         "zar": 666.26,
         "bits": 950993,
         "link": 598.477,
         "sats": 95099268
     },
     "atl_change_percentage": {
         "aed": 39271.0039,
         "ars": 4515083.03669,
         "aud": 140891.98218,
         "bch": 5215.40409,
         "bdt": 85973.12737,
         "bhd": 55546.89642,
         "bmd": 55560.62524,
         "bnb": 119.46969,
         "brl": 256481.44246,
         "btc": 0.10498,
         "cad": 134448.05068,
         "chf": 92646.21014,
         "clp": 59650.46501,
         "cny": 118485.72358,
         "czk": 38391.67432,
         "dkk": 122057.7831,
         "dot": 1558.55182,
         "eos": 15878.6323,
         "eth": 299.99147,
         "eur": 121983.37815,
         "gbp": 119012.76269,
         "gel": 80.26121,
         "hkd": 102296.75597,
         "huf": 54089.72214,
         "idr": 160780.90026,
         "ils": 38168.37536,
         "inr": 142594.9026,
         "jpy": 154718.65959,
         "krw": 124304.79102,
         "kwd": 40923.82254,
         "lkr": 87616.64174,
         "ltc": 4502.04648,
         "mmk": 120829.15608,
         "mxn": 156378.25785,
         "myr": 139515.32257,
         "ngn": 1017594.33465,
         "nok": 56264.10686,
         "nzd": 133285.58479,
         "php": 137156.99049,
         "pkr": 108409.30481,
         "pln": 123516.6044,
         "rub": 295560.00239,
         "sar": 39307.08213,
         "sek": 161342.94331,
         "sgd": 105800.34333,
         "thb": 40476.60332,
         "try": 591487.85473,
         "twd": 108690.65554,
         "uah": 504114.14149,
         "usd": 99854.19981,
         "vef": 785.76069,
         "vnd": 46785.15249,
         "xag": 60123.9923,
         "xau": 46756.13037,
         "xdr": 114211.01912,
         "xlm": 3172.54214,
         "xrp": 1199.61668,
         "yfi": 5646.49486,
         "zar": 179972.80372,
         "bits": 5.15497,
         "link": 858.84194,
         "sats": 5.15497
     },
     "atl_date": {
         "aed": "2015-01-14T00:00:00.000Z",
         "ars": "2015-01-14T00:00:00.000Z",
         "aud": "2013-07-05T00:00:00.000Z",
         "bch": "2017-08-02T00:00:00.000Z",
         "bdt": "2013-09-08T00:00:00.000Z",
         "bhd": "2013-09-08T00:00:00.000Z",
         "bmd": "2013-09-08T00:00:00.000Z",
         "bnb": "2022-11-27T02:35:06.345Z",
         "brl": "2013-07-05T00:00:00.000Z",
         "btc": "2019-10-21T00:00:00.000Z",
         "cad": "2013-07-05T00:00:00.000Z",
         "chf": "2013-07-05T00:00:00.000Z",
         "clp": "2015-01-14T00:00:00.000Z",
         "cny": "2013-07-05T00:00:00.000Z",
         "czk": "2015-01-14T00:00:00.000Z",
         "dkk": "2013-07-05T00:00:00.000Z",
         "dot": "2021-05-19T11:04:48.978Z",
         "eos": "2019-04-11T00:00:00.000Z",
         "eth": "2017-06-12T00:00:00.000Z",
         "eur": "2013-07-05T00:00:00.000Z",
         "gbp": "2013-07-05T00:00:00.000Z",
         "gel": "2024-01-23T14:25:15.024Z",
         "hkd": "2013-07-05T00:00:00.000Z",
         "huf": "2015-01-14T00:00:00.000Z",
         "idr": "2013-07-05T00:00:00.000Z",
         "ils": "2015-01-14T00:00:00.000Z",
         "inr": "2013-07-05T00:00:00.000Z",
         "jpy": "2013-07-05T00:00:00.000Z",
         "krw": "2013-07-05T00:00:00.000Z",
         "kwd": "2015-01-14T00:00:00.000Z",
         "lkr": "2015-01-14T00:00:00.000Z",
         "ltc": "2013-11-28T00:00:00.000Z",
         "mmk": "2013-09-08T00:00:00.000Z",
         "mxn": "2013-07-05T00:00:00.000Z",
         "myr": "2013-07-05T00:00:00.000Z",
         "ngn": "2013-07-06T00:00:00.000Z",
         "nok": "2015-01-14T00:00:00.000Z",
         "nzd": "2013-07-05T00:00:00.000Z",
         "php": "2013-07-05T00:00:00.000Z",
         "pkr": "2015-01-14T00:00:00.000Z",
         "pln": "2013-07-05T00:00:00.000Z",
         "rub": "2013-07-05T00:00:00.000Z",
         "sar": "2015-01-14T00:00:00.000Z",
         "sek": "2013-07-05T00:00:00.000Z",
         "sgd": "2013-07-05T00:00:00.000Z",
         "thb": "2015-01-14T00:00:00.000Z",
         "try": "2015-01-14T00:00:00.000Z",
         "twd": "2013-07-05T00:00:00.000Z",
         "uah": "2013-07-06T00:00:00.000Z",
         "usd": "2013-07-06T00:00:00.000Z",
         "vef": "2013-09-08T00:00:00.000Z",
         "vnd": "2015-01-14T00:00:00.000Z",
         "xag": "2013-07-05T00:00:00.000Z",
         "xau": "2013-07-05T00:00:00.000Z",
         "xdr": "2013-07-05T00:00:00.000Z",
         "xlm": "2018-11-20T00:00:00.000Z",
         "xrp": "2018-12-25T00:00:00.000Z",
         "yfi": "2020-09-12T20:09:36.122Z",
         "zar": "2013-07-05T00:00:00.000Z",
         "bits": "2021-05-19T13:14:13.071Z",
         "link": "2020-08-16T08:13:13.338Z",
         "sats": "2021-05-19T13:14:13.071Z"
     },
     "market_cap": {
         "aed": 4922180807940,
         "ars": 1320350142907822,
         "aud": 2024410014225,
         "bch": 3691504124,
         "bdt": 159806042835371,
         "bhd": 505158069327,
         "bmd": 1340098232491,
         "bnb": 2263184254,
         "brl": 7592326536179,
         "btc": 19772606,
         "cad": 1856641776402,
         "chf": 1160070776037,
         "clp": 1268898813399020,
         "cny": 9548065896677,
         "czk": 31216114217829,
         "dkk": 9237833155855,
         "dot": 325049485778,
         "eos": 2868740273042,
         "eth": 536038947,
         "eur": 1238384776645,
         "gbp": 1033952791279,
         "gel": 3645067192376,
         "hkd": 10413879242922,
         "huf": 499265519368603,
         "idr": 20955933532108724,
         "ils": 5086001116371,
         "inr": 112668268420751,
         "jpy": 203324394177392,
         "krw": 1859335274681550,
         "kwd": 410514971756,
         "lkr": 392760180465718,
         "ltc": 18800894139,
         "mmk": 2811526091766715,
         "mxn": 26585404775455,
         "myr": 5829427311337,
         "ngn": 2199838253546060,
         "nok": 14662825521118,
         "nzd": 2238028372976,
         "php": 78171952876110,
         "pkr": 371500070107421,
         "pln": 5379599217833,
         "rub": 128982736871352,
         "sar": 5033627397249,
         "sek": 14163632229024,
         "sgd": 1768585261643,
         "thb": 45281919275881,
         "try": 45957864824349,
         "twd": 42990753327790,
         "uah": 55166727736614,
         "usd": 1340098232491,
         "vef": 134184036019,
         "vnd": 34051541791092640,
         "xag": 40046209085,
         "xau": 491615037,
         "xdr": 1003310105095,
         "xlm": 13968316912538,
         "xrp": 2545365463514,
         "yfi": 272178607,
         "zar": 23729856456751,
         "bits": 19770470208709,
         "link": 113535839921,
         "sats": 1977047020870913
     },
     "market_cap_rank": 1,
     "fully_diluted_valuation": {
         "aed": 5227727542174,
         "ars": 1402311511242588,
         "aud": 2150076236725,
         "bch": 3920656013,
         "bdt": 169726079584188,
         "bhd": 536515998744,
         "bmd": 1423285472958,
         "bnb": 2403672502,
         "brl": 8063623847042,
         "btc": 21000000,
         "cad": 1971893705080,
         "chf": 1232082725806,
         "clp": 1347666315779489,
         "cny": 10140766666277,
         "czk": 33153869478530,
         "dkk": 9811276079287,
         "dot": 345227088495,
         "eos": 3046818701282,
         "eth": 569313822,
         "eur": 1315258105560,
         "gbp": 1098135906661,
         "gel": 3871336486445,
         "hkd": 11060325791216,
         "huf": 530257665921258,
         "idr": 22256783156164808,
         "ils": 5401717074815,
         "inr": 119662205216438,
         "jpy": 215945853456304,
         "krw": 1974754403557758,
         "kwd": 435997885502,
         "lkr": 417140957028126,
         "ltc": 19967968660,
         "mmk": 2986052922265331,
         "mxn": 28235706526725,
         "myr": 6191291807366,
         "ngn": 2336394268133764,
         "nok": 15573027447342,
         "nzd": 2376955057542,
         "php": 83024514340614,
         "pkr": 394561115123410,
         "pln": 5713540419229,
         "rub": 136989402120206,
         "sar": 5346092231961,
         "sek": 15042846492238,
         "sgd": 1878371039938,
         "thb": 48092816131242,
         "try": 48810721323802,
         "twd": 45659424958126,
         "uah": 58591228817734,
         "usd": 1423285472958,
         "vef": 142513574407,
         "vnd": 36165307578219352,
         "xag": 42532096720,
         "xau": 522132276,
         "xdr": 1065591061036,
         "xlm": 14835406883812,
         "xrp": 2703370245368,
         "yfi": 289074225,
         "zar": 25202898676673,
         "bits": 20997731628440,
         "link": 120583631633,
         "sats": 2099773162844047
     },
     "market_cap_fdv_ratio": 0.94,
     "total_volume": {
         "aed": 123056007866,
         "ars": 33008388766874,
         "aud": 50610828706,
         "bch": 92279469,
         "bdt": 3995199370273,
         "bhd": 12629104411,
         "bmd": 33502860840,
         "bnb": 56608526,
         "brl": 189810458091,
         "btc": 494481,
         "cad": 46418883751,
         "chf": 29003493635,
         "clp": 31722853843857,
         "cny": 238701182915,
         "czk": 780432358342,
         "dkk": 230962256581,
         "dot": 8122006226,
         "eos": 71743601641,
         "eth": 13412507,
         "eur": 30961367320,
         "gbp": 25849735333,
         "gel": 91127781486,
         "hkd": 260352406733,
         "huf": 12482161131294,
         "idr": 524139815319546,
         "ils": 127151565090,
         "inr": 2816740763101,
         "jpy": 5083104300982,
         "krw": 46496583217785,
         "kwd": 10262998367,
         "lkr": 9819123218522,
         "ltc": 470168660,
         "mmk": 70289002042954,
         "mxn": 664740312791,
         "myr": 145737444655,
         "ngn": 54996621212398,
         "nok": 366616680238,
         "nzd": 55935069847,
         "php": 1954540216999,
         "pkr": 9287614033960,
         "pln": 134506347622,
         "rub": 3224653237125,
         "sar": 125842206282,
         "sek": 354131939654,
         "sgd": 44217511274,
         "thb": 1132111922085,
         "try": 1148940409085,
         "twd": 1074972725916,
         "uah": 1379184866873,
         "usd": 33502860840,
         "vef": 3354641456,
         "vnd": 851298836432224,
         "xag": 1001761671,
         "xau": 12291865,
         "xdr": 25083055865,
         "xlm": 349043869671,
         "xrp": 63642559762,
         "yfi": 6811225,
         "zar": 593410477370,
         "bits": 494481090519,
         "link": 2841620740,
         "sats": 49448109051927
     },
     "high_24h": {
         "aed": 252781,
         "ars": 67803780,
         "aud": 103623,
         "bch": 189.774,
         "bdt": 8225041,
         "bhd": 25942,
         "bmd": 68821,
         "bnb": 114.996,
         "brl": 389804,
         "btc": 1.0,
         "cad": 95344,
         "chf": 59585,
         "clp": 64925843,
         "cny": 489960,
         "czk": 1602196,
         "dkk": 474179,
         "dot": 16456,
         "eos": 145203,
         "eth": 27.140595,
         "eur": 63573,
         "gbp": 53052,
         "gel": 187194,
         "hkd": 534883,
         "huf": 25610161,
         "idr": 1074728644,
         "ils": 261194,
         "inr": 5788000,
         "jpy": 10447432,
         "krw": 94921907,
         "kwd": 21080,
         "lkr": 20214939,
         "ltc": 968.092,
         "mmk": 144387283,
         "mxn": 1363276,
         "myr": 299235,
         "ngn": 113164403,
         "nok": 752390,
         "nzd": 114417,
         "php": 3986304,
         "pkr": 19118271,
         "pln": 276231,
         "rub": 6624418,
         "sar": 258500,
         "sek": 726811,
         "sgd": 90741,
         "thb": 2318043,
         "try": 2359322,
         "twd": 2207687,
         "uah": 2839293,
         "usd": 68821,
         "vef": 6891.09,
         "vnd": 1748067340,
         "xag": 2043.41,
         "xau": 25.15,
         "xdr": 51638,
         "xlm": 714863,
         "xrp": 128769,
         "yfi": 13.802559,
         "zar": 1217135,
         "bits": 1000687,
         "link": 5945,
         "sats": 100068692
     },
     "low_24h": {
         "aed": 244940,
         "ars": 65670743,
         "aud": 100233,
         "bch": 184.507,
         "bdt": 7960501,
         "bhd": 25138,
         "bmd": 66688,
         "bnb": 113.464,
         "brl": 379441,
         "btc": 1.0,
         "cad": 92151,
         "chf": 57734,
         "clp": 62913178,
         "cny": 474425,
         "czk": 1556864,
         "dkk": 460565,
         "dot": 15908,
         "eos": 142580,
         "eth": 26.336005,
         "eur": 61732,
         "gbp": 51465,
         "gel": 182725,
         "hkd": 518147,
         "huf": 24855052,
         "idr": 1037688904,
         "ils": 252054,
         "inr": 5606653,
         "jpy": 10132942,
         "krw": 91978106,
         "kwd": 20432,
         "lkr": 19552077,
         "ltc": 950.643,
         "mmk": 139911358,
         "mxn": 1320847,
         "myr": 290126,
         "ngn": 109526319,
         "nok": 728997,
         "nzd": 110675,
         "php": 3862230,
         "pkr": 18502840,
         "pln": 267913,
         "rub": 6451279,
         "sar": 250434,
         "sek": 704759,
         "sgd": 88013,
         "thb": 2245584,
         "try": 2284510,
         "twd": 2138450,
         "uah": 2748102,
         "usd": 66688,
         "vef": 6677.47,
         "vnd": 1694523646,
         "xag": 1946.53,
         "xau": 24.36,
         "xdr": 49981,
         "xlm": 700537,
         "xrp": 126380,
         "yfi": 13.6226,
         "zar": 1178189,
         "bits": 999247,
         "link": 5647,
         "sats": 99924689
     },
     "price_change_24h": 427.868,
     "price_change_percentage_24h": 0.63556,
     "price_change_percentage_7d": 0.18058,
     "price_change_percentage_14d": 11.82869,
     "price_change_percentage_30d": 5.08927,
     "price_change_percentage_60d": 5.68789,
     "price_change_percentage_200d": -2.47536,
     "price_change_percentage_1y": 99.26394,
     "market_cap_change_24h": 10854700612,
     "market_cap_change_percentage_24h": 0.81661,
     "price_change_24h_in_currency": {
         "aed": 1571.56,
         "ars": 620090,
         "aud": 1066.57,
         "bch": -2.1483676280818145,
         "bdt": 42953,
         "bhd": 204.98,
         "bmd": 427.87,
         "bnb": 0.52677141,
         "brl": 788.18,
         "btc": 0.0,
         "cad": 805.42,
         "chf": 363.0,
         "clp": 638994,
         "cny": 3984.24,
         "czk": 2257.01,
         "dkk": 1786.19,
         "dot": 499.671,
         "eos": 2459,
         "eth": 0.70040238,
         "eur": 236.6,
         "gbp": 200.54,
         "gel": -182.6236338491144,
         "hkd": 3547.15,
         "huf": 96692,
         "idr": 11153981,
         "ils": 1739.32,
         "inr": 36395,
         "jpy": 37921,
         "krw": 1205562,
         "kwd": 131.74,
         "lkr": 118376,
         "ltc": -9.210270264800215,
         "mmk": 897667,
         "mxn": 9659.5,
         "myr": 1692.92,
         "ngn": 647164,
         "nok": 3031.92,
         "nzd": 1209.5,
         "php": 50308,
         "pkr": 102764,
         "pln": 865.03,
         "rub": 68560,
         "sar": 1663.36,
         "sek": 3612.4,
         "sgd": 554.07,
         "thb": 18598.57,
         "try": 15622.19,
         "twd": 16118.48,
         "uah": 14774.02,
         "usd": 427.87,
         "vef": 42.84,
         "vnd": 9130489,
         "xag": 41.38,
         "xau": 0.166406,
         "xdr": 267.36,
         "xlm": 397.574,
         "xrp": 1765,
         "yfi": 0.12600465,
         "zar": 3016.34,
         "bits": -323.0490857559489,
         "link": -134.7535529296929,
         "sats": -32304.908575594425
     },
     "price_change_percentage_1h_in_currency": {
         "aed": -0.36276,
         "ars": -0.36277,
         "aud": -0.31406,
         "bch": -0.04993,
         "bdt": -0.36276,
         "bhd": -0.35404,
         "bmd": -0.36276,
         "bnb": 0.20715,
         "brl": -0.36276,
         "btc": 0.0,
         "cad": -0.36729,
         "chf": -0.39337,
         "clp": -0.36276,
         "cny": -0.37814,
         "czk": -0.35181,
         "dkk": -0.35633,
         "dot": 0.52279,
         "eos": 0.62691,
         "eth": 0.63446,
         "eur": -0.35866,
         "gbp": -0.34739,
         "gel": -0.36276,
         "hkd": -0.35771,
         "huf": -0.36335,
         "idr": -0.34073,
         "ils": -0.36276,
         "inr": -0.35867,
         "jpy": -0.43905,
         "krw": -0.44849,
         "kwd": -0.36406,
         "lkr": -0.36276,
         "ltc": -0.17234,
         "mmk": -0.36276,
         "mxn": -0.33966,
         "myr": -0.36276,
         "ngn": -0.36276,
         "nok": -0.37295,
         "nzd": -0.36109,
         "php": -0.34055,
         "pkr": -0.36276,
         "pln": -0.33987,
         "rub": -0.36459,
         "sar": -0.36162,
         "sek": -0.37802,
         "sgd": -0.39921,
         "thb": -0.44672,
         "try": -0.36596,
         "twd": -0.33543,
         "uah": -0.36276,
         "usd": -0.36276,
         "vef": -0.36276,
         "vnd": -0.33744,
         "xag": -0.35993,
         "xau": -0.35461,
         "xdr": -0.36276,
         "xlm": 0.10238,
         "xrp": 0.061,
         "yfi": 0.43712,
         "zar": -0.21132,
         "bits": 0.00485,
         "link": 0.89314,
         "sats": 0.00485
     },
     "price_change_percentage_24h_in_currency": {
         "aed": 0.63556,
         "ars": 0.9377,
         "aud": 1.05312,
         "bch": -1.13818,
         "bdt": 0.5345,
         "bhd": 0.80912,
         "bmd": 0.63556,
         "bnb": 0.4623,
         "brl": 0.20577,
         "btc": 0.0,
         "cad": 0.86546,
         "chf": 0.62278,
         "clp": 1.00612,
         "cny": 0.83228,
         "czk": 0.14322,
         "dkk": 0.38391,
         "dot": 3.13774,
         "eos": 1.7242,
         "eth": 2.65081,
         "eur": 0.37933,
         "gbp": 0.38511,
         "gel": -0.099,
         "hkd": 0.67832,
         "huf": 0.38454,
         "idr": 1.06354,
         "ils": 0.68106,
         "inr": 0.64307,
         "jpy": 0.37028,
         "krw": 1.29883,
         "kwd": 0.63885,
         "lkr": 0.59975,
         "ltc": -0.95942,
         "mmk": 0.63556,
         "mxn": 0.72379,
         "myr": 0.57776,
         "ngn": 0.58532,
         "nok": 0.41064,
         "nzd": 1.08086,
         "php": 1.28924,
         "pkr": 0.55017,
         "pln": 0.31905,
         "rub": 1.06257,
         "sar": 0.65794,
         "sek": 0.507,
         "sgd": 0.62352,
         "thb": 0.81905,
         "try": 0.67694,
         "twd": 0.74703,
         "uah": 0.53255,
         "usd": 0.63556,
         "vef": 0.63556,
         "vnd": 0.53321,
         "xag": 2.08534,
         "xau": 0.67398,
         "xdr": 0.52989,
         "xlm": 0.05636,
         "xrp": 1.39024,
         "yfi": 0.92327,
         "zar": 0.252,
         "bits": -0.0323,
         "link": -2.29132,
         "sats": -0.0323
     },
     "price_change_percentage_7d_in_currency": {
         "aed": 0.18058,
         "ars": 0.6409,
         "aud": 1.46991,
         "bch": 2.57372,
         "bdt": -0.00811,
         "bhd": 0.17314,
         "bmd": 0.18058,
         "bnb": 0.67259,
         "brl": 0.39677,
         "btc": 0.0,
         "cad": 0.62665,
         "chf": 0.17548,
         "clp": 0.22927,
         "cny": 0.25515,
         "czk": 0.21714,
         "dkk": 0.35537,
         "dot": 2.43865,
         "eos": 2.78491,
         "eth": 4.76763,
         "eur": 0.34617,
         "gbp": 0.64744,
         "gel": 0.18058,
         "hkd": 0.16898,
         "huf": 1.09482,
         "idr": 1.34222,
         "ils": 1.77645,
         "inr": 0.19335,
         "jpy": 1.40197,
         "krw": 1.37362,
         "kwd": 0.09986,
         "lkr": 0.28323,
         "ltc": 2.47665,
         "mmk": 0.18058,
         "mxn": 0.28419,
         "myr": 1.1925,
         "ngn": 0.41793,
         "nok": 0.45576,
         "nzd": 1.37874,
         "php": 1.44033,
         "pkr": -0.35276,
         "pln": 1.17596,
         "rub": -1.00126,
         "sar": 0.18498,
         "sek": 0.50476,
         "sgd": 0.65096,
         "thb": 2.20708,
         "try": 0.4665,
         "twd": 0.02158,
         "uah": 0.0539,
         "usd": 0.18058,
         "vef": 0.18058,
         "vnd": 0.75332,
         "xag": -4.17094,
         "xau": -0.39227,
         "xdr": 0.03814,
         "xlm": -0.11096,
         "xrp": 3.4111,
         "yfi": 0.97958,
         "zar": 0.60334,
         "bits": -0.0075,
         "link": -5.10579,
         "sats": -0.0075
     },
     "price_change_percentage_14d_in_currency": {
         "aed": 11.82823,
         "ars": 13.03279,
         "aud": 13.9938,
         "bch": -0.31801,
         "bdt": 11.5819,
         "bhd": 11.82246,
         "bmd": 11.82869,
         "bnb": 6.55412,
         "brl": 13.47102,
         "btc": 0.0,
         "cad": 12.65192,
         "chf": 12.98147,
         "clp": 13.84622,
         "cny": 12.66839,
         "czk": 12.45433,
         "dkk": 13.04356,
         "dot": 11.15222,
         "eos": 11.54433,
         "eth": 7.87115,
         "eur": 13.05659,
         "gbp": 12.64259,
         "gel": 11.6235,
         "hkd": 11.83246,
         "huf": 13.62872,
         "idr": 12.16243,
         "ils": 12.65552,
         "inr": 11.96944,
         "jpy": 14.09076,
         "krw": 15.25535,
         "kwd": 11.77432,
         "lkr": 11.89345,
         "ltc": 1.95548,
         "mmk": 11.82869,
         "mxn": 14.06822,
         "myr": 13.47208,
         "ngn": 13.30999,
         "nok": 14.05591,
         "nzd": 13.96086,
         "php": 14.09138,
         "pkr": 11.59918,
         "pln": 14.17985,
         "rub": 11.42098,
         "sar": 11.86383,
         "sek": 13.89158,
         "sgd": 13.06859,
         "thb": 13.42589,
         "try": 11.88859,
         "twd": 11.53668,
         "uah": 11.6517,
         "usd": 11.82869,
         "vef": 11.82869,
         "vnd": 14.48552,
         "xag": 4.63928,
         "xau": 8.539,
         "xdr": 12.52683,
         "xlm": 5.44385,
         "xrp": 13.64465,
         "yfi": 11.09436,
         "zar": 13.21587,
         "bits": 0.00846,
         "link": 0.6925,
         "sats": 0.00846
     },
     "price_change_percentage_30d_in_currency": {
         "aed": 5.08927,
         "ars": 7.26572,
         "aud": 9.36048,
         "bch": 2.46415,
         "bdt": 4.83567,
         "bhd": 5.1166,
         "bmd": 5.08927,
         "bnb": 7.81998,
         "brl": 9.23061,
         "btc": 0.0,
         "cad": 8.42936,
         "chf": 8.06277,
         "clp": 8.90075,
         "cny": 6.70373,
         "czk": 9.26063,
         "dkk": 8.77253,
         "dot": 19.15938,
         "eos": 19.23187,
         "eth": 11.34304,
         "eur": 8.74716,
         "gbp": 8.8124,
         "gel": 4.89645,
         "hkd": 4.87045,
         "huf": 11.19884,
         "idr": 8.92815,
         "ils": 6.17459,
         "inr": 5.74351,
         "jpy": 11.25471,
         "krw": 9.79185,
         "kwd": 5.50325,
         "lkr": 1.61733,
         "ltc": -1.23716,
         "mmk": 5.08927,
         "mxn": 7.85338,
         "myr": 10.86173,
         "ngn": 5.53609,
         "nok": 10.57391,
         "nzd": 11.15986,
         "php": 9.59993,
         "pkr": 4.84125,
         "pln": 10.98838,
         "rub": 9.46904,
         "sar": 5.21513,
         "sek": 10.13534,
         "sgd": 8.11049,
         "thb": 8.73007,
         "try": 5.57382,
         "twd": 5.83704,
         "uah": 4.6715,
         "usd": 5.08927,
         "vef": 5.08927,
         "vnd": 8.74757,
         "xag": 0.40216,
         "xau": 2.58675,
         "xdr": 6.32423,
         "xlm": 6.07817,
         "xrp": 18.39398,
         "yfi": 10.16903,
         "zar": 7.43855,
         "bits": -0.03011,
         "link": 9.42718,
         "sats": -0.03011
     },
     "price_change_percentage_60d_in_currency": {
         "aed": 5.69077,
         "ars": 10.78376,
         "aud": 8.21364,
         "bch": 3.09762,
         "bdt": 6.15723,
         "bhd": 6.42136,
         "bmd": 5.68789,
         "bnb": 1.75607,
         "brl": 9.12806,
         "btc": 0.0,
         "cad": 8.36712,
         "chf": 7.9732,
         "clp": 10.07997,
         "cny": 5.70867,
         "czk": 9.94621,
         "dkk": 9.20718,
         "dot": 23.42235,
         "eos": 21.03991,
         "eth": 16.12309,
         "eur": 9.2212,
         "gbp": 7.66476,
         "gel": 6.6683,
         "hkd": 5.36298,
         "huf": 11.88628,
         "idr": 7.36913,
         "ils": 8.70892,
         "inr": 6.00766,
         "jpy": 11.34499,
         "krw": 10.59642,
         "kwd": 6.0139,
         "lkr": 3.98177,
         "ltc": -4.60934,
         "mmk": 5.68789,
         "mxn": 9.2301,
         "myr": 5.773,
         "ngn": 10.51711,
         "nok": 10.45376,
         "nzd": 9.65899,
         "php": 9.83107,
         "pkr": 5.87395,
         "pln": 11.2373,
         "rub": 11.54953,
         "sar": 5.79952,
         "sek": 9.54136,
         "sgd": 7.18134,
         "thb": 5.12635,
         "try": 6.63717,
         "twd": 6.58311,
         "uah": 6.11945,
         "usd": 5.68789,
         "vef": 5.68789,
         "vnd": 7.89001,
         "xag": -6.1881,
         "xau": -2.654,
         "xdr": 6.5248,
         "xlm": 10.49147,
         "xrp": 19.71765,
         "yfi": 18.34201,
         "zar": 5.47104,
         "bits": -0.00534,
         "link": 8.53932,
         "sats": -0.00534
     },
     "price_change_percentage_200d_in_currency": {
         "aed": -2.46208,
         "ars": 11.48628,
         "aud": -3.12766,
         "bch": 85.86577,
         "bdt": 5.8909,
         "bhd": -2.56325,
         "bmd": -2.47536,
         "bnb": -4.127,
         "brl": 9.26034,
         "btc": 0.0,
         "cad": -0.66068,
         "chf": -6.57475,
         "clp": -1.94444,
         "cny": -2.20771,
         "czk": -2.72508,
         "dkk": -2.34292,
         "dot": 103.91013,
         "eos": 111.43818,
         "eth": 33.70346,
         "eur": -2.36189,
         "gbp": -4.95974,
         "gel": -0.78825,
         "hkd": -3.2015,
         "huf": 0.96761,
         "idr": -3.98504,
         "ils": -1.65,
         "inr": -1.5198,
         "jpy": -2.50768,
         "krw": 0.03844,
         "kwd": -2.91873,
         "lkr": -4.4803,
         "ltc": 37.86046,
         "mmk": -2.63447,
         "mxn": 17.44094,
         "myr": -10.74434,
         "ngn": 23.40116,
         "nok": -0.6567,
         "nzd": -2.17507,
         "php": 0.66551,
         "pkr": -2.79107,
         "pln": -0.9497,
         "rub": 1.42276,
         "sar": -2.34113,
         "sek": -3.1277,
         "sgd": -4.58718,
         "thb": -9.96568,
         "try": 4.46179,
         "twd": -2.54977,
         "uah": 3.30695,
         "usd": -2.47536,
         "vef": -2.47536,
         "vnd": -0.70819,
         "xag": -18.68238,
         "xau": -16.08037,
         "xdr": -3.39217,
         "xlm": 30.43725,
         "xrp": 9.67218,
         "yfi": 66.08113,
         "zar": -7.67935,
         "bits": -0.01271,
         "link": 45.98608,
         "sats": -0.01271
     },
     "price_change_percentage_1y_in_currency": {
         "aed": 99.26366,
         "ars": 460.97072,
         "aud": 92.01643,
         "bch": 38.78621,
         "bdt": 115.01531,
         "bhd": 99.25336,
         "bmd": 99.26394,
         "bnb": -23.41225,
         "brl": 126.12062,
         "btc": 0.0,
         "cad": 100.87819,
         "chf": 93.18802,
         "clp": 103.64714,
         "cny": 94.15978,
         "czk": 100.0023,
         "dkk": 95.12199,
         "dot": 103.48955,
         "eos": 152.74187,
         "eth": 42.77758,
         "eur": 95.24471,
         "gbp": 87.13028,
         "gel": 101.1124,
         "hkd": 97.914,
         "huf": 105.46584,
         "idr": 96.4905,
         "ils": 86.33132,
         "inr": 101.61506,
         "jpy": 101.75392,
         "krw": 105.12158,
         "kwd": 97.47952,
         "lkr": 77.89622,
         "ltc": 94.50526,
         "mmk": 98.60141,
         "mxn": 116.46062,
         "myr": 81.49039,
         "ngn": 311.22627,
         "nok": 95.46343,
         "nzd": 94.5959,
         "php": 104.63234,
         "pkr": 97.10184,
         "pln": 90.02426,
         "rub": 105.16869,
         "sar": 99.55146,
         "sek": 89.6414,
         "sgd": 92.34481,
         "thb": 86.22491,
         "try": 142.93938,
         "twd": 97.5874,
         "uah": 123.82295,
         "usd": 99.26394,
         "vef": 99.26394,
         "vnd": 106.02338,
         "xag": 36.4803,
         "xau": 44.20851,
         "xdr": 95.1916,
         "xlm": 136.27669,
         "xrp": 109.70652,
         "yfi": 134.06898,
         "zar": 85.51413,
         "bits": -0.02506,
         "link": 91.95783,
         "sats": -0.02506
     },
     "market_cap_change_24h_in_currency": {
         "aed": 39869315346,
         "ars": 14451583481111,
         "aud": 24168335183,
         "bch": -41600855.479295254,
         "bdt": 1135079858316,
         "bhd": 4954423576,
         "bmd": 10854700612,
         "bnb": 10884725,
         "brl": 29196688490,
         "btc": 466.0,
         "cad": 18909423837,
         "chf": 9085448000,
         "clp": 14895481988798,
         "cny": 95150519715,
         "czk": 97193892993,
         "dkk": 49964951419,
         "dot": 9864027553,
         "eos": 48575892884,
         "eth": 13362114,
         "eur": 6580112626,
         "gbp": 5660628965,
         "gel": 2939915026,
         "hkd": 88255671321,
         "huf": 2646189435210,
         "idr": 239920788307896,
         "ils": 43475900880,
         "inr": 914311729793,
         "jpy": 1043170756062,
         "krw": 26382073677158,
         "kwd": 3338434583,
         "lkr": 3042631010799,
         "ltc": -184897764.8332405,
         "mmk": 22773161883103,
         "mxn": 234843882956,
         "myr": 43894838831,
         "ngn": 16728554092801,
         "nok": 81349641063,
         "nzd": 27168056307,
         "php": 1123017501713,
         "pkr": 2696197687716,
         "pln": 24914451315,
         "rub": 1588763872213,
         "sar": 41881943162,
         "sek": 91392204519,
         "sgd": 13884106297,
         "thb": 389877269275,
         "try": 389956980768,
         "twd": 383181156918,
         "uah": 390777759514,
         "usd": 10854700612,
         "vef": 1086881172,
         "vnd": 255524993051184,
         "xag": 842829600,
         "xau": 4035217,
         "xdr": 7080626013,
         "xlm": 12518994042,
         "xrp": 34848132611,
         "yfi": 2306902,
         "zar": 80826192061,
         "bits": -3179658500.1210938,
         "link": -2835529811.3381042,
         "sats": -317965850012.25
     },
     "market_cap_change_percentage_24h_in_currency": {
         "aed": 0.81661,
         "ars": 1.10664,
         "aud": 1.20827,
         "bch": -1.11438,
         "bdt": 0.71537,
         "bhd": 0.99048,
         "bmd": 0.81661,
         "bnb": 0.48327,
         "brl": 0.38604,
         "btc": 0.00236,
         "cad": 1.02895,
         "chf": 0.78936,
         "clp": 1.18783,
         "cny": 1.00657,
         "czk": 0.31233,
         "dkk": 0.54381,
         "dot": 3.12959,
         "eos": 1.72245,
         "eth": 2.55648,
         "eur": 0.53418,
         "gbp": 0.55049,
         "gel": 0.08072,
         "hkd": 0.85472,
         "huf": 0.53284,
         "idr": 1.15814,
         "ils": 0.86219,
         "inr": 0.81815,
         "jpy": 0.5157,
         "krw": 1.43932,
         "kwd": 0.8199,
         "lkr": 0.78073,
         "ltc": -0.97387,
         "mmk": 0.81661,
         "mxn": 0.89123,
         "myr": 0.7587,
         "ngn": 0.76627,
         "nok": 0.5579,
         "nzd": 1.22885,
         "php": 1.45754,
         "pkr": 0.73107,
         "pln": 0.46528,
         "rub": 1.24713,
         "sar": 0.83902,
         "sek": 0.64945,
         "sgd": 0.79125,
         "thb": 0.86848,
         "try": 0.85577,
         "twd": 0.89933,
         "uah": 0.71341,
         "usd": 0.81661,
         "vef": 0.81661,
         "vnd": 0.75608,
         "xag": 2.14989,
         "xau": 0.8276,
         "xdr": 0.71074,
         "xlm": 0.0897,
         "xrp": 1.38809,
         "yfi": 0.85481,
         "zar": 0.34177,
         "bits": -0.01608,
         "link": -2.43662,
         "sats": -0.01608
     },
     "total_supply": 21000000.0,
     "max_supply": 21000000.0,
     "circulating_supply": 19772606.0,
     "last_updated": "2024-10-25T04:48:52.688Z"
 },
 "community_data": {
     "facebook_likes": null,
     "twitter_followers": 6898136,
     "reddit_average_posts_48h": 0.0,
     "reddit_average_comments_48h": 0.0,
     "reddit_subscribers": 0,
     "reddit_accounts_active_48h": 0,
     "telegram_channel_user_count": null
 },
 "status_updates": [],
 "last_updated": "2024-10-25T04:48:52.688Z",
 "tickers": [
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Binance",
             "identifier": "binance",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67814.46,
         "volume": 20839.34241,
         "converted_last": {
             "btc": 0.9999861,
             "eth": 27.123917,
             "usd": 67771,
             "usd_v2": 67766
         },
         "converted_volume": {
             "btc": 20807,
             "eth": 564377,
             "usd": 1410137193,
             "usd_v2": 1410037837
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:46:32+00:00",
         "last_traded_at": "2024-10-25T04:46:32+00:00",
         "last_fetch_at": "2024-10-25T04:47:36+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.binance.com/en/trade/BTC_USDT?ref=37754157",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Bybit",
             "identifier": "bybit_spot",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67792.21,
         "volume": 17198.318073,
         "converted_last": {
             "btc": 0.99978142,
             "eth": 27.116209,
             "usd": 67757,
             "usd_v2": 67744
         },
         "converted_volume": {
             "btc": 17161,
             "eth": 465437,
             "usd": 1163009241,
             "usd_v2": 1162795560
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:45:27+00:00",
         "last_traded_at": "2024-10-25T04:45:27+00:00",
         "last_fetch_at": "2024-10-25T04:46:38+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.bybit.com/trade/spot/BTC/USDT/?affiliate_id=9763",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Ourbit",
             "identifier": "ourbit",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67789.99,
         "volume": 14604.555957,
         "converted_last": {
             "btc": 0.99992479,
             "eth": 27.050471,
             "usd": 67737,
             "usd_v2": 67742
         },
         "converted_volume": {
             "btc": 14586,
             "eth": 394576,
             "usd": 988053745,
             "usd_v2": 988126891
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:29:02+00:00",
         "last_traded_at": "2024-10-25T04:29:02+00:00",
         "last_fetch_at": "2024-10-25T04:29:02+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.ourbit.com/exchange/BTC_USDT?inviteCode=Y2VHGP",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Toobit",
             "identifier": "toobit",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67814.46,
         "volume": 12127.906461,
         "converted_last": {
             "btc": 1.00011,
             "eth": 27.125108,
             "usd": 67779,
             "usd_v2": 67766
         },
         "converted_volume": {
             "btc": 12109,
             "eth": 328415,
             "usd": 820626814,
             "usd_v2": 820476039
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:46:49+00:00",
         "last_traded_at": "2024-10-25T04:46:49+00:00",
         "last_fetch_at": "2024-10-25T04:46:49+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.toobit.com/en-US/spot/BTC_USDT?invite_code=ukqPOK",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "FameEX",
             "identifier": "fameex",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67812.0,
         "volume": 11837.692101,
         "converted_last": {
             "btc": 1.000073,
             "eth": 27.124124,
             "usd": 67776,
             "usd_v2": 67764
         },
         "converted_volume": {
             "btc": 11819,
             "eth": 320567,
             "usd": 801016859,
             "usd_v2": 800869687
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010029,
         "timestamp": "2024-10-25T04:46:42+00:00",
         "last_traded_at": "2024-10-25T04:46:42+00:00",
         "last_fetch_at": "2024-10-25T04:46:42+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.fameex.com/en-US/trade/btc-usdt/commissiondispense?code=5R35WB",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "BVOX",
             "identifier": "bitvenus_spot",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67814.45,
         "volume": 11169.66401,
         "converted_last": {
             "btc": 1.000109,
             "eth": 27.125104,
             "usd": 67779,
             "usd_v2": 67766
         },
         "converted_volume": {
             "btc": 11160,
             "eth": 302679,
             "usd": 756316828,
             "usd_v2": 756177869
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:46:49+00:00",
         "last_traded_at": "2024-10-25T04:46:49+00:00",
         "last_fetch_at": "2024-10-25T04:46:49+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.bitvenus.me/exchange/BTC/USDT?register/vh2osI",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Pionex",
             "identifier": "pionex",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67807.11,
         "volume": 10421.024169,
         "converted_last": {
             "btc": 0.99963743,
             "eth": 27.10328,
             "usd": 67758,
             "usd_v2": 67759
         },
         "converted_volume": {
             "btc": 10405,
             "eth": 282101,
             "usd": 705252739,
             "usd_v2": 705260255
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:43:55+00:00",
         "last_traded_at": "2024-10-25T04:43:55+00:00",
         "last_fetch_at": "2024-10-25T04:43:55+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.pionex.com/en/trade/BTC_USDT/Bot?r=04SCvbiCErH",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USD",
         "market": {
             "name": "Coinbase Exchange",
             "identifier": "gdax",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67746.09,
         "volume": 10146.34248091,
         "converted_last": {
             "btc": 0.99961726,
             "eth": 27.113912,
             "usd": 67746
         },
         "converted_volume": {
             "btc": 10142,
             "eth": 275107,
             "usd": 687375031
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:47:03+00:00",
         "last_traded_at": "2024-10-25T04:47:03+00:00",
         "last_fetch_at": "2024-10-25T04:47:36+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.coinbase.com/advanced-trade/spot/BTC-USD",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "Bybit",
             "identifier": "bybit_spot",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67756.82,
         "volume": 10250.574888,
         "converted_last": {
             "btc": 0.99973343,
             "eth": 27.114907,
             "usd": 67753,
             "usd_v2": 67743
         },
         "converted_volume": {
             "btc": 10226,
             "eth": 277358,
             "usd": 693046931,
             "usd_v2": 692944578
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:45:29+00:00",
         "last_traded_at": "2024-10-25T04:45:29+00:00",
         "last_fetch_at": "2024-10-25T04:46:39+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.bybit.com/trade/spot/BTC/USDC/?affiliate_id=9763",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Hotcoin",
             "identifier": "hotcoin_global",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67812.0,
         "volume": 8891.5901,
         "converted_last": {
             "btc": 1.000073,
             "eth": 27.124124,
             "usd": 67776,
             "usd_v2": 67764
         },
         "converted_volume": {
             "btc": 8892,
             "eth": 241177,
             "usd": 602639132,
             "usd_v2": 602528409
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:46:59+00:00",
         "last_traded_at": "2024-10-25T04:46:59+00:00",
         "last_fetch_at": "2024-10-25T04:46:59+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.hotcoin.com/currencyExchange/btc_usdt",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "MEXC",
             "identifier": "mxc",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67809.64,
         "volume": 8498.004064,
         "converted_last": {
             "btc": 1.000012,
             "eth": 27.121777,
             "usd": 67774,
             "usd_v2": 67761
         },
         "converted_volume": {
             "btc": 8498,
             "eth": 230481,
             "usd": 575947457,
             "usd_v2": 575837461
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:45:47+00:00",
         "last_traded_at": "2024-10-25T04:45:47+00:00",
         "last_fetch_at": "2024-10-25T04:45:47+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.mexc.com/exchange/BTC_USDT?inviteCode=1498J",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "WhiteBIT",
             "identifier": "whitebit",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67746.76,
         "volume": 8086.565767,
         "converted_last": {
             "btc": 0.99941747,
             "eth": 27.036746,
             "usd": 67702,
             "usd_v2": 67699
         },
         "converted_volume": {
             "btc": 8082,
             "eth": 218634,
             "usd": 547480539,
             "usd_v2": 547449665
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:29:32+00:00",
         "last_traded_at": "2024-10-25T04:29:32+00:00",
         "last_fetch_at": "2024-10-25T04:29:32+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://whitebit.com/trade/BTC_USDT?referral=21d28793-2c37-4ad5-ad65-ec354740a197",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "P2B",
             "identifier": "p2pb2b",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67801.99,
         "volume": 7366.71942,
         "converted_last": {
             "btc": 0.99989921,
             "eth": 27.119083,
             "usd": 67764,
             "usd_v2": 67754
         },
         "converted_volume": {
             "btc": 7366,
             "eth": 199779,
             "usd": 499199466,
             "usd_v2": 499123607
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.01059,
         "timestamp": "2024-10-25T04:46:16+00:00",
         "last_traded_at": "2024-10-25T04:46:16+00:00",
         "last_fetch_at": "2024-10-25T04:46:16+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://p2pb2b.com/",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "OKX",
             "identifier": "okex",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67793.8,
         "volume": 6481.8864878,
         "converted_last": {
             "btc": 0.99968145,
             "eth": 27.115653,
             "usd": 67750,
             "usd_v2": 67746
         },
         "converted_volume": {
             "btc": 6474,
             "eth": 175592,
             "usd": 438728905,
             "usd_v2": 438697993
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010147,
         "timestamp": "2024-10-25T04:47:36+00:00",
         "last_traded_at": "2024-10-25T04:47:36+00:00",
         "last_fetch_at": "2024-10-25T04:47:36+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.okx.com/trade-spot/btc-usdt?channelid=1902090",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "LBank",
             "identifier": "lbank",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67805.52,
         "volume": 5948.7927,
         "converted_last": {
             "btc": 0.99995126,
             "eth": 27.120494,
             "usd": 67768,
             "usd_v2": 67757
         },
         "converted_volume": {
             "btc": 5949,
             "eth": 161334,
             "usd": 403135857,
             "usd_v2": 403074596
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:46:23+00:00",
         "last_traded_at": "2024-10-25T04:46:23+00:00",
         "last_fetch_at": "2024-10-25T04:46:23+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.lbank.com/trade/btc_usdt",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "DigiFinex",
             "identifier": "digifinex",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67770.1,
         "volume": 4754.45647,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.124294,
             "usd": 67772,
             "usd_v2": 67757
         },
         "converted_volume": {
             "btc": 4754,
             "eth": 128961,
             "usd": 322219161,
             "usd_v2": 322145548
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:46:10+00:00",
         "last_traded_at": "2024-10-25T04:46:10+00:00",
         "last_fetch_at": "2024-10-25T04:47:06+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.digifinex.com/en-ww/trade/USDC/BTC",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Bitunix",
             "identifier": "bitunix",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67833.33,
         "volume": 4378.63908,
         "converted_last": {
             "btc": 1.000172,
             "eth": 27.118772,
             "usd": 67797,
             "usd_v2": 67785
         },
         "converted_volume": {
             "btc": 4379,
             "eth": 118743,
             "usd": 296856660,
             "usd_v2": 296806787
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:42:46+00:00",
         "last_traded_at": "2024-10-25T04:42:46+00:00",
         "last_fetch_at": "2024-10-25T04:42:46+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.bitunix.com/spot-trade/BTCUSDT?inviteCode=yq5pr7",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "XT.COM",
             "identifier": "xt",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67800.01,
         "volume": 4363.48745,
         "converted_last": {
             "btc": 0.9995499,
             "eth": 27.101146,
             "usd": 67753,
             "usd_v2": 67752
         },
         "converted_volume": {
             "btc": 4356,
             "eth": 118102,
             "usd": 295254647,
             "usd_v2": 295249847
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.011003,
         "timestamp": "2024-10-25T04:44:34+00:00",
         "last_traded_at": "2024-10-25T04:44:34+00:00",
         "last_fetch_at": "2024-10-25T04:44:34+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.xt.com/en/trade/btc_usdt?ref=ZHOJUG5",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USD",
         "market": {
             "name": "P2B",
             "identifier": "p2pb2b",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67800.48,
         "volume": 7162.757105,
         "converted_last": {
             "btc": 1.000435,
             "eth": 27.133623,
             "usd": 67800
         },
         "converted_volume": {
             "btc": 7166,
             "eth": 194352,
             "usd": 485638370
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.018948,
         "timestamp": "2024-10-25T04:46:16+00:00",
         "last_traded_at": "2024-10-25T04:46:16+00:00",
         "last_fetch_at": "2024-10-25T04:46:16+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://p2pb2b.com/",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Bitget",
             "identifier": "bitget",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67784.01,
         "volume": 3381.782766,
         "converted_last": {
             "btc": 0.99953709,
             "eth": 27.111737,
             "usd": 67741,
             "usd_v2": 67736
         },
         "converted_volume": {
             "btc": 3376,
             "eth": 91575,
             "usd": 228806847,
             "usd_v2": 228790725
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:47:24+00:00",
         "last_traded_at": "2024-10-25T04:47:24+00:00",
         "last_fetch_at": "2024-10-25T04:47:24+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.bitget.com/spot/BTCUSDT/?channelCode=42xn&vipCode=sq59&languageType=0",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "DigiFinex",
             "identifier": "digifinex",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67810.38,
         "volume": 6891.66939,
         "converted_last": {
             "btc": 1.000049,
             "eth": 27.125633,
             "usd": 67775,
             "usd_v2": 67762
         },
         "converted_volume": {
             "btc": 6892,
             "eth": 186941,
             "usd": 467085481,
             "usd_v2": 466994918
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.021962,
         "timestamp": "2024-10-25T04:47:02+00:00",
         "last_traded_at": "2024-10-25T04:47:02+00:00",
         "last_fetch_at": "2024-10-25T04:47:02+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.digifinex.com/en-ww/trade/USDT/BTC",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "Binance",
             "identifier": "binance",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67787.86,
         "volume": 2902.29294,
         "converted_last": {
             "btc": 1.000048,
             "eth": 27.125609,
             "usd": 67775,
             "usd_v2": 67774
         },
         "converted_volume": {
             "btc": 2897,
             "eth": 78587,
             "usd": 196355652,
             "usd_v2": 196352717
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:46:32+00:00",
         "last_traded_at": "2024-10-25T04:46:32+00:00",
         "last_fetch_at": "2024-10-25T04:47:35+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.binance.com/en/trade/BTC_USDC?ref=37754157",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "HTX",
             "identifier": "huobi",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67800.9,
         "volume": 2880.2016134081964,
         "converted_last": {
             "btc": 0.99990957,
             "eth": 27.121841,
             "usd": 67766,
             "usd_v2": 67753
         },
         "converted_volume": {
             "btc": 2875,
             "eth": 77976,
             "usd": 194829701,
             "usd_v2": 194791926
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:47:03+00:00",
         "last_traded_at": "2024-10-25T04:47:03+00:00",
         "last_fetch_at": "2024-10-25T04:47:03+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.huobi.com/en-us/exchange/btc_usdt?invite_code=d8c53",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Fastex",
             "identifier": "fastex",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67816.0,
         "volume": 3149.65770779,
         "converted_last": {
             "btc": 0.99976849,
             "eth": 27.106834,
             "usd": 67767,
             "usd_v2": 67768
         },
         "converted_volume": {
             "btc": 3149,
             "eth": 85377,
             "usd": 213443258,
             "usd_v2": 213445533
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.011917,
         "timestamp": "2024-10-25T04:43:52+00:00",
         "last_traded_at": "2024-10-25T04:43:52+00:00",
         "last_fetch_at": "2024-10-25T04:43:52+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://exchange.fastex.com/trade/btc-usdt",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "AscendEX (BitMax)",
             "identifier": "bitmax",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67803.21,
         "volume": 6909.59131,
         "converted_last": {
             "btc": 0.99994364,
             "eth": 27.120288,
             "usd": 67767,
             "usd_v2": 67755
         },
         "converted_volume": {
             "btc": 6909,
             "eth": 187390,
             "usd": 468243377,
             "usd_v2": 468159841
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.026024,
         "timestamp": "2024-10-25T04:46:27+00:00",
         "last_traded_at": "2024-10-25T04:46:27+00:00",
         "last_fetch_at": "2024-10-25T04:46:27+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://ascendex.com/en/cashtrade-spottrading/usdt/btc?inviteCode=ASDH38HE",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Biconomy.com",
             "identifier": "biconomy",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67740.0,
         "volume": 2559.6027,
         "converted_last": {
             "btc": 0.99998361,
             "eth": 27.1366,
             "usd": 67696,
             "usd_v2": 67692
         },
         "converted_volume": {
             "btc": 2558,
             "eth": 69429,
             "usd": 173199889,
             "usd_v2": 173189330
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:34:47+00:00",
         "last_traded_at": "2024-10-25T04:34:47+00:00",
         "last_fetch_at": "2024-10-25T04:34:47+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.biconomy.com/exchange/BTC_USDT",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Tapbit",
             "identifier": "tapbit",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67800.0,
         "volume": 2532.2135,
         "converted_last": {
             "btc": 0.99986986,
             "eth": 27.117922,
             "usd": 67765,
             "usd_v2": 67752
         },
         "converted_volume": {
             "btc": 2529,
             "eth": 68586,
             "usd": 171388633,
             "usd_v2": 171355901
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:45:58+00:00",
         "last_traded_at": "2024-10-25T04:45:58+00:00",
         "last_fetch_at": "2024-10-25T04:45:58+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.tapbit.com/spot/exchange/BTC_USDT",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "KRW",
         "market": {
             "name": "Bithumb",
             "identifier": "bithumb",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 93991000.0,
         "volume": 2586.29185099,
         "converted_last": {
             "btc": 0.99930172,
             "eth": 27.105353,
             "usd": 67725
         },
         "converted_volume": {
             "btc": 2584,
             "eth": 70102,
             "usd": 175155853
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.011064,
         "timestamp": "2024-10-25T04:47:31+00:00",
         "last_traded_at": "2024-10-25T04:47:31+00:00",
         "last_fetch_at": "2024-10-25T04:47:31+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.bithumb.com/trade/order/BTC_KRW",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Gate.io",
             "identifier": "gate",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67797.7,
         "volume": 1871.753901849,
         "converted_last": {
             "btc": 0.99973896,
             "eth": 27.117213,
             "usd": 67754,
             "usd_v2": 67750
         },
         "converted_volume": {
             "btc": 1869,
             "eth": 50703,
             "usd": 126685717,
             "usd_v2": 126676791
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010147,
         "timestamp": "2024-10-25T04:47:35+00:00",
         "last_traded_at": "2024-10-25T04:47:35+00:00",
         "last_fetch_at": "2024-10-25T04:47:35+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.gate.io/trade/BTC_USDT?ref=3018394",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USD",
         "market": {
             "name": "Kraken",
             "identifier": "kraken",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67769.6,
         "volume": 1666.8593397,
         "converted_last": {
             "btc": 0.99996416,
             "eth": 27.123322,
             "usd": 67770
         },
         "converted_volume": {
             "btc": 1667,
             "eth": 45211,
             "usd": 112962391
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010148,
         "timestamp": "2024-10-25T04:47:01+00:00",
         "last_traded_at": "2024-10-25T04:47:01+00:00",
         "last_fetch_at": "2024-10-25T04:47:36+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://pro.kraken.com/app/trade/BTC-USD?c/2223866/1766749/10583",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "KuCoin",
             "identifier": "kucoin",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67792.7,
         "volume": 1816.74166654,
         "converted_last": {
             "btc": 0.9997622,
             "eth": 27.115002,
             "usd": 67758,
             "usd_v2": 67745
         },
         "converted_volume": {
             "btc": 1816,
             "eth": 49261,
             "usd": 123097887,
             "usd_v2": 123074378
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010147,
         "timestamp": "2024-10-25T04:45:54+00:00",
         "last_traded_at": "2024-10-25T04:45:54+00:00",
         "last_fetch_at": "2024-10-25T04:45:54+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.kucoin.com/trade/BTC-USDT?rcode=e21sNJ",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Coinstore",
             "identifier": "coinstore",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67737.62,
         "volume": 1777.222853,
         "converted_last": {
             "btc": 0.9999453,
             "eth": 27.139786,
             "usd": 67707,
             "usd_v2": 67690
         },
         "converted_volume": {
             "btc": 1776,
             "eth": 48203,
             "usd": 120252917,
             "usd_v2": 120222600
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010148,
         "timestamp": "2024-10-25T04:35:37+00:00",
         "last_traded_at": "2024-10-25T04:35:37+00:00",
         "last_fetch_at": "2024-10-25T04:35:37+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.coinstore.com/#/spot/BTCUSDT?invitCode=zEgJkS",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "WEEX",
             "identifier": "weex",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67748.1,
         "volume": 1477.916855,
         "converted_last": {
             "btc": 0.99983433,
             "eth": 27.044612,
             "usd": 67736,
             "usd_v2": 67735
         },
         "converted_volume": {
             "btc": 1478,
             "eth": 39970,
             "usd": 100108690,
             "usd_v2": 100106034
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010148,
         "timestamp": "2024-10-25T04:28:16+00:00",
         "last_traded_at": "2024-10-25T04:28:16+00:00",
         "last_fetch_at": "2024-10-25T04:28:16+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.weex.com/trade/btc_usdc",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "Azbit",
             "identifier": "azbit",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67773.6,
         "volume": 1419.56,
         "converted_last": {
             "btc": 0.99983813,
             "eth": 27.119903,
             "usd": 67761,
             "usd_v2": 67760
         },
         "converted_volume": {
             "btc": 1417,
             "eth": 38430,
             "usd": 96020685,
             "usd_v2": 96019249
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010148,
         "timestamp": "2024-10-25T04:47:36+00:00",
         "last_traded_at": "2024-10-25T04:47:36+00:00",
         "last_fetch_at": "2024-10-25T04:47:36+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://azbit.com/exchange/BTC_USDC?referralCode=OH5QDS1?referralCode=OH5QDS1",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "Hotcoin",
             "identifier": "hotcoin_global",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67780.05,
         "volume": 1443.308,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.119679,
             "usd": 67774,
             "usd_v2": 67766
         },
         "converted_volume": {
             "btc": 1443,
             "eth": 39142,
             "usd": 97818622,
             "usd_v2": 97807923
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.011165,
         "timestamp": "2024-10-25T04:45:06+00:00",
         "last_traded_at": "2024-10-25T04:45:06+00:00",
         "last_fetch_at": "2024-10-25T04:45:06+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.hotcoin.com/currencyExchange/btc_usdc",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Dex-Trade",
             "identifier": "dextrade",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67790.0,
         "volume": 1335.17183875,
         "converted_last": {
             "btc": 1.000936,
             "eth": 27.074716,
             "usd": 67748,
             "usd_v2": 67742
         },
         "converted_volume": {
             "btc": 1336,
             "eth": 36149,
             "usd": 90455202,
             "usd_v2": 90447036
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.011446,
         "timestamp": "2024-10-25T04:27:25+00:00",
         "last_traded_at": "2024-10-25T04:27:25+00:00",
         "last_fetch_at": "2024-10-25T04:27:25+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://dex-trade.com/spot/trading/BTCUSDT?interface=classic?refcode/vy9kn8",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "BingX",
             "identifier": "bingx",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67790.64,
         "volume": 831.754193,
         "converted_last": {
             "btc": 0.99963485,
             "eth": 27.113737,
             "usd": 67738,
             "usd_v2": 67743
         },
         "converted_volume": {
             "btc": 830.196,
             "eth": 22518,
             "usd": 56256251,
             "usd_v2": 56260106
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010118,
         "timestamp": "2024-10-25T04:47:37+00:00",
         "last_traded_at": "2024-10-25T04:47:37+00:00",
         "last_fetch_at": "2024-10-25T04:47:37+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://bingx.com/en-us/spot/BTCUSDT?ch=cgk_organic",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "OKX",
             "identifier": "okex",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67763.7,
         "volume": 837.92082768,
         "converted_last": {
             "btc": 0.99969207,
             "eth": 27.115941,
             "usd": 67751,
             "usd_v2": 67750
         },
         "converted_volume": {
             "btc": 838.007,
             "eth": 22730,
             "usd": 56793430,
             "usd_v2": 56792581
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010148,
         "timestamp": "2024-10-25T04:47:36+00:00",
         "last_traded_at": "2024-10-25T04:47:36+00:00",
         "last_fetch_at": "2024-10-25T04:47:36+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.okx.com/trade-spot/btc-usdc?channelid=1902090",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "SOL",
         "target": "BTC",
         "market": {
             "name": "Binance",
             "identifier": "binance",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 0.0025579,
         "volume": 406684.865,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.124294,
             "usd": 67772
         },
         "converted_volume": {
             "btc": 1053,
             "eth": 28554,
             "usd": 71345116
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.013909,
         "timestamp": "2024-10-25T04:46:32+00:00",
         "last_traded_at": "2024-10-25T04:46:32+00:00",
         "last_fetch_at": "2024-10-25T04:47:18+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.binance.com/en/trade/SOL_BTC?ref=37754157",
         "token_info_url": null,
         "coin_id": "solana",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "Tapbit",
             "identifier": "tapbit",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67780.21,
         "volume": 527.971,
         "converted_last": {
             "btc": 0.99981921,
             "eth": 27.107133,
             "usd": 67760,
             "usd_v2": 67767
         },
         "converted_volume": {
             "btc": 526.936,
             "eth": 14286,
             "usd": 35711531,
             "usd_v2": 35715170
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:44:58+00:00",
         "last_traded_at": "2024-10-25T04:44:58+00:00",
         "last_fetch_at": "2024-10-25T04:44:58+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.tapbit.com/spot/exchange/BTC_USDC",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "EUR",
         "market": {
             "name": "Kraken",
             "identifier": "kraken",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 62605.6,
         "volume": 550.83887582,
         "converted_last": {
             "btc": 0.99959588,
             "eth": 27.113332,
             "usd": 67745
         },
         "converted_volume": {
             "btc": 550.616,
             "eth": 14935,
             "usd": 37316382
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.012076,
         "timestamp": "2024-10-25T04:47:01+00:00",
         "last_traded_at": "2024-10-25T04:47:01+00:00",
         "last_fetch_at": "2024-10-25T04:47:36+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://pro.kraken.com/app/trade/BTC-EUR?c/2223866/1766749/10583",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "EUR",
         "market": {
             "name": "Bitvavo",
             "identifier": "bitvavo",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 62632.0,
         "volume": 647.12550333,
         "converted_last": {
             "btc": 0.99999401,
             "eth": 27.115346,
             "usd": 67776
         },
         "converted_volume": {
             "btc": 647.122,
             "eth": 17547,
             "usd": 43859717
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.012779,
         "timestamp": "2024-10-25T04:40:46+00:00",
         "last_traded_at": "2024-10-25T04:40:46+00:00",
         "last_fetch_at": "2024-10-25T04:40:46+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://account.bitvavo.com/markets/BTC-EUR",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Slex",
             "identifier": "slex",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67815.9,
         "volume": 555.96196,
         "converted_last": {
             "btc": 1.000104,
             "eth": 27.124281,
             "usd": 67781,
             "usd_v2": 67768
         },
         "converted_volume": {
             "btc": 555.172,
             "eth": 15057,
             "usd": 37626045,
             "usd_v2": 37618859
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.011622,
         "timestamp": "2024-10-25T04:45:44+00:00",
         "last_traded_at": "2024-10-25T04:45:44+00:00",
         "last_fetch_at": "2024-10-25T04:45:44+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://slex.io/trade/btcusdt",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USD",
         "market": {
             "name": "Gemini",
             "identifier": "gemini",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67747.58,
         "volume": 765.14302424,
         "converted_last": {
             "btc": 0.99963925,
             "eth": 27.114509,
             "usd": 67748
         },
         "converted_volume": {
             "btc": 764.867,
             "eth": 20746,
             "usd": 51836588
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.016507,
         "timestamp": "2024-10-25T04:47:02+00:00",
         "last_traded_at": "2024-10-25T04:47:02+00:00",
         "last_fetch_at": "2024-10-25T04:47:36+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://exchange.gemini.com/trade/BTCUSD?referral=coingecko",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "OrangeX",
             "identifier": "orangex",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67806.556,
         "volume": 9165.35208,
         "converted_last": {
             "btc": 0.99999299,
             "eth": 27.121947,
             "usd": 67771,
             "usd_v2": 67758
         },
         "converted_volume": {
             "btc": 9156,
             "eth": 248324,
             "usd": 620499097,
             "usd_v2": 620385092
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010113,
         "timestamp": "2024-10-25T04:46:59+00:00",
         "last_traded_at": "2024-10-25T04:46:59+00:00",
         "last_fetch_at": "2024-10-25T04:46:59+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.orangex.com/spot/BTC-USDT-SPOT",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "LBank",
             "identifier": "lbank",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67713.32,
         "volume": 462.941,
         "converted_last": {
             "btc": 1.000012,
             "eth": 27.137358,
             "usd": 67698,
             "usd_v2": 67700
         },
         "converted_volume": {
             "btc": 462.946,
             "eth": 12563,
             "usd": 31340145,
             "usd_v2": 31341003
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010251,
         "timestamp": "2024-10-25T04:34:37+00:00",
         "last_traded_at": "2024-10-25T04:34:37+00:00",
         "last_fetch_at": "2024-10-25T04:34:37+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.lbank.com/trade/btc_usdc",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Azbit",
             "identifier": "azbit",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67794.5,
         "volume": 320.08504224,
         "converted_last": {
             "btc": 0.99969177,
             "eth": 27.115933,
             "usd": 67751,
             "usd_v2": 67746
         },
         "converted_volume": {
             "btc": 319.475,
             "eth": 8666,
             "usd": 21651478,
             "usd_v2": 21649952
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010148,
         "timestamp": "2024-10-25T04:47:35+00:00",
         "last_traded_at": "2024-10-25T04:47:35+00:00",
         "last_fetch_at": "2024-10-25T04:47:35+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://azbit.com/exchange/BTC_USDT?referralCode=OH5QDS1?referralCode=OH5QDS1",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "HashKey Global",
             "identifier": "hashkey-global",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67823.05,
         "volume": 348.23972,
         "converted_last": {
             "btc": 1.000191,
             "eth": 27.126619,
             "usd": 67787,
             "usd_v2": 67775
         },
         "converted_volume": {
             "btc": 347.896,
             "eth": 9435,
             "usd": 23578185,
             "usd_v2": 23574136
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:45:45+00:00",
         "last_traded_at": "2024-10-25T04:45:45+00:00",
         "last_fetch_at": "2024-10-25T04:45:45+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://global.hashkey.com/en-US/spot/BTC_USDT",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "PointPay",
             "identifier": "pointpay",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67809.64,
         "volume": 366.33988386,
         "converted_last": {
             "btc": 1.000012,
             "eth": 27.122142,
             "usd": 67772,
             "usd_v2": 67761
         },
         "converted_volume": {
             "btc": 365.829,
             "eth": 9922,
             "usd": 24792591,
             "usd_v2": 24788824
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.014,
         "timestamp": "2024-10-25T04:46:10+00:00",
         "last_traded_at": "2024-10-25T04:46:10+00:00",
         "last_fetch_at": "2024-10-25T04:46:10+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://exchange.pointpay.io/trade-classic/BTC_USDTreferral/40d2c818-a4e9-4834-bcda-c4f11a1b243d",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "Biconomy.com",
             "identifier": "biconomy",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67713.0,
         "volume": 268.2955,
         "converted_last": {
             "btc": 1.000007,
             "eth": 27.13723,
             "usd": 67698,
             "usd_v2": 67699
         },
         "converted_volume": {
             "btc": 268.113,
             "eth": 7276,
             "usd": 18150476,
             "usd_v2": 18150973
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.011447,
         "timestamp": "2024-10-25T04:34:47+00:00",
         "last_traded_at": "2024-10-25T04:34:47+00:00",
         "last_fetch_at": "2024-10-25T04:34:47+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.biconomy.com/exchange/BTC_USDC",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Kraken",
             "identifier": "kraken",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67810.9,
         "volume": 231.03034961,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.124294,
             "usd": 67772,
             "usd_v2": 67763
         },
         "converted_volume": {
             "btc": 231.03,
             "eth": 6267,
             "usd": 15657396,
             "usd_v2": 15655253
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010147,
         "timestamp": "2024-10-25T04:47:01+00:00",
         "last_traded_at": "2024-10-25T04:47:01+00:00",
         "last_fetch_at": "2024-10-25T04:47:36+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://pro.kraken.com/app/trade/BTC-USDT?c/2223866/1766749/10583",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Coinbase Exchange",
             "identifier": "gdax",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67800.82,
         "volume": 374.95006895,
         "converted_last": {
             "btc": 0.99978497,
             "eth": 27.118461,
             "usd": 67757,
             "usd_v2": 67753
         },
         "converted_volume": {
             "btc": 374.869,
             "eth": 10168,
             "usd": 25405663,
             "usd_v2": 25403873
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.015101,
         "timestamp": "2024-10-25T04:47:01+00:00",
         "last_traded_at": "2024-10-25T04:47:01+00:00",
         "last_fetch_at": "2024-10-25T04:47:36+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.coinbase.com/advanced-trade/spot/BTC-USDT",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USD",
         "market": {
             "name": "HashKey Exchange",
             "identifier": "hashkey_exchange",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67762.33,
         "volume": 218.23063,
         "converted_last": {
             "btc": 0.99999587,
             "eth": 27.123529,
             "usd": 67762
         },
         "converted_volume": {
             "btc": 217.904,
             "eth": 5910,
             "usd": 14765770
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:47:42+00:00",
         "last_traded_at": "2024-10-25T04:47:42+00:00",
         "last_fetch_at": "2024-10-25T04:47:42+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://pro.hashkey.com/en-US/spot/BTC_USD",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Phemex",
             "identifier": "phemex",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67812.97,
         "volume": 194.647155,
         "converted_last": {
             "btc": 1.000762,
             "eth": 27.150627,
             "usd": 67771,
             "usd_v2": 67765
         },
         "converted_volume": {
             "btc": 194.796,
             "eth": 5285,
             "usd": 13191407,
             "usd_v2": 13190230
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:37:29+00:00",
         "last_traded_at": "2024-10-25T04:37:29+00:00",
         "last_fetch_at": "2024-10-25T04:37:29+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://phemex.com/spot/trade/BTCUSDT?referralCode=FLKPL",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "ETH",
         "target": "BTC",
         "market": {
             "name": "Bybit",
             "identifier": "bybit_spot",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 0.036879,
         "volume": 6779.61298,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.122137,
             "usd": 67771
         },
         "converted_volume": {
             "btc": 253.524,
             "eth": 6876,
             "usd": 17181679
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.012711,
         "timestamp": "2024-10-25T04:45:27+00:00",
         "last_traded_at": "2024-10-25T04:45:27+00:00",
         "last_fetch_at": "2024-10-25T04:46:37+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.bybit.com/trade/spot/ETH/BTC/?affiliate_id=9763",
         "token_info_url": null,
         "coin_id": "ethereum",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "WOO X",
             "identifier": "wootrade",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67816.98,
         "volume": 134.917774,
         "converted_last": {
             "btc": 0.99980008,
             "eth": 27.107929,
             "usd": 67770,
             "usd_v2": 67769
         },
         "converted_volume": {
             "btc": 134.891,
             "eth": 3657,
             "usd": 9143368,
             "usd_v2": 9143220
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:44:33+00:00",
         "last_traded_at": "2024-10-25T04:44:33+00:00",
         "last_fetch_at": "2024-10-25T04:44:33+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://woox.io/en/trade/BTC_USDT",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "EUR",
         "market": {
             "name": "Coinbase Exchange",
             "identifier": "gdax",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 62618.03,
         "volume": 323.73841109,
         "converted_last": {
             "btc": 0.99979434,
             "eth": 27.118715,
             "usd": 67758
         },
         "converted_volume": {
             "btc": 323.672,
             "eth": 8779,
             "usd": 21935897
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.017966,
         "timestamp": "2024-10-25T04:47:03+00:00",
         "last_traded_at": "2024-10-25T04:47:03+00:00",
         "last_fetch_at": "2024-10-25T04:47:35+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.coinbase.com/advanced-trade/spot/BTC-EUR",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "CoinEx",
             "identifier": "coinex",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67787.97,
         "volume": 534.92592178,
         "converted_last": {
             "btc": 0.99959548,
             "eth": 27.113321,
             "usd": 67745,
             "usd_v2": 67740
         },
         "converted_volume": {
             "btc": 534.249,
             "eth": 14491,
             "usd": 36207120,
             "usd_v2": 36204569
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.02754,
         "timestamp": "2024-10-25T04:47:28+00:00",
         "last_traded_at": "2024-10-25T04:47:28+00:00",
         "last_fetch_at": "2024-10-25T04:47:28+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.coinex.com/trading?currency=USDT&dest=BTC#limitrefer_code=mdw67",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Trubit",
             "identifier": "trubit",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67793.0,
         "volume": 187.46215,
         "converted_last": {
             "btc": 0.99979307,
             "eth": 27.116525,
             "usd": 67757,
             "usd_v2": 67745
         },
         "converted_volume": {
             "btc": 187.166,
             "eth": 5076,
             "usd": 12684477,
             "usd_v2": 12682146
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010162,
         "timestamp": "2024-10-25T04:46:58+00:00",
         "last_traded_at": "2024-10-25T04:46:58+00:00",
         "last_fetch_at": "2024-10-25T04:46:58+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.trubit.com/pro/crypto-spot-trading/BTC/USDT",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "Kraken",
             "identifier": "kraken",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67798.68,
         "volume": 164.3030221,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.124294,
             "usd": 67772,
             "usd_v2": 67785
         },
         "converted_volume": {
             "btc": 164.303,
             "eth": 4457,
             "usd": 11135149,
             "usd_v2": 11137300
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:46:32+00:00",
         "last_traded_at": "2024-10-25T04:46:32+00:00",
         "last_fetch_at": "2024-10-25T04:47:35+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://pro.kraken.com/app/trade/BTC-USDC?c/2223866/1766749/10583",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "C-Patex",
             "identifier": "c_patex",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67812.91803,
         "volume": 480.7402679,
         "converted_last": {
             "btc": 1.00006,
             "eth": 27.123454,
             "usd": 67775,
             "usd_v2": 67765
         },
         "converted_volume": {
             "btc": 480.769,
             "eth": 13039,
             "usd": 32582205,
             "usd_v2": 32577254
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.031938,
         "timestamp": "2024-10-25T04:46:17+00:00",
         "last_traded_at": "2024-10-25T04:46:17+00:00",
         "last_fetch_at": "2024-10-25T04:46:17+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://c-patex.com/exchange/BTC/USDT?referral/5ebe4bf1-ca5f-4b0b-8760-e696e9bca870",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "PointPay",
             "identifier": "pointpay",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67682.54,
         "volume": 183.83467314,
         "converted_last": {
             "btc": 0.99957934,
             "eth": 27.120269,
             "usd": 67670,
             "usd_v2": 67669
         },
         "converted_volume": {
             "btc": 183.722,
             "eth": 4985,
             "usd": 12437748,
             "usd_v2": 12437538
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.014,
         "timestamp": "2024-10-25T04:33:49+00:00",
         "last_traded_at": "2024-10-25T04:33:49+00:00",
         "last_fetch_at": "2024-10-25T04:33:49+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://exchange.pointpay.io/trade-classic/BTC_USDCreferral/40d2c818-a4e9-4834-bcda-c4f11a1b243d",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "EUR",
         "market": {
             "name": "OKX",
             "identifier": "okex",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 62622.2,
         "volume": 116.71837791,
         "converted_last": {
             "btc": 0.99987641,
             "eth": 27.118464,
             "usd": 67763
         },
         "converted_volume": {
             "btc": 116.594,
             "eth": 3162,
             "usd": 7901663
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010319,
         "timestamp": "2024-10-25T04:46:24+00:00",
         "last_traded_at": "2024-10-25T04:46:24+00:00",
         "last_fetch_at": "2024-10-25T04:46:24+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.okx.com/trade-spot/btc-eur?channelid=1902090",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "ETH",
         "target": "BTC",
         "market": {
             "name": "Bitfinex",
             "identifier": "bitfinex",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 0.03688,
         "volume": 7192.57191971,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.124294,
             "usd": 67772
         },
         "converted_volume": {
             "btc": 265.262,
             "eth": 7195,
             "usd": 17977347
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.027108,
         "timestamp": "2024-10-25T04:47:10+00:00",
         "last_traded_at": "2024-10-25T04:47:10+00:00",
         "last_fetch_at": "2024-10-25T04:47:10+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://trading.bitfinex.com/t/ETH:BTC?type=exchange?refcode=6dwJVwfb",
         "token_info_url": null,
         "coin_id": "ethereum",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Kine Protocol (Spot)",
             "identifier": "kine-protocol-spot",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67716.0,
         "volume": 2501.6627,
         "converted_last": {
             "btc": 0.99896369,
             "eth": 27.03859,
             "usd": 67670,
             "usd_v2": 67668
         },
         "converted_volume": {
             "btc": 2498,
             "eth": 67615,
             "usd": 169220524,
             "usd_v2": 169216256
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.221262,
         "timestamp": "2024-10-25T04:29:59+00:00",
         "last_traded_at": "2024-10-25T04:29:59+00:00",
         "last_fetch_at": "2024-10-25T04:29:59+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://exchange.kine.io/spot?currency=BTCUSDT",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USD",
         "market": {
             "name": "itBit",
             "identifier": "itbit",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67752.25,
         "volume": 102.83934972,
         "converted_last": {
             "btc": 0.99996319,
             "eth": 27.120158,
             "usd": 67752
         },
         "converted_volume": {
             "btc": 102.836,
             "eth": 2789,
             "usd": 6967597
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010369,
         "timestamp": "2024-10-25T04:39:12+00:00",
         "last_traded_at": "2024-10-25T04:39:12+00:00",
         "last_fetch_at": "2024-10-25T04:39:12+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.itbit.com/",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "ETH",
         "target": "BTC",
         "market": {
             "name": "ProBit Global",
             "identifier": "probit",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 0.03689,
         "volume": 64015.454,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.113349,
             "usd": 67783
         },
         "converted_volume": {
             "btc": 2362,
             "eth": 64029,
             "usd": 160072735
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.241029,
         "timestamp": "2024-10-25T04:44:20+00:00",
         "last_traded_at": "2024-10-25T04:44:20+00:00",
         "last_fetch_at": "2024-10-25T04:44:20+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.probit.com/app/exchange/ETH-BTC",
         "token_info_url": null,
         "coin_id": "ethereum",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "ETH",
         "target": "BTC",
         "market": {
             "name": "Azbit",
             "identifier": "azbit",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 0.03688,
         "volume": 4648.56,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.124294,
             "usd": 67772
         },
         "converted_volume": {
             "btc": 173.804,
             "eth": 4714,
             "usd": 11779052
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.027122,
         "timestamp": "2024-10-25T04:47:35+00:00",
         "last_traded_at": "2024-10-25T04:47:35+00:00",
         "last_fetch_at": "2024-10-25T04:47:35+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://azbit.com/exchange/ETH_BTC?referralCode=OH5QDS1?referralCode=OH5QDS1",
         "token_info_url": null,
         "coin_id": "ethereum",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "SOL",
         "target": "BTC",
         "market": {
             "name": "WhiteBIT",
             "identifier": "whitebit",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 0.00256002,
         "volume": 56517.77,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.066639,
             "usd": 67740
         },
         "converted_volume": {
             "btc": 144.687,
             "eth": 3916,
             "usd": 9801047
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.017415,
         "timestamp": "2024-10-25T04:29:33+00:00",
         "last_traded_at": "2024-10-25T04:29:33+00:00",
         "last_fetch_at": "2024-10-25T04:29:33+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://whitebit.com/trade/SOL_BTC?referral=21d28793-2c37-4ad5-ad65-ec354740a197",
         "token_info_url": null,
         "coin_id": "solana",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "EXMO",
             "identifier": "exmo",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67803.97,
         "volume": 69.96308739,
         "converted_last": {
             "btc": 0.99992841,
             "eth": 27.117726,
             "usd": 67769,
             "usd_v2": 67756
         },
         "converted_volume": {
             "btc": 69.958,
             "eth": 1897,
             "usd": 4741330,
             "usd_v2": 4740407
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010015,
         "timestamp": "2024-10-25T04:45:26+00:00",
         "last_traded_at": "2024-10-25T04:45:26+00:00",
         "last_fetch_at": "2024-10-25T04:45:26+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://exmo.com/en/trade/BTC_USDT?ref=1640225",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "SOL",
         "target": "XBT",
         "market": {
             "name": "Kraken",
             "identifier": "kraken",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 0.0025576,
         "volume": 55800.93320116,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.121451,
             "usd": 67774
         },
         "converted_volume": {
             "btc": 142.716,
             "eth": 3871,
             "usd": 9672412
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.017819,
         "timestamp": "2024-10-25T04:43:58+00:00",
         "last_traded_at": "2024-10-25T04:43:58+00:00",
         "last_fetch_at": "2024-10-25T04:45:36+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://pro.kraken.com/app/trade/SOL-XBT?c/2223866/1766749/10583",
         "token_info_url": null,
         "coin_id": "solana",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "WhiteBIT",
             "identifier": "whitebit",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67772.46,
         "volume": 158.829556,
         "converted_last": {
             "btc": 0.99976391,
             "eth": 27.110436,
             "usd": 67765,
             "usd_v2": 67759
         },
         "converted_volume": {
             "btc": 158.792,
             "eth": 4306,
             "usd": 10763010,
             "usd_v2": 10762117
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.021258,
         "timestamp": "2024-10-25T04:42:33+00:00",
         "last_traded_at": "2024-10-25T04:42:33+00:00",
         "last_fetch_at": "2024-10-25T04:42:33+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://whitebit.com/trade/BTC_USDC?referral=21d28793-2c37-4ad5-ad65-ec354740a197",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "ETH",
         "target": "BTC",
         "market": {
             "name": "OKX",
             "identifier": "okex",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 0.03688,
         "volume": 5230.670742,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.121816,
             "usd": 67771
         },
         "converted_volume": {
             "btc": 195.186,
             "eth": 5294,
             "usd": 13227920
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.027115,
         "timestamp": "2024-10-25T04:46:20+00:00",
         "last_traded_at": "2024-10-25T04:46:20+00:00",
         "last_fetch_at": "2024-10-25T04:46:20+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.okx.com/trade-spot/eth-btc?channelid=1902090",
         "token_info_url": null,
         "coin_id": "ethereum",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "CHF",
         "market": {
             "name": "Kraken",
             "identifier": "kraken",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 58645.1,
         "volume": 56.13940611,
         "converted_last": {
             "btc": 0.99954558,
             "eth": 27.109127,
             "usd": 67743
         },
         "converted_volume": {
             "btc": 56.114,
             "eth": 1522,
             "usd": 3803042
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.01017,
         "timestamp": "2024-10-25T04:43:55+00:00",
         "last_traded_at": "2024-10-25T04:43:55+00:00",
         "last_fetch_at": "2024-10-25T04:45:34+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://pro.kraken.com/app/trade/BTC-CHF?c/2223866/1766749/10583",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "GBP",
         "market": {
             "name": "Coinbase Exchange",
             "identifier": "gdax",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 52316.9,
         "volume": 129.432304,
         "converted_last": {
             "btc": 1.000365,
             "eth": 27.122995,
             "usd": 67808
         },
         "converted_volume": {
             "btc": 129.479,
             "eth": 3511,
             "usd": 8776485
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.026177,
         "timestamp": "2024-10-25T04:43:44+00:00",
         "last_traded_at": "2024-10-25T04:43:44+00:00",
         "last_fetch_at": "2024-10-25T04:43:44+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.coinbase.com/advanced-trade/spot/BTC-GBP",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "ETH",
         "target": "BTC",
         "market": {
             "name": "Coinbase Exchange",
             "identifier": "gdax",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 0.03686,
         "volume": 3106.51338739,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.112034,
             "usd": 67772
         },
         "converted_volume": {
             "btc": 114.506,
             "eth": 3104,
             "usd": 7760307
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.027115,
         "timestamp": "2024-10-25T04:39:52+00:00",
         "last_traded_at": "2024-10-25T04:39:52+00:00",
         "last_fetch_at": "2024-10-25T04:44:52+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.coinbase.com/advanced-trade/spot/ETH-BTC",
         "token_info_url": null,
         "coin_id": "ethereum",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "Slex",
             "identifier": "slex",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67799.96,
         "volume": 51.96134,
         "converted_last": {
             "btc": 1.000086,
             "eth": 27.115446,
             "usd": 67789,
             "usd_v2": 67786
         },
         "converted_volume": {
             "btc": 51.87,
             "eth": 1406,
             "usd": 3515877,
             "usd_v2": 3515760
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.015046,
         "timestamp": "2024-10-25T04:43:58+00:00",
         "last_traded_at": "2024-10-25T04:43:58+00:00",
         "last_fetch_at": "2024-10-25T04:43:58+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://slex.io/trade/btcusdc",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "DOGE",
         "target": "BTC",
         "market": {
             "name": "WhiteBIT",
             "identifier": "whitebit",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 2.0536e-06,
         "volume": 23460933.0,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.121451,
             "usd": 67774
         },
         "converted_volume": {
             "btc": 48.179372,
             "eth": 1307,
             "usd": 3265291
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.014574,
         "timestamp": "2024-10-25T04:45:58+00:00",
         "last_traded_at": "2024-10-25T04:45:58+00:00",
         "last_fetch_at": "2024-10-25T04:45:58+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://whitebit.com/trade/DOGE_BTC?referral=21d28793-2c37-4ad5-ad65-ec354740a197",
         "token_info_url": null,
         "coin_id": "dogecoin",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "GBP",
         "market": {
             "name": "Kraken",
             "identifier": "kraken",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 52285.0,
         "volume": 83.67786609,
         "converted_last": {
             "btc": 0.99986691,
             "eth": 27.117842,
             "usd": 67765
         },
         "converted_volume": {
             "btc": 83.667,
             "eth": 2269,
             "usd": 5670397
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.024666,
         "timestamp": "2024-10-25T04:41:25+00:00",
         "last_traded_at": "2024-10-25T04:41:25+00:00",
         "last_fetch_at": "2024-10-25T04:45:34+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://pro.kraken.com/app/trade/BTC-GBP?c/2223866/1766749/10583",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "BYDFi",
             "identifier": "bydfi",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67799.99,
         "volume": 35.3901,
         "converted_last": {
             "btc": 1.00017,
             "eth": 27.11872,
             "usd": 67796,
             "usd_v2": 67786
         },
         "converted_volume": {
             "btc": 35.396117,
             "eth": 959.734,
             "usd": 2399322,
             "usd_v2": 2398969
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.011682,
         "timestamp": "2024-10-25T04:42:42+00:00",
         "last_traded_at": "2024-10-25T04:42:42+00:00",
         "last_fetch_at": "2024-10-25T04:42:42+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.bydfi.com/en/spot/btc_usdc?ru=rvD58J",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "KRW",
         "market": {
             "name": "Coinone",
             "identifier": "coinone",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 94000000.0,
         "volume": 97.76084679,
         "converted_last": {
             "btc": 0.99939741,
             "eth": 27.107949,
             "usd": 67731
         },
         "converted_volume": {
             "btc": 97.702,
             "eth": 2650,
             "usd": 6621459
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.031908,
         "timestamp": "2024-10-25T04:47:26+00:00",
         "last_traded_at": "2024-10-25T04:47:26+00:00",
         "last_fetch_at": "2024-10-25T04:47:26+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://coinone.co.kr/exchange/trade/btc/krw",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "BitDelta",
             "identifier": "bitdelta",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67793.0,
         "volume": 35.90598,
         "converted_last": {
             "btc": 0.99966965,
             "eth": 27.114681,
             "usd": 67740,
             "usd_v2": 67745
         },
         "converted_volume": {
             "btc": 35.84299,
             "eth": 972.192,
             "usd": 2428815,
             "usd_v2": 2428981
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.011765,
         "timestamp": "2024-10-25T04:47:44+00:00",
         "last_traded_at": "2024-10-25T04:47:44+00:00",
         "last_fetch_at": "2024-10-25T04:47:44+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://bitdelta.com/en/trade/BTC_USDT",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "XT.COM",
             "identifier": "xt",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67770.54,
         "volume": 28.98629,
         "converted_last": {
             "btc": 0.99967657,
             "eth": 27.10458,
             "usd": 67762,
             "usd_v2": 67757
         },
         "converted_volume": {
             "btc": 28.933014,
             "eth": 784.471,
             "usd": 1961180,
             "usd_v2": 1961048
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010003,
         "timestamp": "2024-10-25T04:44:36+00:00",
         "last_traded_at": "2024-10-25T04:44:36+00:00",
         "last_fetch_at": "2024-10-25T04:44:36+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.xt.com/en/trade/btc_usdc?ref=ZHOJUG5",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "DAI",
         "market": {
             "name": "LBank",
             "identifier": "lbank",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67762.87,
         "volume": 29.5297,
         "converted_last": {
             "btc": 0.99959716,
             "eth": 27.104585,
             "usd": 67749,
             "usd_v2": 67749
         },
         "converted_volume": {
             "btc": 29.517804,
             "eth": 800.39,
             "usd": 2000617,
             "usd_v2": 2000617
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010891,
         "timestamp": "2024-10-25T04:40:43+00:00",
         "last_traded_at": "2024-10-25T04:40:43+00:00",
         "last_fetch_at": "2024-10-25T04:40:43+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.lbank.com/trade/btc_dai",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "dai"
     },
     {
         "base": "SOL",
         "target": "BTC",
         "market": {
             "name": "OKX",
             "identifier": "okex",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 0.0025573,
         "volume": 18142.9591,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.121816,
             "usd": 67771
         },
         "converted_volume": {
             "btc": 47.023713,
             "eth": 1275,
             "usd": 3186843
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.023453,
         "timestamp": "2024-10-25T04:46:20+00:00",
         "last_traded_at": "2024-10-25T04:46:20+00:00",
         "last_fetch_at": "2024-10-25T04:46:20+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.okx.com/trade-spot/sol-btc?channelid=1902090",
         "token_info_url": null,
         "coin_id": "solana",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "ETH",
         "target": "BTC",
         "market": {
             "name": "BigONE",
             "identifier": "bigone",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 0.036828,
         "volume": 22620.9908,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.119667,
             "usd": 67774
         },
         "converted_volume": {
             "btc": 833.086,
             "eth": 22593,
             "usd": 56461458
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.392762,
         "timestamp": "2024-10-25T04:45:18+00:00",
         "last_traded_at": "2024-10-25T04:45:18+00:00",
         "last_fetch_at": "2024-10-25T04:45:18+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://big.one/trade/ETH-BTC?code=9K8PX8Y5",
         "token_info_url": null,
         "coin_id": "ethereum",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "HTX",
             "identifier": "huobi",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67759.77,
         "volume": 79.41275053455195,
         "converted_last": {
             "btc": 0.99977696,
             "eth": 27.118244,
             "usd": 67757,
             "usd_v2": 67746
         },
         "converted_volume": {
             "btc": 79.21,
             "eth": 2149,
             "usd": 5368255,
             "usd_v2": 5367407
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.048799,
         "timestamp": "2024-10-25T04:47:07+00:00",
         "last_traded_at": "2024-10-25T04:47:07+00:00",
         "last_fetch_at": "2024-10-25T04:47:07+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.huobi.com/en-us/exchange/btc_usdc?invite_code=d8c53",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "Deribit Spot",
             "identifier": "deribit_spot",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67774.0,
         "volume": 64.0769,
         "converted_last": {
             "btc": 1.000443,
             "eth": 27.065943,
             "usd": 67709,
             "usd_v2": 67687
         },
         "converted_volume": {
             "btc": 64.102,
             "eth": 1734,
             "usd": 4338360,
             "usd_v2": 4336932
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.047198,
         "timestamp": "2024-10-25T04:25:52+00:00",
         "last_traded_at": "2024-10-25T04:25:52+00:00",
         "last_fetch_at": "2024-10-25T04:25:52+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.deribit.com/spot/BTC_USDT?reg=10139.5202",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "BTC",
         "target": "AUD",
         "market": {
             "name": "BTCMarkets",
             "identifier": "btcmarkets",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 102411.72,
         "volume": 27.89943005,
         "converted_last": {
             "btc": 0.99896115,
             "eth": 26.975764,
             "usd": 67809
         },
         "converted_volume": {
             "btc": 27.870447,
             "eth": 752.608,
             "usd": 1891842
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.023522,
         "timestamp": "2024-10-25T04:18:16+00:00",
         "last_traded_at": "2024-10-25T04:18:16+00:00",
         "last_fetch_at": "2024-10-25T04:18:16+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.btcmarkets.net/",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDT",
         "market": {
             "name": "BitStorage",
             "identifier": "bitstorage",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 67833.32,
         "volume": 105.68048,
         "converted_last": {
             "btc": 1.000172,
             "eth": 27.121497,
             "usd": 67792,
             "usd_v2": 67785
         },
         "converted_volume": {
             "btc": 105.699,
             "eth": 2866,
             "usd": 7164310,
             "usd_v2": 7163568
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.077349,
         "timestamp": "2024-10-25T04:42:19+00:00",
         "last_traded_at": "2024-10-25T04:42:19+00:00",
         "last_fetch_at": "2024-10-25T04:42:19+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://bitstorage.finance/market/BTC-USDT",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "tether"
     },
     {
         "base": "RUNE",
         "target": "BTC",
         "market": {
             "name": "Binance",
             "identifier": "binance",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 7.759e-05,
         "volume": 640628.1,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.077566,
             "usd": 67735
         },
         "converted_volume": {
             "btc": 50.223,
             "eth": 1360,
             "usd": 3401853
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.03861,
         "timestamp": "2024-10-25T04:30:21+00:00",
         "last_traded_at": "2024-10-25T04:30:21+00:00",
         "last_fetch_at": "2024-10-25T04:30:21+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.binance.com/en/trade/RUNE_BTC?ref=37754157",
         "token_info_url": null,
         "coin_id": "thorchain",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "KRW",
         "market": {
             "name": "Korbit",
             "identifier": "korbit",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 94010000.0,
         "volume": 39.3675,
         "converted_last": {
             "btc": 0.99951921,
             "eth": 27.108776,
             "usd": 67738
         },
         "converted_volume": {
             "btc": 39.214323,
             "eth": 1064,
             "usd": 2657593
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.031901,
         "timestamp": "2024-10-25T04:46:18+00:00",
         "last_traded_at": "2024-10-25T04:46:18+00:00",
         "last_fetch_at": "2024-10-25T04:46:18+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://lightning.korbit.co.kr/trade/?market=btc-krw",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "Dex-Trade",
             "identifier": "dextrade",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67756.0,
         "volume": 98.35207,
         "converted_last": {
             "btc": 0.99957848,
             "eth": 27.11286,
             "usd": 67743,
             "usd_v2": 67742
         },
         "converted_volume": {
             "btc": 98.311,
             "eth": 2667,
             "usd": 6662710,
             "usd_v2": 6662610
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.081545,
         "timestamp": "2024-10-25T04:47:21+00:00",
         "last_traded_at": "2024-10-25T04:47:21+00:00",
         "last_fetch_at": "2024-10-25T04:47:21+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://dex-trade.com/spot/trading/BTCUSDC?interface=classic?refcode/vy9kn8",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     },
     {
         "base": "XMR",
         "target": "BTC",
         "market": {
             "name": "TradeOgre",
             "identifier": "trade_ogre",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 0.00234824,
         "volume": 5129.262311348073,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.14108,
             "usd": 67712
         },
         "converted_volume": {
             "btc": 12.044739,
             "eth": 326.907,
             "usd": 815570
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.010426,
         "timestamp": "2024-10-25T04:36:10+00:00",
         "last_traded_at": "2024-10-25T04:36:10+00:00",
         "last_fetch_at": "2024-10-25T04:36:10+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://tradeogre.com/exchange/XMR-BTC",
         "token_info_url": null,
         "coin_id": "monero",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "ETH",
         "target": "BTC",
         "market": {
             "name": "KuCoin",
             "identifier": "kucoin",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 0.03687,
         "volume": 644.5228612,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.121451,
             "usd": 67774
         },
         "converted_volume": {
             "btc": 23.763558,
             "eth": 644.502,
             "usd": 1610542
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.027122,
         "timestamp": "2024-10-25T04:45:54+00:00",
         "last_traded_at": "2024-10-25T04:45:54+00:00",
         "last_fetch_at": "2024-10-25T04:45:54+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.kucoin.com/trade/ETH-BTC?rcode=e21sNJ",
         "token_info_url": null,
         "coin_id": "ethereum",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "TRY",
         "market": {
             "name": "WhiteBIT",
             "identifier": "whitebit",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 2324282.55,
         "volume": 60.379424,
         "converted_last": {
             "btc": 1.000029,
             "eth": 27.122238,
             "usd": 67776
         },
         "converted_volume": {
             "btc": 60.381,
             "eth": 1638,
             "usd": 4092251
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.080789,
         "timestamp": "2024-10-25T04:45:59+00:00",
         "last_traded_at": "2024-10-25T04:45:59+00:00",
         "last_fetch_at": "2024-10-25T04:45:59+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://whitebit.com/trade/BTC_TRY?referral=21d28793-2c37-4ad5-ad65-ec354740a197",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "SUI",
         "target": "BTC",
         "market": {
             "name": "WhiteBIT",
             "identifier": "whitebit",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 2.803e-05,
         "volume": 976703.5,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.112034,
             "usd": 67772
         },
         "converted_volume": {
             "btc": 27.376999,
             "eth": 742.246,
             "usd": 1855394
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.035676,
         "timestamp": "2024-10-25T04:44:41+00:00",
         "last_traded_at": "2024-10-25T04:44:41+00:00",
         "last_fetch_at": "2024-10-25T04:44:41+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://whitebit.com/trade/SUI_BTC?referral=21d28793-2c37-4ad5-ad65-ec354740a197",
         "token_info_url": null,
         "coin_id": "sui",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "PLN",
         "market": {
             "name": "zondacrypto",
             "identifier": "bitbay",
             "has_trading_incentive": false,
             "has_referral_params": false
         },
         "last": 271957.18,
         "volume": 10.09161393,
         "converted_last": {
             "btc": 0.99953011,
             "eth": 27.109072,
             "usd": 67739
         },
         "converted_volume": {
             "btc": 10.086872,
             "eth": 273.574,
             "usd": 683597
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.015743,
         "timestamp": "2024-10-25T04:46:17+00:00",
         "last_traded_at": "2024-10-25T04:46:17+00:00",
         "last_fetch_at": "2024-10-25T04:46:17+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://zondaglobal.com/en/exchange-rate",
         "token_info_url": null,
         "coin_id": "bitcoin"
     },
     {
         "base": "SOL",
         "target": "BTC",
         "market": {
             "name": "Azbit",
             "identifier": "azbit",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 0.002558,
         "volume": 2985.78,
         "converted_last": {
             "btc": 1.0,
             "eth": 27.112034,
             "usd": 67772
         },
         "converted_volume": {
             "btc": 7.73095,
             "eth": 209.602,
             "usd": 523942
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.013908,
         "timestamp": "2024-10-25T04:44:41+00:00",
         "last_traded_at": "2024-10-25T04:44:41+00:00",
         "last_fetch_at": "2024-10-25T04:44:41+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://azbit.com/exchange/SOL_BTC?referralCode=OH5QDS1?referralCode=OH5QDS1",
         "token_info_url": null,
         "coin_id": "solana",
         "target_coin_id": "bitcoin"
     },
     {
         "base": "BTC",
         "target": "USDC",
         "market": {
             "name": "Bitget",
             "identifier": "bitget",
             "has_trading_incentive": false,
             "has_referral_params": true
         },
         "last": 67823.73,
         "volume": 64.61098,
         "converted_last": {
             "btc": 1.000578,
             "eth": 27.139963,
             "usd": 67811,
             "usd_v2": 67810
         },
         "converted_volume": {
             "btc": 64.512,
             "eth": 1750,
             "usd": 4372098,
             "usd_v2": 4372033
         },
         "trust_score": "green",
         "bid_ask_spread_percentage": 0.136363,
         "timestamp": "2024-10-25T04:47:27+00:00",
         "last_traded_at": "2024-10-25T04:47:27+00:00",
         "last_fetch_at": "2024-10-25T04:47:27+00:00",
         "is_anomaly": false,
         "is_stale": false,
         "trade_url": "https://www.bitget.com/spot/BTCUSDC/?channelCode=42xn&vipCode=sq59&languageType=0",
         "token_info_url": null,
         "coin_id": "bitcoin",
         "target_coin_id": "usd-coin"
     }
 ]
}
 
*/



// MARK: - CoinModel
struct CoinDetailModel: Codable {
    let id: ID?
    let symbol, name: String?
    let webSlug: ID?
    let assetPlatformID: JSONNull?
    let platforms: Platforms?
    let detailPlatforms: DetailPlatforms?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let categories: [String]?
    let previewListing: Bool?
    let publicNotice: JSONNull?
    let additionalNotices: [JSONAny]?
    let description: Description?
    let links: Links?
    let image: Image?
    let countryOrigin, genesisDate: String?
    let sentimentVotesUpPercentage, sentimentVotesDownPercentage: Double?
    let watchlistPortfolioUsers, marketCapRank: Int?
    let marketData: MarketData?
    let communityData: CommunityData?
    let statusUpdates: [JSONAny]?
    let lastUpdated: String?
    let tickers: [Ticker]?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case webSlug = "web_slug"
        case assetPlatformID = "asset_platform_id"
        case platforms
        case detailPlatforms = "detail_platforms"
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case categories
        case previewListing = "preview_listing"
        case publicNotice = "public_notice"
        case additionalNotices = "additional_notices"
        case description, links, image
        case countryOrigin = "country_origin"
        case genesisDate = "genesis_date"
        case sentimentVotesUpPercentage = "sentiment_votes_up_percentage"
        case sentimentVotesDownPercentage = "sentiment_votes_down_percentage"
        case watchlistPortfolioUsers = "watchlist_portfolio_users"
        case marketCapRank = "market_cap_rank"
        case marketData = "market_data"
        case communityData = "community_data"
        case statusUpdates = "status_updates"
        case lastUpdated = "last_updated"
        case tickers
    }
}

// MARK: - CommunityData
struct CommunityData: Codable {
    let facebookLikes: JSONNull?
    let twitterFollowers, redditAveragePosts48H, redditAverageComments48H, redditSubscribers: Int?
    let redditAccountsActive48H: Int?
    let telegramChannelUserCount: JSONNull?

    enum CodingKeys: String, CodingKey {
        case facebookLikes = "facebook_likes"
        case twitterFollowers = "twitter_followers"
        case redditAveragePosts48H = "reddit_average_posts_48h"
        case redditAverageComments48H = "reddit_average_comments_48h"
        case redditSubscribers = "reddit_subscribers"
        case redditAccountsActive48H = "reddit_accounts_active_48h"
        case telegramChannelUserCount = "telegram_channel_user_count"
    }
}

// MARK: - Description
struct Description: Codable {
    let en: String?
}

// MARK: - DetailPlatforms
struct DetailPlatforms: Codable {
    let empty: Empty?

    enum CodingKeys: String, CodingKey {
        case empty = ""
    }
}

// MARK: - Empty
struct Empty: Codable {
    let decimalPlace: JSONNull?
    let contractAddress: String?

    enum CodingKeys: String, CodingKey {
        case decimalPlace = "decimal_place"
        case contractAddress = "contract_address"
    }
}

enum ID: String, Codable {
    case bitcoin = "bitcoin"
    case dogecoin = "dogecoin"
    case ethereum = "ethereum"
    case monero = "monero"
    case solana = "solana"
    case sui = "sui"
    case thorchain = "thorchain"
}

// MARK: - Image
struct Image: Codable {
    let thumb, small, large: String?
}

// MARK: - Links
struct Links: Codable {
    let homepage: [String]?
    let whitepaper: String?
    let blockchainSite, officialForumURL: [String]?
    let chatURL, announcementURL: [String]?
    let twitterScreenName: ID?
    let facebookUsername: String?
    let bitcointalkThreadIdentifier: JSONNull?
    let telegramChannelIdentifier: String?
    let subredditURL: String?
    let reposURL: ReposURL?

    enum CodingKeys: String, CodingKey {
        case homepage, whitepaper
        case blockchainSite = "blockchain_site"
        case officialForumURL = "official_forum_url"
        case chatURL = "chat_url"
        case announcementURL = "announcement_url"
        case twitterScreenName = "twitter_screen_name"
        case facebookUsername = "facebook_username"
        case bitcointalkThreadIdentifier = "bitcointalk_thread_identifier"
        case telegramChannelIdentifier = "telegram_channel_identifier"
        case subredditURL = "subreddit_url"
        case reposURL = "repos_url"
    }
}

// MARK: - ReposURL
struct ReposURL: Codable {
    let github: [String]?
    let bitbucket: [JSONAny]?
}

// MARK: - MarketData
struct MarketData: Codable {
    let currentPrice: [String: Double]?
    let totalValueLocked, mcapToTvlRatio, fdvToTvlRatio, roi: JSONNull?
    let ath, athChangePercentage: [String: Double]?
    let athDate: [String: String]?
    let atl, atlChangePercentage: [String: Double]?
    let atlDate: [String: String]?
    let marketCap: [String: Double]?
    let marketCapRank: Int?
    let fullyDilutedValuation: [String: Double]?
    let marketCapFdvRatio: Double?
    let totalVolume, high24H, low24H: [String: Double]?
    let priceChange24H, priceChangePercentage24H, priceChangePercentage7D, priceChangePercentage14D: Double?
    let priceChangePercentage30D, priceChangePercentage60D, priceChangePercentage200D, priceChangePercentage1Y: Double?
    let marketCapChange24H: Int?
    let marketCapChangePercentage24H: Double?
    let priceChange24HInCurrency, priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency, priceChangePercentage7DInCurrency: [String: Double]?
    let priceChangePercentage14DInCurrency, priceChangePercentage30DInCurrency, priceChangePercentage60DInCurrency, priceChangePercentage200DInCurrency: [String: Double]?
    let priceChangePercentage1YInCurrency, marketCapChange24HInCurrency, marketCapChangePercentage24HInCurrency: [String: Double]?
    let totalSupply, maxSupply, circulatingSupply: Int?
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case totalValueLocked = "total_value_locked"
        case mcapToTvlRatio = "mcap_to_tvl_ratio"
        case fdvToTvlRatio = "fdv_to_tvl_ratio"
        case roi, ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case marketCapFdvRatio = "market_cap_fdv_ratio"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case priceChangePercentage7D = "price_change_percentage_7d"
        case priceChangePercentage14D = "price_change_percentage_14d"
        case priceChangePercentage30D = "price_change_percentage_30d"
        case priceChangePercentage60D = "price_change_percentage_60d"
        case priceChangePercentage200D = "price_change_percentage_200d"
        case priceChangePercentage1Y = "price_change_percentage_1y"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case priceChange24HInCurrency = "price_change_24h_in_currency"
        case priceChangePercentage1HInCurrency = "price_change_percentage_1h_in_currency"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case priceChangePercentage7DInCurrency = "price_change_percentage_7d_in_currency"
        case priceChangePercentage14DInCurrency = "price_change_percentage_14d_in_currency"
        case priceChangePercentage30DInCurrency = "price_change_percentage_30d_in_currency"
        case priceChangePercentage60DInCurrency = "price_change_percentage_60d_in_currency"
        case priceChangePercentage200DInCurrency = "price_change_percentage_200d_in_currency"
        case priceChangePercentage1YInCurrency = "price_change_percentage_1y_in_currency"
        case marketCapChange24HInCurrency = "market_cap_change_24h_in_currency"
        case marketCapChangePercentage24HInCurrency = "market_cap_change_percentage_24h_in_currency"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case circulatingSupply = "circulating_supply"
        case lastUpdated = "last_updated"
    }
}

// MARK: - Platforms
struct Platforms: Codable {
    let empty: String?

    enum CodingKeys: String, CodingKey {
        case empty = ""
    }
}

// MARK: - Ticker
struct Ticker: Codable {
    let base: Base?
    let target: String?
    let market: Market?
    let last, volume: Double?
    let convertedLast, convertedVolume: [String: Double]?
    let trustScore: TrustScore?
    let bidAskSpreadPercentage: Double?
    let timestamp, lastTradedAt, lastFetchAt: Date?
    let isAnomaly, isStale: Bool?
    let tradeURL: String?
    let tokenInfoURL: JSONNull?
    let coinID: ID?
    let targetCoinID: TargetCoinID?

    enum CodingKeys: String, CodingKey {
        case base, target, market, last, volume
        case convertedLast = "converted_last"
        case convertedVolume = "converted_volume"
        case trustScore = "trust_score"
        case bidAskSpreadPercentage = "bid_ask_spread_percentage"
        case timestamp
        case lastTradedAt = "last_traded_at"
        case lastFetchAt = "last_fetch_at"
        case isAnomaly = "is_anomaly"
        case isStale = "is_stale"
        case tradeURL = "trade_url"
        case tokenInfoURL = "token_info_url"
        case coinID = "coin_id"
        case targetCoinID = "target_coin_id"
    }
}

enum Base: String, Codable {
    case btc = "BTC"
    case doge = "DOGE"
    case eth = "ETH"
    case rune = "RUNE"
    case sol = "SOL"
    case sui = "SUI"
    case xmr = "XMR"
}

// MARK: - Market
struct Market: Codable {
    let name, identifier: String?
    let hasTradingIncentive, hasReferralParams: Bool?

    enum CodingKeys: String, CodingKey {
        case name, identifier
        case hasTradingIncentive = "has_trading_incentive"
        case hasReferralParams = "has_referral_params"
    }
}

enum TargetCoinID: String, Codable {
    case bitcoin = "bitcoin"
    case dai = "dai"
    case tether = "tether"
    case usdCoin = "usd-coin"
}

enum TrustScore: String, Codable {
    case green = "green"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}


 */