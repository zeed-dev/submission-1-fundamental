import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/model/restaurant_model.dart';
import 'package:food_store_app/presentation/pages/detail_page.dart';
import 'package:food_store_app/presentation/provider/bookmark_notifier.dart';
import 'package:food_store_app/presentation/widgets/card_restaruant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = "/serach-page";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  bool isSearch = false;
  List<Restaurant> _dataList = [];
  String _query = "";

  _SearchPageState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          isSearch = false;
          _query = "";
        });
      } else {
        setState(() {
          isSearch = true;
          _query = _searchController.text;
        });
      }
    });
  }

  Widget _buildTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search Restaurant",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.search,
      ),
    );
  }

  Widget _buildSeraching({required BuildContext context}) {
    BookmarkNotifer bookmarkNotifer = Provider.of<BookmarkNotifer>(context);

    List<Restaurant> _filterList = [];

    for (var i = 0; i < _dataList.length; i++) {
      var _data = _dataList[i];
      if (_data.name.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(_data);
      }
    }

    return _filterList.isEmpty
        ? Container(
            margin: EdgeInsets.only(top: 50),
            child: Center(
              child: LottieBuilder.asset(
                "assets/trash.json",
                width: 200,
                height: 200,
              ),
            ),
          )
        : Expanded(
            child: ListView.builder(
              itemCount: _filterList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: margin,
                    vertical: 10,
                  ),
                  child: CardRestaurant(
                    isBookmark: bookmarkNotifer.isBookmark(_filterList[index]),
                    restaurant: _filterList[index],
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailPage.ROUTE_NAME,
                        arguments: _filterList[index],
                      );
                    },
                  ),
                );
              },
            ),
          );
  }

  @override
  void initState() {
    getDataRestaurant();
    super.initState();
  }

  Future<void> getDataRestaurant() async {
    var data = await DefaultAssetBundle.of(context).loadString(
      "assets/data.json",
    );
    final List<Restaurant> restaurants = restaurantsParse(data);

    for (var item in restaurants) {
      _dataList.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    BookmarkNotifer bookmarkNotifer = Provider.of<BookmarkNotifer>(context);

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
            FutureBuilder<String>(
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

                  return isSearch
                      ? _buildSeraching(context: context)
                      : Expanded(
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: margin,
                                  vertical: 10,
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
                  return Center(
                    child: Text("Opps something worng!"),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
