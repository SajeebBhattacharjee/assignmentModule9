import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, int> itemCounts = {"Sweater": 1, "Jeans": 1, "Jacket": 1};
  double unitPrice = 52.0;

  void _incrementItem(String item) {
    setState(() {
      itemCounts[item] = itemCounts[item]! + 1;
    });
  }

  void _decrementItem(String item) {
    setState(() {
      itemCounts[item] = itemCounts[item]! > 0 ? itemCounts[item]! - 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount =
    itemCounts.values.fold(0, (previous, count) => previous + (count * unitPrice));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("My Bag", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildClothItem(
                    "Sweater",
                    "https://images.unsplash.com/photo-1610901157620-340856d0a50f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHN3ZWF0ZXJ8ZW58MHx8MHx8fDA%3D&w=1000&q=80",
                    "Green",
                  ),
                  _buildClothItem(
                    "Jeans",
                    "https://media.istockphoto.com/id/1070782274/photo/confidence-puts-any-outfit-together-perfectly.jpg?s=612x612&w=0&k=20&c=k3Yj_rpGO-dL6bi86GIhPTblYBqJP4uTrptrkI0lwC4=",
                    "Blue",
                  ),
                  _buildClothItem(
                    "Jacket",
                    "https://i.pinimg.com/originals/f5/b7/c9/f5b7c9cb18e1e7a3875ea179c1dc0c95.jpg",
                    "Black",
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(opacity: 0.6, child: Text("Total Amount")),
                Text("\$${totalAmount.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Congratulations on your checkout!")),
                );
              },
              child: Text("CHECK OUT"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(130),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildClothItem(String title, String imageUrl, String color) {
    Color clothColor;
    if (color == "Green") {
      clothColor = Colors.green;
    } else if (color == "Blue") {
      clothColor = Colors.blue;
    } else if (color == "Black") {
      clothColor = Colors.black;
    } else {
      clothColor = Colors.red;
    }

    return Column(
      children: [
        Container(
          height: 110,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Opacity(opacity: 0.6, child: Text("Color:")),
                            SizedBox(width: 5),
                            Text(color),
                            SizedBox(width: 20),
                            Opacity(opacity: 0.6, child: Text("Size:")),
                            SizedBox(width: 5),
                            Text("M"),
                          ],
                        ),
                        Row(
                          children: [
                            _buildCircleIcon(Icons.remove, () => _decrementItem(title)),
                            SizedBox(width: 10),
                            Text("${itemCounts[title]}", style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 10),
                            _buildCircleIcon(Icons.add, () => _incrementItem(title)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Opacity(
                          opacity: 0.6,
                          child: Icon(
                            Icons.more_vert,
                            size: 32,
                          ),
                        ),
                        Text("\$${(unitPrice * itemCounts[title]!).toStringAsFixed(2)}",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCircleIcon(IconData iconData, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 12,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(child: Icon(iconData, color: Colors.black.withOpacity(0.75), size: 22)),
      ),
    );
  }
}
