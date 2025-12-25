import 'package:flutter/material.dart';

class AddApartmentPage extends StatefulWidget {
  @override
  _AddApartmentPageState createState() => _AddApartmentPageState();
}

class _AddApartmentPageState extends State<AddApartmentPage> {
  String? selectedProvince;
  String? selectedCity;
  String? selectedFloor;
  String? propertyType;
  int rooms = 0;
  int bathrooms = 0;
  int livingRooms = 0;
  List<String> amenities = [];
  TextEditingController priceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final List<String> provinces = ['دمشق', 'حلب', 'اللاذقية'];
  final List<String> cities = ['المزة', 'البرامكة', 'الصالحية'];
  final List<String> floors = ['أرضي', 'أول', 'ثاني', 'ثالث'];
  final List<String> propertyTypes = [
    'Apartment',
    'House',
    'Studio',
    'Villa',
    'Other'
  ];
  final List<String> allAmenities = [
    'Parking',
    'Balcony',
    'Air Conditioning',
    'Elevator',
    'Pet Friendly',
    'Swimming Pool'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Apartment')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Photos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              height: 120,
              color: Colors.grey[300],
              child: Center(child: Text('Photo Picker Placeholder')),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Province'),
              items: provinces
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (val) => setState(() => selectedProvince = val),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'City'),
              items: cities
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (val) => setState(() => selectedCity = val),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Price (\$)'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'm²'),
                    items: ['50', '100', '150', '200']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Property Type',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 10,
              children: propertyTypes.map((type) {
                return ChoiceChip(
                  label: Text(type),
                  selected: propertyType == type,
                  onSelected: (_) => setState(() => propertyType = type),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _counter('Rooms', rooms, (v) => setState(() => rooms = v)),
                _counter('Bathrooms', bathrooms,
                    (v) => setState(() => bathrooms = v)),
                _counter('Living Rooms', livingRooms,
                    (v) => setState(() => livingRooms = v)),
              ],
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Floor'),
              items: floors
                  .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                  .toList(),
              onChanged: (val) => setState(() => selectedFloor = val),
            ),
            SizedBox(height: 20),
            Text('Amenities', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 10,
              children: allAmenities.map((amenity) {
                return FilterChip(
                  label: Text(amenity),
                  selected: amenities.contains(amenity),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        amenities.add(amenity);
                      } else {
                        amenities.remove(amenity);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: '+963 Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: Center(child: Text('Submit')),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50)),
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
                onPressed: () => onChanged(value > 0 ? value - 1 : 0)),
            Text('$value'),
            IconButton(
                icon: Icon(Icons.add), onPressed: () => onChanged(value + 1)),
          ],
        )
      ],
    );
  }
}
