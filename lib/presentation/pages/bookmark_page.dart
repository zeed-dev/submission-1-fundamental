import 'package:flutter/material.dart';
import 'package:food_store_app/common/constants.dart';
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
                  child: CardRestaurant(
                    isBookmark: _bookmarkNotifer.isBookmark(
                      _bookmarkNotifer.bookmark[index],
                    ),
                    restaurant: _bookmarkNotifer.bookmark[index],
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailPage.ROUTE_NAME,
                        arguments: _bookmarkNotifer.bookmark[index],
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
