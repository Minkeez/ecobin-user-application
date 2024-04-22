import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

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
                child: Image.asset('assets/yogurt.png'),
              ),
              const SizedBox(
                width: 40,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'YOGURT CUP',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('30 %'),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                child: Image.asset('assets/bottle.png'),
              ),
              const SizedBox(
                width: 40,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BOTTLE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('50 %'),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                child: Image.asset('assets/can.png'),
              ),
              const SizedBox(
                width: 40,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CAN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('10 %'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
