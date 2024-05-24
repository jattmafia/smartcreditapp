import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  bool showClose = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            setState(() {
              showClose = true;
            });
          },
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
                suffixIcon: showClose
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 20,
                        ))
                    : null),
          ),
        ),
      ),
    );
  }
}
