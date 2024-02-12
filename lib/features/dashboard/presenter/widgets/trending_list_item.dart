import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pictorama/features/dashboard/data/model/mobile_wall_paper_response.dart';
import 'package:pictorama/features/dashboard/presenter/cubit/dashboard_cubit.dart';

class TrendingListItem extends StatelessWidget {
  final MobileWallPaper photoItem;
  final DashboardCubit dashboardCubit;

  const TrendingListItem({
    required this.photoItem,
    required this.dashboardCubit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          child: SizedBox(
            // height: isStaggered ? Random().nextInt(100).toDouble() + 280 : 280,
            height: Random().nextInt(100).toDouble() + 280,
            width: (MediaQuery.of(context).size.width / 2) - 20,
            child: CachedNetworkImage(
              imageUrl: photoItem.urls?.regular ?? '',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            icon: Icon(
              photoItem.isFavAdded ?? false
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () {
              dashboardCubit.updateFavItem(photoItem);
            },
          ),
        ),
      ],
    );
  }
}
