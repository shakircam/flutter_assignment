import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/values/app_colors.dart';
import 'package:flutter_assessment/app/core/values/app_icons.dart';
import 'package:flutter_assessment/app/core/widget/image/asset_image_view.dart';
import 'package:flutter_assessment/app/modules/home/model/product_item.dart';
import 'package:flutter_assessment/app/modules/home/widget/star_rating.dart';

class ProductCard extends StatelessWidget {
  final ProductItem product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _image(),
          ),
          Container(
            decoration: const BoxDecoration(color: AppColors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorBlack),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    product.regularPrice,
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    product.price,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: AppColors.colorBlack),
                  ),
                  const SizedBox(height: 4.0),
                  StarRating(rating: product.ratingCount),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _image() => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
        child: Image.network(
          product.images.first.src,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return const AssetImageView(
              fileName: AppIcons.placeholder,
            );
          },
        ),
      );
}
