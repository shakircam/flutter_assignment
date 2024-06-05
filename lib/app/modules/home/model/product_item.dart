class ProductItem {
  final int id;
  final String name;
  final String shortDescription;
  final String price;
  final String regularPrice;
  final String salePrice;
  final String averageRating;
  final String dateCreated;
  final int ratingCount;
  final int totalSales;
  final List<Images> images;

  ProductItem(
      {required this.id,
      required this.name,
      required this.shortDescription,
      required this.price,
      required this.regularPrice,
      required this.salePrice,
      required this.averageRating,
      required this.ratingCount,
      required this.images,
      required this.dateCreated,
      required this.totalSales});

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    var imageList = json['images'] as List;
    List<Images> images = imageList.map((i) => Images.fromJson(i)).toList();

    return ProductItem(
      id: json['id'],
      name: json['name'],
      shortDescription: json['short_description'],
      price: json['price'],
      regularPrice: json['regular_price'],
      salePrice: json['sale_price'],
      averageRating: json['average_rating'],
      ratingCount: json['rating_count'],
      dateCreated: json['date_created'],
      totalSales: json['total_sales'],
      images: images,
    );
  }
}

class Images {
  final String src;

  Images({required this.src});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      src: json['src'],
    );
  }
}
