import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../Features/DashboardScreen/HomeScreen.dart';
import '../../Features/InventoryMangaers/InventoryScreen.dart';
import '../../Features/ProfileScreen/Profile.dart';
import '../../Features/ProjectManager/Project_list.dart';
import 'NiavigatorController.dart';

// ... (Your imports remain the same)

class MainWrapperScreen extends StatelessWidget {
  MainWrapperScreen({super.key});

  final List<Widget> _screens = [
    const DashboardScreen(),
    ProjectScreen(),
    const InventoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainNavigationController(),
      child: Consumer<MainNavigationController>(
        builder: (context, controller, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.reverse) {
                controller.setVisible(false); // Hide on scroll down
              } else if (notification.direction == ScrollDirection.forward) {
                controller.setVisible(true);  // Show on scroll up
              }
              return true;
            },
            child: Scaffold(
              extendBody: true, // Crucial for smooth transitions
              body: IndexedStack(
                index: controller.currentIndex,
                children: _screens,
              ),
              bottomNavigationBar: AnimatedSlide(
                offset: controller.isVisible ? Offset.zero : const Offset(0, 2),
                duration: const Duration(milliseconds: 1500),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 900),
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
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16), // Floating effect
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B35), // Your brand orange
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(controller, 0, Icons.grid_view_rounded, 'Home'),
          _navItem(controller, 1, Icons.assignment_outlined, 'Projects'),
          _navItem(controller, 2, Icons.layers_outlined, 'Inventory'),
          _navItem(controller, 3, Icons.person_outline_rounded, 'Profile'),
        ],
      ),
    );
  }

  Widget _navItem(MainNavigationController controller, int index, IconData icon, String label) {
    final bool isSelected = controller.currentIndex == index;

    return GestureDetector(
      onTap: () => controller.setIndex(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          // Soft white pill background for selected item
          color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white70,
              size: isSelected ? 20 : 22,
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(label),
            ),
            // Tiny dot indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(top: 2),
              height: 3,
              width: isSelected ? 3 : 0,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            )
          ],
        ),
      ),
    );
  }
}