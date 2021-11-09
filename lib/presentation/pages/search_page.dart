import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/common/state_enum.dart';
import 'package:food_store_app/presentation/pages/detail_page.dart';
import 'package:food_store_app/presentation/provider/search_restaurant_notifier.dart';
import 'package:food_store_app/presentation/widgets/card_tile_restaurant.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = "/serach-page";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Logger _logger = Logger();

  Widget _buildDataNotFound() {
    return Center(
      child: LottieBuilder.asset(
        "assets/84854-empty.json",
        width: 200,
        height: 200,
      ),
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin),
      child: TextField(
        onSubmitted: (query) {
          _logger.d(query);
          Provider.of<SearechRestaurantNotifier>(context, listen: false)
              .fetchSearchRestaurant(query);
        },
        decoration: InputDecoration(
          hintText: "Search Restaurant",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.search,
      ),
    );
  }

  _buildSearchResult() {
    return Consumer<SearechRestaurantNotifier>(
      builder: (context, restaurant, child) {
        if (restaurant.serachState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (restaurant.serachState == RequestState.Loaded) {
          if (restaurant.serach.isEmpty) {
            return Expanded(
              child: Container(
                child: _buildDataNotFound(),
              ),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: restaurant.serach.length,
                itemBuilder: (context, index) {
                  return CardTileRestaurant(
                    restaurant: restaurant.serach[index],
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailPage.ROUTE_NAME,
                        arguments: restaurant.serach[index].id,
                      );
                    },
                  );
                },
              ),
            );
          }
        } else {
          return Center(
            child: Text(restaurant.message),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Serach Page",
          style: kHeading6.copyWith(
            color: kBlack,
          ),
        ),
        elevation: 1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: kBlack,
          ),
        ),
        backgroundColor: kWhite,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            _buildTextField(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: Text(
                "Search Result",
                style: kSubtitle,
              ),
            ),
            _buildSearchResult(),
          ],
        ),
      ),
    );
  }
}
