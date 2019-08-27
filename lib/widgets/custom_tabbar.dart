import 'package:flutter/material.dart';


Widget customTabBar(List<Tab> tabs, var tabController){
  var tabColor = Color.fromRGBO(124, 125, 141, 1);
  var tabSelectedColor = Color.fromRGBO(52, 152, 219, 1);
  return TabBar(
    controller: tabController,
    indicatorColor: tabSelectedColor,
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorWeight: 3.0,
    isScrollable: true,
    labelColor: tabSelectedColor,
    labelStyle: TextStyle(fontWeight: FontWeight.w900),
    unselectedLabelColor: tabColor,
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
    tabs: tabs,
  );
}