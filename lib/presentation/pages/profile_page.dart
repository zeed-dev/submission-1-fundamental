import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/presentation/provider/scheduling_notifier.dart';
import 'package:food_store_app/presentation/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static const ROUTE_NAME = "/profile-page";

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: kWhite,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    height: 64,
                    width: 64,
                    imageUrl:
                        "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hallo, Dicoding",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: kSubtitle.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "@Dicoding",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: kSubtitle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget menuItem({String text = "", Function? onTap}) {
      return InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: kSubtitle.copyWith(
                  fontSize: 13,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: kBlack,
              )
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          color: kWhite,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Account",
                  style: kSubtitle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                menuItem(
                  text: "Edit Profile",
                  onTap: () {},
                ),
                menuItem(
                  text: "Help",
                  onTap: () {},
                ),
                menuItem(
                  text: "Privacy & Policy",
                  onTap: () {},
                ),
                menuItem(
                  text: "Term of Service",
                  onTap: () {},
                ),
                menuItem(
                  text: "Rate App",
                  onTap: () {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Scheduling News',
                      style: kSubtitle.copyWith(
                        fontSize: 13,
                      ),
                    ),
                    Consumer<SchedulingNotifier>(
                      builder: (context, scheduled, _) {
                        return Switch.adaptive(
                          value: scheduled.isScheduled,
                          onChanged: (value) async {
                            if (Platform.isIOS) {
                              customDialog(context);
                            } else {
                              scheduled.scheduledRestaurant(value);
                            }
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}
