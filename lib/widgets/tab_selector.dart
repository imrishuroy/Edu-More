import '/config/enums/app_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final AppTab? activeTab;
  final Function(AppTab)? onTabSelected;

  const TabSelector({
    Key? key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: const Color(0xffffdf00)),
      child: BottomNavigationBar(
        elevation: 13,
        //backgroundColor: Colors.amber,
        //fixedColor: Colors.amber,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[800],
        currentIndex: AppTab.values.indexOf(activeTab!),
        onTap: (index) => onTabSelected!(AppTab.values[index]),
        items: AppTab.values.map((tab) {
          return BottomNavigationBarItem(
            icon: _tabIcon(tab),
            label: _label(tab),
          );
        }).toList(),
      ),
    );
  }
}

Widget _tabIcon(AppTab tab) {
  if (tab == AppTab.home) {
    return const Icon(
      Icons.list,
      //  color: Colors.black,
    );
  } else if (tab == AppTab.courses) {
    return const Icon(
      Icons.library_books,
      // color: Colors.black,
    );
  } else if (tab == AppTab.myLearnings) {
    return const Icon(
      Icons.local_library,
      // color: Colors.black,
    );
  } else {
    return const Icon(
      Icons.person,
      //color: Colors.black,
    );
  }
}

String _label(AppTab tab) {
  if (tab == AppTab.home) {
    return 'Home';
  } else if (tab == AppTab.courses) {
    return 'Courses';
  } else if (tab == AppTab.myLearnings) {
    return 'My learning';
  } else {
    return 'Profile';
  }
}
