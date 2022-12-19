import 'dart:async';

enum NavBarItem{HOME , SOURCE , SEARCH}


class BottomNavBarBloc
{
  final StreamController<NavBarItem> _navBarConroller=
      StreamController<NavBarItem>.broadcast();


  NavBarItem defaultItem=NavBarItem.HOME;

  Stream<NavBarItem> get itemStream=>_navBarConroller.stream;

  void pickItem(int i)
  {
    switch(i)
    {
      case 0 :
        _navBarConroller.sink.add(NavBarItem.HOME);
        break;
      case 1 :
        _navBarConroller.sink.add(NavBarItem.SOURCE);
        break;
      case 2 :
        _navBarConroller.sink.add(NavBarItem.SEARCH);
        break;
    }

  }
  close()
  {
    _navBarConroller.close();
  }





}