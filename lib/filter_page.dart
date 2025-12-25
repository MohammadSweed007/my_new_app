import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? selectedProvince;
  String? selectedCity;
  String? selectedType;
  RangeValues priceRange = RangeValues(500, 5000);
  int rooms = 0;
  int bathrooms = 0;
  int livingRooms = 0;

  final List<String> provinces = ['دمشق', 'حلب', 'اللاذقية'];
  final List<String> cities = ['المزة', 'البرامكة', 'الصالحية'];
  final List<String> types = ['Apartment', 'House', 'Studio', 'Villa'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("فلترة الشقق"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'المحافظة'),
              items: provinces
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (v) => setState(() => selectedProvince = v),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'المدينة'),
              items: cities
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => selectedCity = v),
            ),
            SizedBox(height: 20),
            Text("السعر",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            RangeSlider(
              values: priceRange,
              min: 0,
              max: 10000,
              divisions: 100,
              labels: RangeLabels(
                "${priceRange.start.toInt()}",
                "${priceRange.end.toInt()}",
              ),
              onChanged: (values) {
                setState(() => priceRange = values);
              },
            ),
            SizedBox(height: 20),
            Text("نوع العقار",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 10,
              children: types.map((type) {
                return ChoiceChip(
                  label: Text(type),
                  selected: selectedType == type,
                  onSelected: (_) => setState(() => selectedType = type),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _counter("غرف", rooms, (v) => setState(() => rooms = v)),
                _counter(
                    "حمامات", bathrooms, (v) => setState(() => bathrooms = v)),
                _counter("صالونات", livingRooms,
                    (v) => setState(() => livingRooms = v)),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "province": selectedProvince,
                  "city": selectedCity,
                  "type": selectedType,
                  "minPrice": priceRange.start,
                  "maxPrice": priceRange.end,
                  "rooms": rooms,
                  "bathrooms": bathrooms,
                  "livingRooms": livingRooms,
                });
              },
              child: Text("تطبيق الفلترة"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _counter(String label, int value, Function(int) onChanged) {
    return Column(
      children: [
        Text(label),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => onChanged(value > 0 ? value - 1 : 0),
            ),
            Text("$value"),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => onChanged(value + 1),
            ),
          ],
        )
      ],
    );
  }
}
