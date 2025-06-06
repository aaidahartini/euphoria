//Import necessary FLutter package to use widgets and function
import 'package:flutter/material.dart';
import 'package:euphoria/detail_menu_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Euphoria',
      theme: ThemeData(
        primaryColor: Colors.brown,
        scaffoldBackgroundColor: Colors.brown[50],
        fontFamily: 'Roboto',
      ),
      home: const MyHomePage(title: "Euphoria Coffee"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.coffee, size: 150, color: Colors.brown[500]),

              const SizedBox(height: 20),

              Text(
                'Euphoria Coffee',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Brew it beautifully',
                style: TextStyle(fontSize: 16, color: Colors.brown[600]),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the next screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyMenuPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyMenuPage extends StatefulWidget {
  const MyMenuPage({super.key});

  @override
  State<MyMenuPage> createState() => _MyMenuPageState();
}

class _MyMenuPageState extends State<MyMenuPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Latte', 'price': 'RM5.00', 'imageFile': 'latte.jpg'},
    {'name': 'Cappuccino', 'price': 'RM5.00', 'imageFile': 'cappuccino.jpg'},
    {'name': 'Espresso', 'price': 'RM4.00', 'imageFile': 'espresso.jpg'},
    {'name': 'Black Coffee', 'price': 'RM4.00', 'imageFile': 'black.jpg'},
    {'name': 'Americano', 'price': 'RM4.00', 'imageFile': 'americano.jpg'},
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredItems =
        menuItems.where((item) {
          final name = item['name'].toString().toLowerCase();
          return name.contains(searchQuery.toLowerCase());
        }).toList();

    return Scaffold(
      backgroundColor: Colors.brown[600],
      appBar: AppBar(
        title: const Text("Euphoria Coffee Menu"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.brown,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for coffee',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 20),

            Expanded(
              child:
                  filteredItems.isEmpty
                      ? const Center(
                        child: Text(
                          'No coffee found.',
                          style: TextStyle(color: Colors.brown, fontSize: 18),
                        ),
                      )
                      : ListView.builder(
                        itemCount: menuItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return GestureDetector(
                            onTap: () {
                              //Navigation to page detail
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => DetailMenuPage(menuItem: item),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.brown[100],
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: Image.asset(
                                  'assets/images/${menuItems[index]['imageFile']}',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  item['name'],
                                  style: const TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Text(
                                  item['price'],
                                  style: const TextStyle(
                                    color: Colors.brown,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigation to orders cart page
        },
        backgroundColor: Colors.brown[200],
        child: const Icon(Icons.add_shopping_cart, color: Colors.white),
      ),
    );
  }
}
