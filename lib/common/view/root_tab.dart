import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/const/colors.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';
import 'package:flutter_deep_dive/order/views/order_screen.dart';
import 'package:flutter_deep_dive/product/components/product_card.dart';
import 'package:flutter_deep_dive/product/views/prodect_tab_screen.dart';
import 'package:flutter_deep_dive/restaurant/view/restaurant_screen.dart';
import 'package:flutter_deep_dive/user/view/profile_screen.dart';

class RootTab extends StatefulWidget {
  static String get routeName=>'root';

  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);

    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);

    super.dispose();
  }

  void tabListener(){
    setState((){
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          const RestaurantScreen(),
          ProductScreen(),
          const OrderScreen(),
          const ProfileScreen(),
        ],
      ),
    );
  }
}