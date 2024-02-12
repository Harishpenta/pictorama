import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictorama/features/dashboard/data/model/mobile_wall_paper_response.dart';
import 'package:pictorama/features/dashboard/domain/usecases/get_photos_list.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetPhotosList getPhotosListUsecase;
  DashboardCubit({required this.getPhotosListUsecase})
      : super(DashboardInitial());

  List<MobileWallPaper> _wallpapersList = [];
  int _pageNumber = 1;
  bool hasMoreData = true;

  final List<Map<String, String>> menuItems = [
    {'value': 'latest', 'title': 'Latest'},
    {'value': 'relavent', 'title': 'Relavent'},
  ];

  Future<void> getPhotos(String orderBy) async {
    emit(DashboardLoading());
    final response = await getPhotosListUsecase
        .call(ParamsForWallPaperList(pageNo: _pageNumber, orderBy: orderBy));
    response.fold((error) {
      emit(const DashboarFailure(errorMessage: "Something went wrong!"));
    }, (photosList) {
      _wallpapersList = photosList;
      emit(DashboarSuccess(mobileWallPapaersList: _wallpapersList));
    });
  }

  Future<void> loadMore(String orderBy) async {
    emit(DashboardInitial());
    _pageNumber++;
    final response = await getPhotosListUsecase
        .call(ParamsForWallPaperList(pageNo: _pageNumber, orderBy: orderBy));
    response.fold((error) {
      emit(const DashboarFailure(errorMessage: "Something went wrong!"));
    }, (photosList) {
      if (photosList.isEmpty) {
        hasMoreData = false;
      }
      _wallpapersList.addAll(photosList);
      emit(DashboarSuccess(mobileWallPapaersList: _wallpapersList));
    });
  }

  void updateGridviewType(bool isStaggered) {
    emit(DashboardInitial());
    emit(DashboarTrendingGridviewListType(isStaggered: isStaggered));
  }

  void updateFavItem(MobileWallPaper mobileWallPaper) {
    // Update the favorite status of the photoItem
    mobileWallPaper.isFavAdded = !(mobileWallPaper.isFavAdded ?? false);

    // Emit the same list instance with the updated data
    emit(DashboardLoading());
    emit(DashboarSuccess(mobileWallPapaersList: _wallpapersList));
  }
}
