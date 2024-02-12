import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pictorama/features/dashboard/data/model/mobile_wall_paper_response.dart';
import 'package:pictorama/features/dashboard/presenter/cubit/dashboard_cubit.dart';
import 'package:pictorama/features/dashboard/presenter/widgets/trending_list_item.dart';

class TrendingWallPapers extends StatefulWidget {
  final ScrollController scrollController;
  const TrendingWallPapers({super.key, required this.scrollController});

  @override
  State<TrendingWallPapers> createState() => _TrendingWallPapersState();
}

class _TrendingWallPapersState extends State<TrendingWallPapers> {
  bool isStaggered = true;
  late DashboardCubit dashboardCubit;
  double lastScrollOffset = 0.0;
  String selectedSortType = '';
  @override
  void initState() {
    super.initState();
    dashboardCubit = BlocProvider.of<DashboardCubit>(context);
    dashboardCubit.getPhotos(dashboardCubit.menuItems[0]['value'] ?? '');

    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent) {
        lastScrollOffset = widget.scrollController.position.pixels;
        if (dashboardCubit.hasMoreData) {
          dashboardCubit.loadMore(selectedSortType);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          );
        } else if (state is DashboarSuccess) {
          // Restore the scroll position
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.scrollController.jumpTo(lastScrollOffset);
          });
          return _buildTrendingWallpepersSection(state.mobileWallPapaersList);
        } else if (state is DashboarFailure) {
          return Center(child: Text(state.errorMessage));
        }
        return _buildTrendingWallpepersSection([]);
      },
    );
  }

  Widget _buildTrendingWallpepersSection(
      List<MobileWallPaper> mobileWallPapaersList) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: mobileWallPapaersList.isNotEmpty
          ? MasonryGridView.builder(
              shrinkWrap: true,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: mobileWallPapaersList.length +
                  1, // Added 1 for the loading indicator
              itemBuilder: (BuildContext context, int index) {
                if (index == mobileWallPapaersList.length) {
                  return dashboardCubit.hasMoreData
                      ? _buildLoadingIndicator()
                      : Container();
                }
                MobileWallPaper photoItem = mobileWallPapaersList[index];
                return TrendingListItem(
                  photoItem: photoItem,
                  dashboardCubit: context.read<DashboardCubit>(),
                );
              },
            )
          : Container(),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: const CircularProgressIndicator(),
    );
  }
}
