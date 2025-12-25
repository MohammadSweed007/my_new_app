import 'package:flutter/material.dart';
import 'details_page.dart';
import 'add_apartment_page.dart';
import 'filter_page.dart';

class ApartmentsPage extends StatefulWidget {
  @override
  _ApartmentsPageState createState() => _ApartmentsPageState();
}

class _ApartmentsPageState extends State<ApartmentsPage> {
  List<Map<String, dynamic>> apartments = [
    {
      "title": "شقة 1",
      "image": "assets/images/shaqa1.jpg",
      "price": 1200,
      "rooms": 3,
      "description": "شقة واسعة ومناسبة للعائلات.",
      "locations": [
        "assets/images/mwqea1.jpg",
        "assets/images/mwqea2.jpg",
        "assets/images/mwqea3.jpg",
      ]
    },
    {
      "title": "شقة 2",
      "image": "assets/images/shaqa2.jpg",
      "price": 900,
      "rooms": 2,
      "description": "شقة مريحة وقريبة من الخدمات.",
      "locations": [
        "assets/images/mwqea1.jpg",
        "assets/images/mwqea2.jpg",
        "assets/images/mwqea3.jpg",
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الشقق المتاحة"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () async {
              final filters = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FilterPage()),
              );

              if (filters != null) {
                print("Filters: $filters");
              }
            },
          )
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: apartments.length,
        itemBuilder: (context, index) {
          final apt = apartments[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsPage(apt: apt),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      apt["image"],
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      apt["title"],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddApartmentPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
