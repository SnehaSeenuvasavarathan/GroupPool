// ignore: file_names
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class rideDetail extends StatefulWidget {
  rideDetail({Key? key, required this.ride}) : super(key: key);
  final Map ride;
  // final int length = this.ride.length;

  @override
  _rideDetailState createState() => _rideDetailState();
}

class _rideDetailState extends State<rideDetail> {
  Razorpay _razorpay = Razorpay();
  var prefs, row;
  String email = '';
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance().then((value) => {
          setState(() {
            prefs = value;
            email = '${value.getString('useremail')}';
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    //return Container(child: Text('${widget.ride}'));
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0), child: Text('GrouPool'))
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Ride Detail',
                    style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  )),
              Card(
                elevation: 8.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.pink[50]),
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.account_circle,
                            size: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Text(
                              'Owner: ' + '${widget.ride['email']}',
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w100),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Text(
                              'Start: ' + '${widget.ride['start']}',
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w100),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Text(
                              'End: ' + '${widget.ride['end']}',
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w100),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Text(
                              'Time: ' + '${widget.ride['time']}',
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w100),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                for (var item in widget.ride['riderList'])
                                  Text(
                                    item,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w100),
                                  )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Text(
                              'Payment Amount: USD ' +
                                  '${100 / widget.ride['riderList'].length}',
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w100),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 6.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.pink)),
                    child: const Text(
                      'Pay',
                      key: ValueKey('pay'),
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const EditProfile()),
                      // );
                      openCheckout();
                    },
                  )),
            ])));
  }

  void openCheckout() async {
    int amount = int.parse('100') * 100;

    var options = {
      'key': 'rzp_test_2TLtsLWJAwiCKC',
      'currency': 'USD',
      'amount': 20000,
      'name': 'GrouPool',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8887788888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
        // 'wallets': ['gpay']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      // debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("SUCCESS: " + response.paymentId!)));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("ERROR: " + response.code.toString() + " - " + response.message!);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "ERROR: " + response.code.toString() + " - " + response.message!)));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("EXTERNAL_WALLET: " + response.walletName!)));
  }
} //End

_rideDetailState callOpenCheck() {
  var obj = _rideDetailState();
  return obj;
}

// /Users/sneha/Flutter_apps/supernew/GroupPool/android/.gradle/6.7/fileHashes/fileHashes.lock
