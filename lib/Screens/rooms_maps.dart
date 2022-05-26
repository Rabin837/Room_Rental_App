import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserRoomMarker extends StatefulWidget {
  const UserRoomMarker({Key? key}) : super(key: key);

  @override
  State<UserRoomMarker> createState() => _UserRoomMarkerState();
}

class _UserRoomMarkerState extends State<UserRoomMarker> {
  final List<Map<String, dynamic>> clityList = const [
    {
      "address": "Pokhara bazar",
      "id": "pokhara_01",
      "image":
          "https://www.indiantempletour.com/wp-content/uploads/2018/10/Kathmandu-Pokhara-Tour.jpg",
      "lat": 28.237988,
      "lng": 83.995590,
      "name": "Pokhara Nepal",
      "phone": "9861294999",
      "region": "Asia"
    },
    {
      "address": "Kathmandu",
      "id": "kathmandu_02",
      "image":
          "https://assets-cdn.kathmandupost.com/uploads/source/Website%20Pages/about-us-thekathmandupost-boudha.jpg",
      "lat": 27.717245,
      "lng": 85.323959,
      "name": "Kathmandu Nepal",
      "phone": "9861294999",
      "region": "Asia"
    },
    {
      "address": "Biratnagar",
      "id": "mumbai_03",
      "image":
          "https://www.sasec.asia/uploads/news/2018/biratnagar-gate-news.jpg",
      "lat": 26.452475,
      "lng": 87.271782,
      "name": "Biratnagar Nepal",
      "phone": "9861294999",
      "region": "Asia"
    },
    {
      "address": "Mustang",
      "id": "Musatang_04",
      "image":
          "https://cdn.kimkim.com/files/a/content_articles/featured_photos/5a193d2d43b3703410525ad95ef9cd065c9d92c6/big-22755a386af7fb4c78c668c102c0397d.jpg",
      "lat": 28.9481332,
      "lng": 83.900569,
      "name": "Mustang Nepal",
      "phone": "9861294999",
      "region": "Asia"
    },
    {
      "address": "Jumla",
      "id": "jumla_5",
      "image": "https://myrepublica.nagariknetwork.com/uploads/media/10.jpg",
      "lat": 29.2388968,
      "lng": 82.1979992,
      "name": "Nepal",
      "phone": "9861294999",
      "region": "Asia"
    }
  ];

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _markers.clear();
    setState(() {
      for (final office in clityList) {
        print("For Loop");
        final marker = Marker(
          markerId: MarkerId(office['name']),
          position: LatLng(office['lat'], office['lng']),
          infoWindow: InfoWindow(
              title: office['name'],
              snippet: office['address'],
              onTap: () {
                print("${office['lat']}, ${office['lng']}");
              }),
          onTap: () {
            print("Clicked on marker");
          },
        );
        print("${office['lat']}, ${office['lng']}");
        _markers[office['name']] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(26.912434, 75.787270),
        zoom: 4.8,
      ),
      markers: _markers.values.toSet(),
    );
  }
}
