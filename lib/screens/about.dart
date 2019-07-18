import 'package:flutter/material.dart';
import 'package:it_forum_omsk/widgets/custom_appbar_v2.dart';
import 'package:it_forum_omsk/widgets/custom_tabbar.dart';


class About extends StatelessWidget{
  final String title;
  About(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      body: Column(
        children: <Widget>[
          CustomAppBar(title),
          Expanded(
            child: AboutTheForum(),
          ),
        ],
      ),
    );
  }
}

class AboutTheForum extends StatefulWidget{
  @override
  _AboutTheForum createState() => _AboutTheForum();
}

class _AboutTheForum extends State<AboutTheForum> with SingleTickerProviderStateMixin {

  TabController controller;

  List<Tab> tabs = [
    Tab(
      child: Text(
        'О форуме',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16.0,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Организаторы',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 15.0,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Партнеры',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16.0,
        ),
      ),
    ),
  ];

  var aboutText1 = "Международный ИТ-форум - это крупная экспертная "
      "площадка для обсуждения передовых мировых и российских разработок "
      "высокотехнологичного характера от технологий до их практической реализации\n";


  var aboutText2 =  "Организаторами IV Международного ИТ-Форума являются НП\"ИТ-Кластер Сибири\","
      " Правительство Омской области, Агенство развития и инвестиций Омской"
      "области и Фонд поддержки предпринимательства\n" ;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget aboutForumPage(){
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(7.0),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Color.fromRGBO(31, 32, 65, 0.8)),
          child: Container(
            height: 100,
            color: Color.fromRGBO(224, 224, 224, 1),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 10,
                    child:  ListView(
                        children: <Widget>[
                          Center(
                            child: Text('V Международный Омский IT-форум',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Color.fromRGBO(31, 32, 65, 0.8),
                              ),
                            ),
                          ),
                          RichText(
                            text:  TextSpan(text: aboutText1, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, height: 1.5 , fontFamily: 'Montserrat',color: Color.fromRGBO(31, 32, 65, 0.8)),),                                          ),
                          RichText(
                            text:  TextSpan(text: aboutText2, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, height: 1.5, fontFamily: 'Montserrat',color: Color.fromRGBO(31, 32, 65, 0.8)),),
                          ),
                          Center(
                            child: Text('Контакты',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Color.fromRGBO(31, 32, 65, 0.8),
                              ),
                            ),
                          ),
                          Center(
                            child: Text('8 (929) 367-00-03',
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, height: 1.5, fontFamily: 'Montserrat',color: Color.fromRGBO(31, 32, 65, 0.8)
                              ),
                            ),
                          ),
                          Center(
                            child: Text('https://oiitf.ru/',
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, height: 1.5, fontFamily: 'Montserrat',color: Color.fromRGBO(31, 32, 65, 0.8)
                              ),
                            ),
                          ),
                          Center(
                            child: Text('info@itclastersib.ru',
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, height: 1.5, fontFamily: 'Montserrat',color: Color.fromRGBO(31, 32, 65, 0.8)
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column (
        children: <Widget>[
          customTabBar(tabs, controller),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: <Widget>[
                aboutForumPage(),
                Container(
                  child: Text('Организаторы'),
                ),
                Container(
                  child: Text('Партнеры'),
                ),
              ],
            ),
          ),
        ]
    );
  }
}