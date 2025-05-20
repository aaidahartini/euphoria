import 'package:flutter/material.dart';

class DetailMenuPage extends StatefulWidget {
  final Map<String, dynamic> menuItem;

  const DetailMenuPage({super.key, required this.menuItem});

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  String? orderMethod;
  String? drinkType;
  String? drinkSize;
  String? iceLevel;
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity(){
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  Widget buildOptionSelector({
    required String label,
    required List<String> options,
    required String? selected,
    required void Function(String?) onSelected,
  }){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
                label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                ),
            ),
            const SizedBox(height: 8),
        ]
    )
  }
}
