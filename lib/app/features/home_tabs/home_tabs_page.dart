import 'package:flutter/material.dart';
import 'package:app_test/app/features/profile/presentation/profile_page.dart';
import 'package:app_test/app/features/tasks/presentation/pages/tasks_page.dart';
import 'package:app_test/app/features/tasks_saved/presentation/tasks_saved_page.dart';

class HomeTabsPage extends StatefulWidget {
  const HomeTabsPage({super.key});

  @override
  State<HomeTabsPage> createState() => _HomeTabsPageState();
}

class _HomeTabsPageState extends State<HomeTabsPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final pages = [
    const TasksPage(),
    const TasksSavedPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.fact_check_outlined,
            ),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_2_outlined,
            ),
            label: '',
          ),
        ],
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
