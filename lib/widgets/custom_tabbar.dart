import 'package:flutter/material.dart';


Widget customTabBar(List<Tab> tabs, var tabController){
  return TabBar(
    controller: tabController,
    indicatorColor: Color.fromRGBO(69, 69, 77, 0.8),
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorWeight: 3.0,
    isScrollable: true,
    labelColor: Color.fromRGBO(69, 69, 77, 0.8),
    labelStyle: TextStyle(fontWeight: FontWeight.w800),
    unselectedLabelColor: Color.fromRGBO(69, 69, 77, 0.8),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
    tabs: tabs,
  );
}