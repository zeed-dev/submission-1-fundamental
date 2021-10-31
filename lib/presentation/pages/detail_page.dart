import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/model/drink_model.dart';
import 'package:food_store_app/model/restaurant_model.dart';
import 'package:food_store_app/presentation/provider/bookmark_notifier.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class DetailPage extends StatefulWidget {
  static const ROUTE_NAME = "/detail-page";
  final Restaurant? restaurant;

  DetailPage({
    required this.restaurant,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    BookmarkNotifer _bookmarkNotifer = Provider.of<BookmarkNotifer>(context);

    Widget _buildHeader() {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 256,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: 206,
              width: double.infinity,
              color: KBlueSecondary.withOpacity(0.5),
            ),
            Container(
              height: 206,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    kBlack.withOpacity(0.3),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: widget.restaurant!.pictureId,
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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        "${widget.restaurant!.pictureId} \n\n${widget.restaurant!.name}\n\nRating: ${widget.restaurant!.rating} - ${widget.restaurant!.city} \n\n${widget.restaurant!.description}",
                      );
                    },
                    icon: Icon(
                      Icons.share,
                      color: kWhite,
                    ),
                  ),
                ],
              ),
            )
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

    Widget _customBottomNavbarDetail() {
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
                _bookmarkNotifer.setRestaurant(widget.restaurant!);
                Flushbar(
                  message: _bookmarkNotifer.isBookmark(widget.restaurant!)
                      ? "Has been added to the Wishlist"
                      : "Has been removed from the Wishlist",
                  duration: Duration(seconds: 3),
                  backgroundColor:
                      _bookmarkNotifer.isBookmark(widget.restaurant!)
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
                  _bookmarkNotifer.isBookmark(widget.restaurant!)
                      ? Icons.bookmark
                      : Icons.bookmark_outline,
                  color: kGrey,
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: InkWell(
                onTap: () {},
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

    return Scaffold(
      bottomNavigationBar: _customBottomNavbarDetail(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Center(
                child: Text(
                  widget.restaurant!.name,
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
                    widget.restaurant!.city,
                    style: kSubtitle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBarIndicator(
                    rating: widget.restaurant!.rating,
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
                    widget.restaurant!.rating.toString(),
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
                  widget.restaurant!.description,
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
              _buildMenuItems(widget.restaurant!.menus.foods),
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
              _buildMenuItems(widget.restaurant!.menus.drinks),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
