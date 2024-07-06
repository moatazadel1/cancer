import 'package:breast_cancer/features/home/presentation/views/home_view.dart';
import 'package:breast_cancer/features/profile/presentation/views/language_view.dart';
import 'package:breast_cancer/features/profile/presentation/views/notification_view.dart';
import 'package:breast_cancer/features/profile/presentation/views/profile_view.dart';
import 'package:breast_cancer/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class RootView extends StatefulWidget {
  static const routName = 'RootScreen';
  final String userType;

  const RootView({super.key, required this.userType});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  late PageController controller;
  int currentPage = 0;
  late List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentPage);
    widgets = [
      HomeView(
        userType: widget.userType,
      ),
      ProfileView(
        userType: widget.userType,
      ),
      const NotificationView(),
       LanguageView(
        userType: widget.userType,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: widgets,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedIndex: currentPage,
        elevation: 2,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (value) {
          setState(() {
            currentPage = value;
          });
          controller.jumpToPage(currentPage);
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(IconlyLight.home),
            label: S.of(context).Home,
            selectedIcon: const Icon(
              IconlyBold.home,
            ),
          ),
          NavigationDestination(
            icon: const Icon(IconlyLight.profile),
            label: S.of(context).Profile,
            selectedIcon: const Icon(
              IconlyBold.profile,
            ),
          ),
          NavigationDestination(
            icon: const Icon(IconlyLight.notification),
            label: S.of(context).Notifications,
            selectedIcon: const Icon(
              IconlyBold.notification,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Icons.language),
            label: S.of(context).Language,
            selectedIcon: const Icon(
              Icons.language_sharp,
            ),
          ),
        ],
      ),
    );
  }
}
