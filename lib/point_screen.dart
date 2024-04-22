import 'package:flutter/material.dart';

class PointScreen extends StatelessWidget {
  const PointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 40,
                child: Image.asset('assets/point.png'),
              ),
              // Icon(Icons.control_point),
              const SizedBox(
                width: 40,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Point',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('100/500'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
