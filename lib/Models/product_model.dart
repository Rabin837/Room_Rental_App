class Product {
  final String productname;
  final int productprice;
  final String productuploaddate;
  final String productimage;
  final String userId;
  final int phonenumber;
  final String productId;
  final String locationdata;
  final double lattitude;
  final double longitude;

  Product(
      {required this.productname,
      required this.productprice,
      required this.productuploaddate,
      required this.userId,
      required this.productimage,
      required this.phonenumber,
      required this.productId,
      required this.locationdata,
      required this.lattitude,
      required this.longitude});
}
