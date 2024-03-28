import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List WidgetOption = [Text("home"),Text("list"),Text("summary"),Text("setting")];
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255,77, 145, 90),
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
          ],
          leading: IconButton(
            icon: Icon(Icons.menu),
            splashColor: Colors.transparent, //action หลังกดปุ่มแล้วมีกลมๆ
            onPressed: () => {},
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 16.h),
          child: BottomAppBar(
            clipBehavior: Clip.antiAlias,
            elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.w)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, -1))
                    ]),
                height: 60.h,
                child: Row(
                  children: [
                    navItem(
                      Icons.credit_card,
                      pageIndex == 0,
                    ),
                    navItem(
                      Icons.receipt,
                      pageIndex == 1,
                    ),
                    navItem(
                      Icons.auto_graph,
                      pageIndex == 2,
                    ),
                    navItem(
                      Icons.supervised_user_circle,
                      pageIndex == 3,
                    )
                  ],
                ),
              ),
          ),
        ),
        body: Center(
          child: WidgetOption[pageIndex],
        ),
      )),
    );
  }

  Widget navItem(IconData icon, bool selected, {Function()? onTap}) {
    return Expanded(
        child: Container(
      color: selected ? Color.fromARGB(255,77, 145, 90) : Colors.white,
      child: InkWell(
        child: Icon(
          icon,
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    ));
  }
}
