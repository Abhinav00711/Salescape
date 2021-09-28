import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './cart_screen.dart';
import './home_screen.dart';
import './order_screen.dart';
import './profile_screen.dart';
import './search_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _index = 2;
  bool _isFirstBack = true;

  final _screens = [
    OrderScreen(),
    CartScreen(),
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final _items = [
      Icon(
        FontAwesomeIcons.box,
        size: 30,
      ),
      Icon(
        Icons.shopping_cart,
        size: 30,
      ),
      Icon(
        Icons.home,
        size: 30,
      ),
      Icon(
        Icons.search,
        size: 30,
      ),
      Icon(
        Icons.person,
        size: 30,
      ),
    ];
    return WillPopScope(
      onWillPop: () async {
        if (_index != 2) {
          setState(() {
            _index = 2;
          });
          return false;
        } else {
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
        }
      },
      child: Scaffold(
        extendBody: true,
        body: _screens[_index],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(
            color: const Color(0xff092E34),
          )),
          child: CurvedNavigationBar(
            height: 60,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 400),
            color: Colors.tealAccent.shade700,
            buttonBackgroundColor: Theme.of(context).accentColor,
            backgroundColor: Colors.transparent,
            index: _index,
            items: _items,
            onTap: (index) {
              setState(() {
                this._index = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
