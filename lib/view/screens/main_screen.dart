
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import '../widgets/side_bar.dart';
import 'add_screen/add_screen.dart';
import 'all_data_screen.dart';
class MainScreen extends StatefulWidget {
   MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _controller = SidebarXController(selectedIndex: 0, extended: false);

  final _key = GlobalKey<ScaffoldState>();
@override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return     SafeArea(
      child: Scaffold(
      
        drawer:           SafeArea(
          child: SidebarX(

            controller: _controller,
            items: const [
              SidebarXItem(icon: Icons.add, label: ''),
              SidebarXItem(icon: Icons.folder_copy_outlined, label: ''),
              SidebarXItem(icon: Icons.exit_to_app, label: ''),
      
            ],
      
          ),
        ),
      
      
        body:SafeArea(
          child: Row(
            children: [
            SidebarXWidget(controller: _controller),
              Expanded(
                child: Center(
                  child: _ScreensExample(
                    controller: _controller,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return AllDataScreen() ;

          case 1:
         return   AddScreen();

            default:
            return const SizedBox();
        }
      },
    );
  }
}