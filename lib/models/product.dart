import 'package:fruits_hub_dashboard/models/addition_info.dart';

class Product {
  final String title;
  final String desc;
  final num price;
  final num? discount;
  final num rateCount;
  final num avaRate;
  final String img;
  final AdditionInfo additionInfo;
  final bool isFeatured;
  final num soldTimes;

  Product({
    required this.title,
    required this.desc,
    required this.price,
    this.discount,
    this.rateCount = 0,
    this.avaRate = 0.0,
    required this.img,
    required this.additionInfo,
    this.isFeatured = false,
    this.soldTimes = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'price': price,
      'discount': discount,
      'rate_count': rateCount,
      'ava_rate': avaRate,
      'img': img,
      'addition_info': additionInfo,
      'is_featured': isFeatured,
      'sold_times': soldTimes,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      title: map['title'],
      desc: map['desc'],
      price: map['price'],
      discount: map['discount'] as num?,
      rateCount: map['rate_count'],
      avaRate: map['ava_rate'],
      img: map['img'],
      additionInfo: AdditionInfo.fromJson(map['addition_info']),
      isFeatured: map['is_featured'],
      soldTimes: map['sold_times'],
    );
  }
}
