import 'package:flutter/material.dart';

import 'package:motoappv2/pages/home_page.dart';
import 'package:motoappv2/pages/notes_page.dart';
import 'package:motoappv2/pages/settings_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'chat_screen.dart';

void main() {
  runApp(const MenuPage());
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var _currentIndex = 0;
  List<Widget> pageList = [
    const HomePage(),
    const ChatScreen(),
    const NotesPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              selectedColor: Theme.of(context).colorScheme.tertiary,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.chat_outlined),
              title: const Text("Chat Bot"),
              selectedColor: Theme.of(context).colorScheme.tertiary,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.notes_rounded),
              title: const Text("Notes"),
              selectedColor: Theme.of(context).colorScheme.tertiary,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.settings_rounded),
              title: const Text("Settings"),
              selectedColor: Theme.of(context).colorScheme.tertiary,
            ),
          ],
        ),
        body: pageList[_currentIndex]);
  }
}
