import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bottom_bloc.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expanded content for the selected tab
        Expanded(
          child: BlocBuilder<BottomBloc, BottomNavigationState>(
            builder: (context, state) {
              return _buildPageContent(state.selectedIndex);
            },
          ),
        ),
        // BottomNavigationBar
        BlocBuilder<BottomBloc, BottomNavigationState>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state.selectedIndex,
              onTap: (index) => context
                  .read<BottomBloc>()
                  .add(BottomNavigationItemTapped(index)),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Theme.of(context).colorScheme.onSurface,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Report',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return const Center(child: Text('Home Content'));
      case 1:
        return const Center(child: Text('Chat Content'));
      case 2:
        return const Center(child: Text('Report Content'));
      case 3:
        return const Center(child: Text('Settings Content'));
      default:
        return const Center(child: Text('Home Content'));
    }
  }
}
