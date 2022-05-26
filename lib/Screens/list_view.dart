import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_rental/controllers/data_base_manager.dart';
import 'package:home_rental/widgets/rent_list_widget.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool isAscending = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sort By price'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  
                  onPressed: () {
                    print(isAscending);
                    setState(() {
                      isAscending = !isAscending;
                    });
                  },
                  icon: isAscending
                      ? const Icon(Icons.arrow_circle_down)
                      : const Icon(Icons.arrow_circle_up))
            ],
          ),
          Flexible(
            child: StreamBuilder(
              stream: DatabaseManager.pickStream(isAscending),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final value = snapshot.data!.docs;

                return value.isEmpty
                    ? const Center(
                        child: Text('No rent available'),
                      )
                    : pickListViewBuilder(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView pickListViewBuilder(List<QueryDocumentSnapshot<Object?>> value) {
    return ListView.builder(
      itemCount: value.length,
      itemBuilder: (context, i) => RentListWidget(
        name: value[i]["product_name"],
        price: value[i]["product_price"],
        image: value[i]["product_image"],
        location: value[i]["location_data"],
      ),
    );
  }
}
