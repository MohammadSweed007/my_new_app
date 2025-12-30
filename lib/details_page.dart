import 'package:flutter/material.dart';
import 'rating_page.dart'; // تأكد تضيف الاستيراد

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> apt;

  const DetailsPage({required this.apt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(apt["title"]),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              apt["image"],
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عنوان الشقة
                  Text(
                    apt["title"],
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  // السعر
                  Text(
                    "السعر: ${apt["price"]}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 10),

                  // عدد الغرف
                  Text(
                    "عدد الغرف: ${apt["rooms"]}",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 20),

                  // الوصف
                  Text(
                    apt["description"],
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 25),

                  // عنوان صور الموقع
                  Text(
                    "صور الموقع:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 12),

                  // صور الموقع
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: apt["locations"].map<Widget>((path) {
                        return Container(
                          margin: EdgeInsets.only(right: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              path,
                              width: 150,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 30),

                  // زر تقييم الشقة
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              RatingPage(apartmentId: apt["id"] ?? 0),
                        ),
                      );

                      if (result != null) {
                        print("Rating Data: $result");
                        // هون الفرونت بيرسل البيانات للـ Laravel
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text("تقييم الشقة"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
