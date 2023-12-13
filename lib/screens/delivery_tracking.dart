import 'package:flutter/material.dart';
import 'package:resculpt/widgets/my_timeline_tile.dart';

class DeliveryTracking extends StatefulWidget {
  const DeliveryTracking({super.key});

  @override
  State<DeliveryTracking> createState() {
    return _DeliveryTrackingState();
  }
}

class _DeliveryTrackingState extends State<DeliveryTracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: ListView(
        children: const [
          MyTimeLineTile(
            isFirst: true,
            isLast: false,
            isPast: true,
            eventCard: Text("Order Received"),
          ),
          MyTimeLineTile(
            isFirst: false,
            isLast: false,
            isPast: false,
            eventCard: Text("Order Shipped"),
          ),
          MyTimeLineTile(
            isFirst: false,
            isLast: true,
            isPast: false,
            eventCard: Text('Order Delivered'),
          ),
        ],
      ),
    ));
  }
}
