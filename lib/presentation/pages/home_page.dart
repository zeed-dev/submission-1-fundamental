import 'package:flutter/material.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/model/restaurant_model.dart';
import 'package:food_store_app/presentation/pages/detail_page.dart';
import 'package:food_store_app/presentation/pages/search_page.dart';
import 'package:food_store_app/presentation/provider/bookmark_notifier.dart';
import 'package:food_store_app/presentation/widgets/card_restaruant.dart';
import 'package:food_store_app/presentation/widgets/card_tile_restaurant.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const ROUTE_NAME = "/home-page";

  @override
  Widget build(BuildContext context) {
    BookmarkNotifer bookmarkNotifer = Provider.of<BookmarkNotifer>(context);

    Widget _buildCardListTile() {
      return FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString(
          "assets/data.json",
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            final List<Restaurant> restaurants = restaurantsParse(
              snapshot.data,
            );
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: Column(
                children: restaurants.map(
                  (e) {
                    return CardTileRestaurant(
                      restaurant: e,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailPage.ROUTE_NAME,
                          arguments: e,
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            );
          } else {
            return Text("Opps something worng!");
          }
        },
      );
    }

    Widget _buildRecomendedRestaurant() {
      return FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString(
          "assets/data.json",
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            final List<Restaurant> restaurants = restaurantsParse(
              snapshot.data,
            );
            return Container(
              height: 179,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      left: index == 0 ? margin : 0,
                      right: index == 3 ? 0 : margin,
                    ),
                    child: CardRestaurant(
                      isBookmark: bookmarkNotifer.isBookmark(
                        restaurants[index],
                      ),
                      restaurant: restaurants[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailPage.ROUTE_NAME,
                          arguments: restaurants[index],
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            return Text("Opps something worng!");
          }
        },
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello,",
                        style: kHeading6.copyWith(
                          fontSize: 20,
                          color: kGreySecondary,
                        ),
                      ),
                      Text(
                        "Dicoding!",
                        style: kHeading4,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
                    },
                    icon: Icon(
                      Icons.search,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: Text(
                "Recommended for you",
                style: kHeading6.copyWith(
                  fontSize: 20,
                  color: kBlack,
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            _buildRecomendedRestaurant(),
            SizedBox(
              height: 28,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: Text(
                "Nearby Restaurant",
                style: kHeading6.copyWith(
                  fontSize: 20,
                  color: kBlack,
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            _buildCardListTile(),
          ],
        ),
      ),
    );
  }
}
