import 'package:flutter/material.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/common/state_enum.dart';
import 'package:food_store_app/presentation/pages/detail_page.dart';
import 'package:food_store_app/presentation/pages/search_page.dart';
import 'package:food_store_app/presentation/provider/restaurant_notifer.dart';
import 'package:food_store_app/presentation/widgets/card_restaruant.dart';
import 'package:food_store_app/presentation/widgets/card_tile_restaurant.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = "/home-page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.microtask(
      () => Provider.of<RestaurantNotifier>(
        context,
        listen: false,
      ).fetchRestaurant(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildRecomendedRestaurant() {
      return Consumer<RestaurantNotifier>(
        builder: (context, data, child) {
          if (data.restaurantState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.restaurantState == RequestState.Loaded) {
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
                      restaurant: data.restaurant[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailPage.ROUTE_NAME,
                          arguments: data.restaurant[index].id,
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(child: Text(data.message));
          }
        },
      );
    }

    Widget _buildCardListTile() {
      return Consumer<RestaurantNotifier>(
        builder: (context, restaurant, child) {
          if (restaurant.restaurantState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (restaurant.restaurantState == RequestState.Loaded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: Column(
                children: restaurant.restaurant.map(
                  (e) {
                    return CardTileRestaurant(
                      restaurant: e,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailPage.ROUTE_NAME,
                          arguments: e.id,
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            );
          } else {
            return Center(child: Text(restaurant.message));
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
