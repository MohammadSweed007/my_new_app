import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  final int apartmentId;

  RatingPage({required this.apartmentId});

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double rating = 0;
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تقييم الشقة"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // العنوان الأول على اليمين فقط
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "كم تقييم هذه الشقة؟",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 20),

            // النجوم تبدأ من اليسار
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 35,
                    ),
                    onPressed: () {
                      setState(() {
                        rating = index + 1.0;
                      });
                    },
                  );
                }),
              ),
            ),

            SizedBox(height: 30),

            // العنوان الثاني على اليمين فقط
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                ": اكتب تعليقك",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 10),

            // الكتابة داخل الحقل من اليمين
            TextField(
              controller: commentController,
              maxLines: 5,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: "...اكتب رأيك عن الشقة",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final ratingData = {
                    "apartment_id": widget.apartmentId,
                    "rating": rating,
                    "comment": commentController.text,
                  };

                  Navigator.pop(context, ratingData);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text("إرسال التقييم"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
