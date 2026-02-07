import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../Features/DashboardScreen/HomeScreen.dart';
import '../../Features/InventoryMangaers/InventoryScreen.dart';
import '../../Features/ProfileScreen/Profile.dart';
import '../../Features/ProjectManager/Project_list.dart';
import 'NiavigatorController.dart';

class MainWrapperScreen extends StatefulWidget {
  MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {
  final List<Widget> _screens = [
    const DashboardScreen(),
    ProjectScreen(),
    const InventoryScreen(),
    const ProfileScreen(),
  ];

  bool _isBarPressed = false;

  void _onItemTap(MainNavigationController controller, int index) {
    setState(() => _isBarPressed = true);

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() => _isBarPressed = false);
        controller.setIndex(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainNavigationController(),
      child: Consumer<MainNavigationController>(
        builder: (context, controller, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.reverse) {
                controller.setVisible(false);
              } else if (notification.direction == ScrollDirection.forward) {
                controller.setVisible(true);
              }
              return true;
            },
            child: Scaffold(
              extendBody: true,
              body: IndexedStack(
                index: controller.currentIndex,
                children: _screens,
              ),
              bottomNavigationBar: AnimatedSlide(
                offset: controller.isVisible ? Offset.zero : const Offset(0, 2),
                duration: const Duration(milliseconds: 300),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: controller.isVisible ? 1 : 0,
                  child: _buildModernBottomBar(context, controller),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernBottomBar(BuildContext context, MainNavigationController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      height: 70,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Bottom Bar Background with Press Animation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedScale(
              scale: _isBarPressed ? 0.95 : 1.0,
              duration: const Duration(seconds: 800),
              curve: Curves.easeInOut,
              child: AnimatedContainer(
                duration: const Duration(seconds: 800),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(_isBarPressed ? 0.05 : 0.1),
                      blurRadius: _isBarPressed ? 10 : 20,
                      offset: Offset(0, _isBarPressed ? -5 : -10),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey.shade50,
                        Colors.white,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(_isBarPressed ? 0.3 : 0.6),
                        blurRadius: _isBarPressed ? 3 : 5,
                        spreadRadius: _isBarPressed ? 1 : 3,
                        offset: Offset(0, _isBarPressed ? 5 : 10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Navigation Items (on top of background)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _navItem(controller, 0, Icons.grid_view_rounded, 'Home'),
                  _navItem(controller, 1, Icons.assignment_outlined, 'Projects'),
                  _navItem(controller, 2, Icons.inventory_2_outlined, 'Inventory'),
                  _navItem(controller, 3, Icons.person_outline_rounded, 'Profile'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(MainNavigationController controller, int index, IconData icon, String label) {
    final bool isSelected = controller.currentIndex == index;

    return GestureDetector(
      onTap: () => _onItemTap(controller, index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 50,
        height: 50,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            // Animated Icon that pops UP
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              bottom: isSelected ? 10 : 12,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
                width: isSelected ? 36 : 40,
                height: isSelected ? 56 : 40,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFF6B35) : Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: isSelected
                      ? [
                    const BoxShadow(
                      color: Colors.white,
                      blurRadius: 0,
                      spreadRadius: 1,
                      offset: Offset(-1, -4),
                    ),
                  ]
                      : [],
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    size: isSelected ? 18 : 22,
                  ),
                ),
              ),
            ),

            // Label at bottom
            Positioned(
              bottom: 2,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isSelected ? 1.0 : 0.7,
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFFFF6B35) : Colors.grey.shade700,
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}