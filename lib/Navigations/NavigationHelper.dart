import 'package:flutter/material.dart';

class NavigationHelper {
  static void navigateToIndex(BuildContext context, int index, int currentIndex) {
    if (index == currentIndex) return;

    // Remove all previous routes and navigate to selected screen
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(context, '/stock', (route) => false);
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(context, '/MaterialRequestsScreen', (route) => false);
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(context, '/Inventory Management', (route) => false);
        break;
      case 4:
        Navigator.pushNamedAndRemoveUntil(context, '/settings', (route) => false);
        break;
    }
  }

  static Widget buildBottomNavBar(BuildContext context, int selectedIndex) {
    final navItems = [
      _NavItem(
        icon: Icons.dashboard_outlined,
        activeIcon: Icons.dashboard,
        label: 'Dashboard',
      ),
      _NavItem(
        icon: Icons.inventory_2_outlined,
        activeIcon: Icons.inventory_2,
        label: 'Stock',
      ),
      _NavItem(
        icon: Icons.assignment_outlined,
        activeIcon: Icons.assignment,
        label: 'Material Request',
      ),
      _NavItem(
        icon: Icons.shopping_cart_outlined,
        activeIcon: Icons.shopping_cart,
        label: 'Inventory Management',
      ),
      _NavItem(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings,
        label: 'Settings',
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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
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

    return InkWell(
      onTap: () => navigateToIndex(context, index, selectedIndex),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
















/*
import 'package:flutter/material.dart';

class NavigationHelper {
  static void navigateToIndex(BuildContext context, int index, int currentIndex) {
    if (index == currentIndex) return;

    // Remove all previous routes and navigate to selected screen
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(context, '/stock', (route) => false);
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(context, '/MaterialRequestsScreen', (route) => false);
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(context, '/Inventory Management', (route) => false);

        break;

      case 4:
        Navigator.pushNamedAndRemoveUntil(context, '/settings', (route) => false);

        break;
    }
  }

  static Widget buildBottomNavBar(BuildContext context, int selectedIndex) {
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
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => navigateToIndex(context, index, selectedIndex),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFFF6B35),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Material Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Inventory Management',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}*/
