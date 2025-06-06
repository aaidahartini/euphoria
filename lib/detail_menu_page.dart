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

  void decrementQuantity() {
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
  }) {
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
        Wrap(
          spacing: 12,
          children:
              options.map((option) {
                final isSelected = selected == option;
                return ChoiceChip(
                  label: Text(
                    option,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.brown,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) => onSelected(option),
                  selectedColor: Colors.brown[800],
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.menuItem;

    return Scaffold(
      backgroundColor: Colors.brown[500],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.brown,
        title: Text(item['name'] ?? 'Menu Detail'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/${widget.menuItem['imageFile'] ?? 'default.jpg'}',
                height: 700,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),

            buildOptionSelector(
              label: "How would you like to order it?",
              options: ["Dine In", "To Go"],
              selected: orderMethod,
              onSelected: (val) => setState(() => orderMethod = val),
            ),

            buildOptionSelector(
              label: "Drink Type",
              options: ["Hot", "Iced"],
              selected: drinkType,
              onSelected: (val) {
                setState(() {
                  drinkType = val;
                  drinkSize = null;
                  iceLevel = null;
                });
              },
            ),
            if (drinkType == "Hot") ...[
              buildOptionSelector(
                label: "Drink Size",
                options: ["Small (60ml)", "Medium (120ml)"],
                selected: drinkSize,
                onSelected: (val) => setState(() => drinkSize = val),
              ),
            ] else if (drinkType == "Iced") ...[
              buildOptionSelector(
                label: "Drink Size",
                options: ["Medium (350ml)", "Large(500ml)"],
                selected: drinkSize,
                onSelected: (val) => setState(() => drinkSize = val),
              ),
              buildOptionSelector(
                label: "Ice Level",
                options: ["Less Ice", "Normal Ice", "Extra Ice"],
                selected: iceLevel,
                onSelected: (val) => setState(() => iceLevel = val),
              ),
            ],

            const Text(
              "Quantity",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: decrementQuantity,
                  icon: const Icon(Icons.remove),
                  color: Colors.white,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.brown[800],
                  ),
                ),
                Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                IconButton(
                  onPressed: incrementQuantity,
                  icon: const Icon(Icons.add),
                  color: Colors.white,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.brown[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[800],
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            "Add To Orders",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
