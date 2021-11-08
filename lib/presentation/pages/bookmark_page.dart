import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/domain/entities/restaurant_detail.dart';
import 'package:food_store_app/presentation/pages/detail_page.dart';
import 'package:food_store_app/presentation/provider/bookmark_notifier.dart';
import 'package:food_store_app/presentation/widgets/card_restaruant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatelessWidget {
  static const ROUTE_NAME = "/bookmark-page";

  Widget _buildDataNotFound() {
    return Center(
      child: LottieBuilder.asset(
        "assets/trash.json",
        width: 200,
        height: 200,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BookmarkNotifer _bookmarkNotifer = Provider.of<BookmarkNotifer>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bookmark Page",
          style: kHeading6.copyWith(
            color: kBlack,
          ),
        ),
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: kWhite,
      ),
      body: _bookmarkNotifer.bookmark.isEmpty
          ? _buildDataNotFound()
          : ListView.builder(
              itemCount: _bookmarkNotifer.bookmark.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: margin,
                    vertical: 10,
                  ),
                  child: CardRestaurantBookmark(
                    restaurant: _bookmarkNotifer.bookmark[index],
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailPage.ROUTE_NAME,
                        arguments: _bookmarkNotifer.bookmark[index].id,
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class CardRestaurantBookmark extends StatelessWidget {
  final RestaurantDetail? restaurant;
  final Function? onTap;

  CardRestaurantBookmark({
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 46,
                width: 46,
                imageUrl: "$IMAGE_BASE_URL${restaurant!.pictureId}",
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
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
