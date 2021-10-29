import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/model/restaurant_model.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant? restaurant;
  final Function? onTap;
  final bool? isBookmark;

  CardRestaurant({
    required this.restaurant,
    required this.onTap,
    required this.isBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: 179,
        width: 257,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffF6F6F6),
        ),
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    height: 46,
                    width: 46,
                    imageUrl: restaurant!.pictureId,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
                Icon(
                  isBookmark! ? Icons.bookmark : Icons.bookmark_border_outlined,
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
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
            SizedBox(
              height: 10,
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
                  itemSize: 24,
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
    );
  }
}
