import 'package:farmapp_udacoding/views/Page_Dictionary_Tab.dart';
import 'package:farmapp_udacoding/views/page_gallery_tab.dart';
import 'package:farmapp_udacoding/views/page_home_tabNews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:news_app/views/account_view.dart';
// import 'package:news_app/views/favorite_view.dart';
// import 'package:news_app/views/home_view.dart';
// import 'package:news_app/views/search_view.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  static List<Widget> _bottomNavView = [
    PageHomeTabNews(),
    PageGalleryTab(),
    PageDictionaryTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _bottomNavView.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: _navBarList
            .map(
              (e) => BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  e.icon,
                  width: 24.0,
                ),
                activeIcon: SvgPicture.asset(e.activeIcon,
                    width: 24.0, color: Colors.orange),
                label: (e.title),
              ),
            )
            .toList(),
      ),
    );
  }
}

class NavBarItem {
  // data type
  final String icon;
  final String activeIcon;
  final String title;

  // constructor
  NavBarItem({this.icon, this.activeIcon, this.title});
}

List<NavBarItem> _navBarList = [
  NavBarItem(
    icon: "assets/home.svg",
    activeIcon: "assets/home_2.svg",
    title: "Home",
  ),
  NavBarItem(
    icon: "assets/gallery.svg",
    activeIcon: "assets/gallery.svg",
    title: "Search",
  ),
  NavBarItem(
    icon: "assets/dictionary.svg",
    activeIcon: "assets/dictionary_2.svg",
    title: "Account",
  ),
];
