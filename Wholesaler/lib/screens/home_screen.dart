import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import './order_screen.dart';
import './product_screen.dart';
import './profile_screen.dart';
import '../providers/auth_provider.dart';
import '../widgets/HomeScreen/home_button.dart';
import '../widgets/HomeScreen/home_status_card.dart';
import '../data/global.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pending = 0;
  int _accepted = 0;
  int _completed = 0;

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    await FirestoreService()
        .getPendingUserOrders(Global.userData!.wid)
        .then((value) {
      _pending = value.length;
    });
    await FirestoreService()
        .getAcceptedUserOrders(Global.userData!.wid)
        .then((value) {
      _accepted = value.length;
    });
    await FirestoreService()
        .getCompletedUserOrders(Global.userData!.wid)
        .then((value) {
      _completed = value.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _isFirstBack = true;
    MediaQueryData _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_isFirstBack) {
            Fluttertoast.showToast(
                msg: "Press again to exit",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
            _isFirstBack = false;
            await Future.delayed(Duration(seconds: 1))
                .then((_) => _isFirstBack = true);
          } else {
            return true;
          }
          return false;
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.blue[50],
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Color(0xFF3A5160).withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60.0)),
                              child: Image.asset('assets/images/userImage.png'),
                            ),
                          ),
                          Text(
                            Global.userData!.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'ORDERS',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  HomeStatusCard(
                                    value: _pending,
                                    title: 'Pending',
                                  ),
                                  HomeStatusCard(
                                    value: _accepted,
                                    title: 'Accepted',
                                  ),
                                  HomeStatusCard(
                                    value: _completed,
                                    title: 'Completed',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.teal,
                child: Container(
                  width: _mediaQuery.size.width,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HomeButton(
                            image: 'assets/images/order.png',
                            title: 'ORDERS',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderScreen()),
                              );
                            },
                          ),
                          HomeButton(
                            image: 'assets/images/product.png',
                            title: 'PRODUCTS',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HomeButton(
                            image: 'assets/images/profile.png',
                            title: 'PROFILE',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()),
                              );
                            },
                          ),
                          HomeButton(
                            image: 'assets/images/logout.png',
                            title: 'LOGOUT',
                            onPressed: () async {
                              Global.userData = null;
                              await Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .logout();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
