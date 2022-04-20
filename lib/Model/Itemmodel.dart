class productdb {
  final int? id;
  final String name;
  final String price;
  final String quantity;
  final String brand;
  final String totalprice;
  productdb(
      { this.id,
        required this.name,
        required this.price,
        required this.quantity,
        required this.brand,
        required this.totalprice
      });

  productdb.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        price = res["price"],
        quantity = res["qty"],
        brand = res["brand"],
        totalprice = res["totalrice"];


  Map<String, Object?> toMap() {
    return {'id':id,'name': name,'price':price,'qty':quantity,'brand':brand,'totalrice':totalprice};
  }
}