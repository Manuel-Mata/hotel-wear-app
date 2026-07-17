import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'wear_dashboard_screen.dart';
import 'wear_alerts_screen.dart';
import 'wear_history_screen.dart';

class WearMainScreen extends ConsumerStatefulWidget {
  const WearMainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WearMainScreen> createState() => _WearMainScreenState();
}

class _WearMainScreenState extends ConsumerState<WearMainScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        children: const [
          WearDashboardScreen(),
          WearAlertsScreen(),
          WearHistoryScreen(),
        ],
      ),
      // Indicador simple de página
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {},
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Text(
          '${_currentPage + 1}/3',
          style: const TextStyle(fontSize: 10, color: Colors.white70),
        ),
      ),
    );
  }
}