import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar(
      {Key? key, required this.index, required this.onChangedTab})
      : super(key: key);

  final int index;
  final ValueChanged<int> onChangedTab;

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTabItens(
              index: 1, icon: const Icon(Icons.add), title: 'Novo Agendamento'),
          buildTabItens(
              index: 2, icon: const Icon(Icons.list_alt), title: 'Minhas Consultas'),
        ],
      ),
    );
  }

  Widget buildTabItens(
      {required int index, required Icon icon, required String title}) {
    final isSelected = index == widget.index;

    return IconTheme(
      data: IconThemeData(color: isSelected ? Colors.blue : Colors.black),
      child: IconButton(
        icon: icon,
        onPressed: () => widget.onChangedTab(index),
      ),
    );
  }
}
