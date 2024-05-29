import 'package:flutter/material.dart';

class LeaderboardSection extends StatelessWidget {
  const LeaderboardSection({
    super.key,
    required this.bottles,
    required this.cans,
    required this.yogurtCups,
  });

  final int bottles;
  final int cans;
  final int yogurtCups;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildItem('assets/yogurt.png', 'YOGURT CUP', yogurtCups),
          const SizedBox(height: 30),
          _buildItem('assets/bottle.png', 'BOTTLE', bottles),
          const SizedBox(height: 30),
          _buildItem('assets/can.png', 'CAN', cans),
        ],
      ),
    );

    // return Container(
    //   padding: const EdgeInsets.all(20),
    //   child: Column(
    //     children: [
    //       Row(
    //         children: [
    //           SizedBox(
    //             height: 50,
    //             child: Image.asset('assets/yogurt.png'),
    //           ),
    //           const SizedBox(
    //             width: 40,
    //           ),
    //           const Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'YOGURT CUP',
    //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text(
    //                 '30 %',
    //                 style: TextStyle(fontSize: 16),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 30,
    //       ),
    //       Row(
    //         children: [
    //           SizedBox(
    //             height: 50,
    //             child: Image.asset('assets/bottle.png'),
    //           ),
    //           const SizedBox(
    //             width: 40,
    //           ),
    //           const Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'BOTTLE',
    //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text(
    //                 '50 %',
    //                 style: TextStyle(fontSize: 16),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 30,
    //       ),
    //       Row(
    //         children: [
    //           SizedBox(
    //             height: 50,
    //             child: Image.asset('assets/can.png'),
    //           ),
    //           const SizedBox(
    //             width: 40,
    //           ),
    //           const Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'CAN',
    //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text(
    //                 '10 %',
    //                 style: TextStyle(fontSize: 16),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget _buildItem(String asset, String label, int count) {
    return Row(
      children: [
        SizedBox(
          height: 50,
          child: Image.asset(asset),
        ),
        const SizedBox(width: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '$count',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        )
      ],
    );
  }
}
