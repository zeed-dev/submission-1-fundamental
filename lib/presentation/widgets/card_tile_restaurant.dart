import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';

class CardTileRestaurant extends StatelessWidget {
  final Restaurant? restaurant;
  final Function? onTap;

  CardTileRestaurant({
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffF6F6F6),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 68,
                width: 68,
                imageUrl: "$IMAGE_BASE_URL${restaurant!.pictureId}",
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                ),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant!.name,
                    style: kSubtitle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    restaurant!.description,
                    maxLines: 2,
                    style: kBodyText,
                  ),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: restaurant!.rating,
                        itemCount: 5,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Color(0xFFffc300),
                        ),
                        itemSize: 15,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "-",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          restaurant!.city,
                          overflow: TextOverflow.ellipsis,
                          style: kBodyText,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
