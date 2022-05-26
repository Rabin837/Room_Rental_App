import 'package:flutter/material.dart';

class RentListWidget extends StatelessWidget {
  final String name;
  final int price;
  final image;
  final String location;
  const RentListWidget({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        color: Colors.white,
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Expanded(
                  child: Image.network(
                image
                
              ),
                  flex: 2,
                ),
              ),
            ),
            
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListTile(
                        title: Text(name),
                        subtitle: Text('Rs:$price'),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          TextButton(
                            child: Text('\u{1F4CD} $location'),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
      elevation: 8,
      shadowColor: Color.fromARGB(255, 179, 120, 33),
      margin: EdgeInsets.all(15),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Color.fromARGB(255, 165, 175, 76), width: 1)),
    );
  }
}
