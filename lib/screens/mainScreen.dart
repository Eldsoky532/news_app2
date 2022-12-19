
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/tabs/home_screen.dart';
import 'package:news_app/screens/tabs/searchscreen.dart';
import 'package:news_app/screens/tabs/source_screen.dart';

import '../bloc/button_nav_bar.dart';

import 'package:news_app/style/theme.dart'as Style;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late BottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomNavBarBloc=BottomNavBarBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Style.Colors.maincolor,
          title: Text(
            'NewsApp',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
         // ignore:missing_return
          builder: (BuildContext context ,AsyncSnapshot<NavBarItem> snapshot){
            switch(snapshot.data)
            {
              case NavBarItem.HOME:
                return HomeScreen();
              case NavBarItem.SOURCE:
                return SourceScreen();
              case NavBarItem.SEARCH:
                return SearchScreen();

            }
            return Container();
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0,
                  blurRadius: 10.0
                )
              ]
            ),
            child:ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: 20.0,
                unselectedItemColor: Colors.grey,
                unselectedFontSize: 9.0,
                selectedFontSize: 9.0,
                type: BottomNavigationBarType.fixed,
                fixedColor: Style.Colors.maincolor,
                currentIndex: snapshot.data!.index,
                onTap: _bottomNavBarBloc.pickItem,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(EvaIcons.homeOutline),
                    activeIcon: Icon(EvaIcons.home),
                   label: 'Home'
                  ),


                  BottomNavigationBarItem(
                    icon: Icon(EvaIcons.gridOutline),
                    activeIcon: Icon(EvaIcons.grid),
                      label: 'Source'

                  ),


                  BottomNavigationBarItem(
                    icon: Icon(EvaIcons.searchOutline),
                    activeIcon: Icon(EvaIcons.search),
                      label: 'Search'

                  ),
                ],
              ),
            ) ,
          );
        },
      ),
    );
  }

Widget testScreen()
{
  return Container(
    color: Colors.white,
    width: MediaQuery.of(context).size.width,
    child: Column(
      children: [

        Text('Test Screen')
      ],
    ),
  );
}



}
