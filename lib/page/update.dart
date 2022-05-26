import 'package:flutter/material.dart';

class sorting extends StatefulWidget {
  //final DataController controller = Get.put(DataController());

  @override
  _sortingState createState() => _sortingState();
}

class _sortingState extends State<sorting> {
  bool isDescending = false;

  List<String> items = [
    '3',
    'Emma',
    'Lucas',
    'Murphy',
    'Oliver',
    '5',
    'Zahara',
  ];
  //${controller.allProduct[index].productprice.toString()}/',

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Sorting'),
          centerTitle: true,
        ), // AppBar
        body: Column(
          
          children: [
            TextButton.icon(
              icon: RotatedBox(
                quarterTurns: 1,
                child: Icon(Icons.compare_arrows, size: 28),
              ), // RotatedBox
              label: Text(
                isDescending ? 'Descending' : 'Ascending',
                style: TextStyle(fontSize: 16),
              ), // Text
              onPressed: () => setState(() => isDescending = !isDescending),
            ),
            Expanded(child: buildList()),
          ],
        ),
      );

  Widget buildList() => ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final sortedItems = items
            ..sort((item1, item2) =>
                isDescending ? item2.compareTo(item1) : item1.compareTo(item2));

          final item = sortedItems[index];

          return ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                'https://source.unsplash.com/random?sig=$index',
              ), // NetworkImage
            ), // CircleAvatar
            title: Text(item),
            subtitle: Text('Subtitle $index'),
            onTap: () {},
          ); //
        },
      );
}
