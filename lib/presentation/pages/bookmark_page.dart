import 'package:flutter/material.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/common/state_enum.dart';
import 'package:food_store_app/presentation/pages/detail_page.dart';
import 'package:food_store_app/presentation/provider/bookmark_notifier.dart';
import 'package:food_store_app/presentation/widgets/card_restaruant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  static const ROUTE_NAME = "/bookmark-page";

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  Widget _buildDataNotFound() {
    return Center(
      child: LottieBuilder.asset(
        "assets/84854-empty.json",
        width: 200,
        height: 200,
      ),
    );
  }

  @override
  void initState() {
    Future.microtask(() => Provider.of<BookmarkNotifier>(context, listen: false)
        .fetchBookmarkRestaurant());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<BookmarkNotifier>(
        builder: (context, restaurant, child) {
          if (restaurant.bookmarkRestaurantState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (restaurant.bookmarkRestaurantState ==
              RequestState.Loaded) {
            if (restaurant.bookmarkRestaurant.isEmpty) {
              return _buildDataNotFound();
            } else {
              return ListView.builder(
                itemCount: restaurant.bookmarkRestaurant.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: margin,
                      vertical: 10,
                    ),
                    child: CardRestaurant(
                      restaurant: restaurant.bookmarkRestaurant[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailPage.ROUTE_NAME,
                          arguments: restaurant.bookmarkRestaurant[index].id,
                        ).then(
                          (value) => Future.microtask(
                            () => Provider.of<BookmarkNotifier>(context,
                                    listen: false)
                                .fetchBookmarkRestaurant(),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          } else {
            return Center(
              child: Text(restaurant.message),
            );
          }
        },
      ),
    );
  }
}
