import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/utils/responsive.dart';
import 'history_tab.dart';
import 'home_tab.dart';
import 'profile_tab.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _destinations = [
    (Icons.home_outlined, Icons.home_rounded, 'Beranda'),
    (Icons.history_outlined, Icons.history_rounded, 'Riwayat'),
    (Icons.person_outline_rounded, Icons.person_rounded, 'Profil'),
  ];

  void _select(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final pages = [
      const HomeTab(),
      HistoryTab(onStartLearning: () => _select(0)),
      const ProfileTab(),
    ];
    final body = SafeArea(
      top: false,
      child: IndexedStack(index: _index, children: pages),
    );

    if (r.isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _index,
              onDestinationSelected: _select,
              extended: r.isDesktop,
              labelType: r.isDesktop
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              leading: Padding(
                padding: EdgeInsets.symmetric(vertical: r.sp(16)),
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: r.sp(40),
                ),
              ),
              destinations: [
                for (final (icon, selected, label) in _destinations)
                  NavigationRailDestination(
                    icon: Icon(icon),
                    selectedIcon: Icon(selected),
                    label: Text(label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: body),
          ],
        ),
      );
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _select,
        destinations: [
          for (final (icon, selected, label) in _destinations)
            NavigationDestination(
              icon: Icon(icon),
              selectedIcon: Icon(selected),
              label: label,
            ),
        ],
      ),
    );
  }
}
