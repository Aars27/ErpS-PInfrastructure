import 'package:flutter/material.dart';

class NavigationHelper {
  static void navigateToIndex(BuildContext context, int index, int currentIndex) {
    if (index == currentIndex) return;

    // Remove all previous routes and navigate to selected screen
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, '/HomeScreen', (route) => false);
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(context, '/ModuleScreen', (route) => false);
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(context, '/AlertsScreen', (route) => false);
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(context, '/ProfileScreen', (route) => false);
        break;
    }
  }

  static Widget buildBottomNavBar(BuildContext context, int selectedIndex) {
    final navItems = [
      _NavItem(
        icon: Icons.dashboard_outlined,
        activeIcon: Icons.dashboard,
        label: 'Home',
      ),
      _NavItem(
        icon: Icons.inventory_2_outlined,
        activeIcon: Icons.inventory_2,
        label: 'Module',
      ),
      _NavItem(
        icon: Icons.notifications_outlined,
        activeIcon: Icons.notifications,
        label: 'Alerts',
      ),
      _NavItem(
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        label: 'Profile',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              navItems.length,
                  (index) => _buildNavItem(
                context,
                navItems[index],
                index,
                selectedIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildNavItem(
      BuildContext context,
      _NavItem item,
      int index,
      int selectedIndex,
      ) {
    final isSelected = index == selectedIndex;
    final color = isSelected ? const Color(0xFFFF6B35) : Colors.grey;

    return Expanded(
      child: InkWell(
        onTap: () => navigateToIndex(context, index, selectedIndex),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? item.activeIcon : item.icon,
                color: color,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                item.label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}