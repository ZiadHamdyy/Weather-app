import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearch;
  const CustomSearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: SearchBar(
        hintText: 'Search for a city',
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            onSearch(value);
          }
          value = '';
        },
      ),
    );
  }
}
