import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bottom_bloc.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<BottomBloc, BottomNavigationState>(
            builder: (context, state) {
              return _buildPageContent(state.selectedIndex);
            },
          ),
        ),
        BlocBuilder<BottomBloc, BottomNavigationState>(
          builder: (context, state) {
            final theme = Theme.of(context).bottomNavigationBarTheme;

            return BottomNavigationBar(
              currentIndex: state.selectedIndex,
              onTap: (index) =>
                  context.read<BottomBloc>().add(BottomNavigationItemTapped(index)),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: theme.selectedItemColor,
              unselectedItemColor: theme.unselectedItemColor,
              backgroundColor: theme.backgroundColor,
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
