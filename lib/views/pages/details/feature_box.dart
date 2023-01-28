import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget data;
  final Widget? description;

  const FeatureBox({required this.icon, required this.title, required this.data, this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )
                ),
              )
            ],
          ),
          data,
          description ?? Container()
        ],
      ),
    );
  }
}