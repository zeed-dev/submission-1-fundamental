import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/common/state_enum.dart';
import 'package:food_store_app/domain/entities/customer_review.dart';
import 'package:food_store_app/domain/entities/drink.dart';
import 'package:food_store_app/domain/entities/restaurant_detail.dart';
import 'package:food_store_app/presentation/provider/bookmark_notifier.dart';
import 'package:food_store_app/presentation/provider/restaurant_detail_notifier.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class DetailPage extends StatefulWidget {
  static const ROUTE_NAME = "/detail-page";
  final String id;

  DetailPage({
    required this.id,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<RestaurantDetailNotifier>(context, listen: false)
            .fetchDetailRestaurant(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BookmarkNotifer _bookmarkNotifer = Provider.of<BookmarkNotifer>(context);

    void _clearController() {
      nameController.clear();
      reviewController.clear();
    }

    Widget _buildHeader(RestaurantDetail restaurant) {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 256,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: 230,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: "$IMAGE_BASE_URL${restaurant.pictureId}",
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: kWhite,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: "$IMAGE_BASE_URL${restaurant.pictureId}",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                    ),
                  ),
                ),
                height: 100,
                width: 100,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: kWhite,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Share.share(
                        "$IMAGE_BASE_URL${restaurant.pictureId} \n\n${restaurant.name}\n\nRating: ${restaurant.rating} - ${restaurant.city} \n\n${restaurant.description}",
                      );
                    },
                    icon: Icon(
                      Icons.share,
                      color: kWhite,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildMenuItems(List<Drink> data) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: Column(
            children: data.map((e) {
          return Row(
            children: [
              Image.asset(
                "assets/ellipse.png",
                width: 8,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                e.name,
                style: kSubtitle,
              )
            ],
          );
        }).toList()),
      );
    }

    Widget _buildReviewItems(List<CustomerReview> data) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: Column(
            children: data.map((e) {
          return Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Image.asset(
                  "assets/ellipse.png",
                  width: 8,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.name,
                        style: kSubtitle.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        e.review,
                        style: kSubtitle,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList()),
      );
    }

    Widget _buildTextField() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: margin, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: reviewController,
              decoration: InputDecoration(
                hintText: "Add Review's",
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.newline,
              minLines: 2,
              maxLines: 2,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    }

    Widget _customBottomNavbarDetail(RestaurantDetail restaurant) {
      return Container(
        height: 70,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: margin),
        decoration: BoxDecoration(
          color: kWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                _bookmarkNotifer.setRestaurant(restaurant);
                Flushbar(
                  message: _bookmarkNotifer.isBookmark(restaurant)
                      ? "Has been added to the Wishlist"
                      : "Has been removed from the Wishlist",
                  duration: Duration(seconds: 3),
                  backgroundColor: _bookmarkNotifer.isBookmark(restaurant)
                      ? Colors.blue
                      : Colors.red,
                ).show(context);
              },
              child: Container(
                width: 59,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _bookmarkNotifer.isBookmark(restaurant)
                      ? Icons.bookmark
                      : Icons.bookmark_outline,
                  color: kGrey,
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () {
                showPlatformDialog(
                  context: context,
                  builder: (context) => BasicDialogAlert(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Review's"),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    content: Container(
                      height: 300,
                      width: 300,
                      child: ListView(
                        children: [
                          _buildReviewItems(restaurant.customerReviews)
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                width: 59,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.comment,
                  color: kGrey,
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Flushbar(
                    flushbarPosition: FlushbarPosition.TOP,
                    message: "Go To Restaurant",
                    duration: Duration(seconds: 3),
                    backgroundColor: KBlue,
                  ).show(context);
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: KBlueSecondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Go To Restaurant",
                      style: kHeading6.copyWith(
                        fontWeight: FontWeight.w600,
                        color: kWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _customSliverAppBar(bool isScrolled, RestaurantDetail restaurant) {
      return SliverAppBar(
        pinned: true,
        expandedHeight: 256,
        title: isScrolled
            ? Text(
                restaurant.name,
                style: kHeading6.copyWith(
                  color: kBlack,
                ),
              )
            : SizedBox(),
        leading: isScrolled
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: kBlack,
                ),
              )
            : SizedBox(),
        actions: [
          isScrolled
              ? IconButton(
                  onPressed: () {
                    Share.share(
                      "${restaurant.pictureId} \n\n${restaurant.name}\n\nRating: ${restaurant.rating} - ${restaurant.city} \n\n${restaurant.description}",
                    );
                  },
                  icon: Icon(
                    Icons.share,
                    color: kBlack,
                  ),
                )
              : SizedBox(),
        ],
        backgroundColor: kWhite,
        flexibleSpace: FlexibleSpaceBar(
          background: _buildHeader(restaurant),
        ),
      );
    }

    return Consumer<RestaurantDetailNotifier>(
      builder: (context, restaurant, child) {
        if (restaurant.restaurantDetailState == RequestState.Loading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (restaurant.restaurantDetailState == RequestState.Loaded) {
          return Scaffold(
            bottomNavigationBar:
                _customBottomNavbarDetail(restaurant.restaurantDetail),
            body: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  _customSliverAppBar(isScrolled, restaurant.restaurantDetail),
                ];
              },
              body: SingleChildScrollView(
                child: Container(
                  color: kWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          restaurant.restaurantDetail.name,
                          style: kHeading5,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: kGrey,
                          ),
                          Text(
                            restaurant.restaurantDetail.city,
                            style: kSubtitle,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBarIndicator(
                            rating: restaurant.restaurantDetail.rating,
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
                            restaurant.restaurantDetail.rating.toString(),
                            style: kSubtitle,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: Text(
                          "Description",
                          style: kHeading6.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: Text(
                          restaurant.restaurantDetail.description,
                          style: kBodyText,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: Text(
                          "Food",
                          style: kHeading6.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      _buildMenuItems(restaurant.restaurantDetail.menus.foods),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: Text(
                          "Drink",
                          style: kHeading6.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      _buildMenuItems(restaurant.restaurantDetail.menus.drinks),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: Text(
                          "Add Review's",
                          style: kHeading6.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      _buildTextField(),
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : InkWell(
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });

                                if (nameController.text.isEmpty ||
                                    reviewController.text.isEmpty) {
                                  Flushbar(
                                    message: "Field cannot be empty",
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                  ).show(context);

                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  await Provider.of<RestaurantDetailNotifier>(
                                    context,
                                    listen: false,
                                  ).postAddReview(
                                    reviewController.text,
                                    nameController.text,
                                    restaurant.restaurantDetail.id,
                                  );

                                  setState(() {
                                    isLoading = false;
                                  });

                                  Future.microtask(
                                    () => Provider.of<RestaurantDetailNotifier>(
                                      context,
                                      listen: false,
                                    ).fetchDetailRestaurant(widget.id),
                                  );

                                  _clearController();

                                  Flushbar(
                                    message: "Add Successfully",
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.green,
                                  ).show(context);
                                }
                              },
                              child: Container(
                                height: 48,
                                margin:
                                    EdgeInsets.symmetric(horizontal: margin),
                                decoration: BoxDecoration(
                                  color: KBlueSecondary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Add Review",
                                    style: kHeading6.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: kWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Center(child: Text(restaurant.message)),
            ),
          );
        }
      },
    );
  }
}
