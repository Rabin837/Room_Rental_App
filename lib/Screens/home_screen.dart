import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_rental/Screens/list_view.dart';
import 'package:home_rental/controllers/data_controller.dart';
import 'package:home_rental/widgets/navigation_drawer_widget.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:home_rental/Models/Datamodel/PlaceModel.dart';
import 'package:home_rental/Models/ViewModel/BestOffer.dart';
import 'package:home_rental/Models/constants.dart';
import 'search_rooms.dart';

final GlobalKey<ScaffoldState> scafoldkey = new GlobalKey();
enum MenuItem {
  item1,
  item2,
  item3,
  item4,
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataController controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldkey,
      drawer: AppDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            shrinkWrap: true,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(5, 5),
                          )
                        ],
                      ),
                      child: (IconButton(
                          onPressed: () {
                            scafoldkey.currentState!.openDrawer();
                          },
                          icon: Icon(Icons.home_work_rounded))),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            color: Colors.black.withOpacity(0.4),
                            offset: Offset(-5, 10),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image(
                          fit: BoxFit.fill,
                          width: 55,
                          image: AssetImage('asset/images/mee.jpg'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Hey! ${controller.userProfileData['userName']}',
                style: GoogleFonts.architectsDaughter(
                  fontSize: 28,
                  color: Color.fromARGB(255, 97, 91, 91),
                ),

                /* style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),*/
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(5, 5),
                            )
                          ],
                        ),
                        //search option yaa xa

                        child: ElevatedButton(
                          onPressed: () {
                            showSearch(
                                context: context, delegate: ProductSearch());
                          },
                          child: Container(
                            color: Color(0xffF3F4F8),
                            padding: EdgeInsets.all(28.0),
                            child: Row(
                              children: [
                                Icon(Icons.search),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('Search'),
                              ],
                            ),

                            //decoration: BoxDecoration(),
                          ),
                        ),

                        //search optionn sakyo
                        //icon
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              color: Colors.black.withOpacity(0.4),
                              offset: Offset(-5, 10),
                            )
                          ],
                        ),
                        child: PopupMenuButton<MenuItem>(
                          onSelected: (Value) {
                            if (Value == MenuItem.item1) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ProductList(),
                              )); // MaterialPageRoute
                            } else if (Value == MenuItem.item2) {
                              // Clicked "Item 2"

                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: MenuItem.item1,
                              child: Text('Sort By Price'),
                            ), // PopupMenuItem
                            PopupMenuItem(
                              value: MenuItem.item2,
                              child: Text('Back'),
                            ), // PopupMenuItem
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 51),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recently Added",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 350,
                //width: 400,
                //padding: EdgeInsets.all(15),

                child: GetBuilder<DataController>(
                  builder: (controller) => controller.allProduct.isEmpty
                      ? Center(
                          child: Text('😔 NO DATA FOUND (: 😔'),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: false,
                          itemCount: controller.allProduct.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Container(
                                width: 300,
                                height: 380,
                                decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(32),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.grey.withOpacity(0.5),
                                      offset: Offset(3, 5),
                                    ),
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.grey.withOpacity(0.5),
                                      offset: Offset(-3, 0),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 150,
                                        width: 380,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          child: Image.network(
                                            controller
                                                .allProduct[index].productimage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "  ${controller.allProduct[index].productname}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              'RS: ${controller.allProduct[index].productprice.toString()}/',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Container(
                                              height: 30,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    " \u{1F6CC} 5",
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: Container(
                                              height: 30,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(" \u{1F4FA} 5")
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: Container(
                                              height: 30,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(" \u{1F374} 2")
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              " \u{1F4CD} ${controller.allProduct[index].locationdata}",
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Color.fromARGB(
                                                    202, 22, 20, 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 55,
                                          vertical: 1,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () => launch(
                                                    "tel:${controller.allProduct[index].phonenumber.toString()}"),
                                                child: Text('CALL'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
              /*
              Container(
                height: 350,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: false,
                  children: [
                    RecentAdded(
                      placeModel: placeCollection[0],
                    ),
                    RecentAdded(
                      placeModel: placeCollection[1],
                    ),
                  ],
                ),
              ),
              */
              SizedBox(height: 50),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Best Offer ✨",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                        // color: Colors.black54,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              BestOffer(
                placeModel: placeCollection[3],
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}







/*
body: GetBuilder<DataController>(
        builder: (controller) => controller.allProduct.isEmpty
            ? Center(
                child: Text('😔 NO DATA FOUND (: 😔'),
              )
            : ListView.builder(
                itemCount: controller.allProduct.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.network(
                            controller.allProduct[index].productimage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Product Name: ${controller.allProduct[index].productname}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Price: ${controller.allProduct[index].productprice.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => launch(
                                      "tel:${controller.allProduct[index].phonenumber.toString()}"),
                                  child: Text('CALL'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),

*/
