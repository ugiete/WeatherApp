import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/services/cities/cities.dart';
import 'package:weather_app/services/cities/payload/find_cities.dart';
import 'package:weather_app/services/storage/payload/location.dart';
import 'package:weather_app/services/storage/storage.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int suggestionsLength;
  final void Function(int) onChange;

  const SearchAppBar({required this.suggestionsLength, required this.onChange, super.key});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize {
    double suggestionFactor = suggestionsLength * 30.0;

    return Size.fromHeight(kMinInteractiveDimension * 2 + suggestionFactor);
  }
}

class _SearchAppBarState extends State<SearchAppBar> {
  TextEditingController ctrl = TextEditingController();
  List<FindCityModel> suggestions = [];

  Future<void> onChange(String? text) async {
    if(suggestions.isNotEmpty && (text == null || text.length < 3)) {
      setState(() {
        suggestions = [];
      });

      widget.onChange(0);
    }

    if (text != null && text.length >= 3) {
      List<FindCityModel> newSuggestions = await getFindCities(text, 'PT');

      widget.onChange(newSuggestions.length);

      setState(() {
        suggestions = newSuggestions;
      });
    }
  }

  void saveLocation(FindCityModel city) {
    StorageService storage = StorageService();
    storage.writeLocation(LocationModel.fromJSON(city.toMap));
  }

  void clear() {
    ctrl.clear();

    setState(() {
      suggestions = [];
    });

    widget.onChange(0);
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kMinInteractiveDimension * 2 + 10),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: AppBar(
            backgroundColor: Colors.white.withOpacity(0.2),
            title: const Text('Weather'),
            elevation: 0.0,                
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kMinInteractiveDimension),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextField(
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: ctrl,
                            onChanged: onChange,
                            style: const TextStyle(color: Colors.white),
                            
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search for cities',
                              hintStyle: const TextStyle(color: Colors.white54),
                              prefixIcon: const Icon(Icons.search, color: Colors.white54),
                              fillColor: Colors.black.withOpacity(0.2),
                              filled: true
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        itemCount: suggestions.length,
                        itemBuilder: (context, index) {
                          FindCityModel city = suggestions[index];

                          return GestureDetector(
                            onTap: () {
                              saveLocation(city);
                              clear();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              height: 30.0,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(bottom: BorderSide(color: Colors.grey))
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(city.description)),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0,)
                ],
              )
            ),
          ),
        ),
      )
    );
  }
}