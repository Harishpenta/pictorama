import 'package:flutter/material.dart';
import 'package:pictorama/auth/api_response_helper.dart';
import 'package:pictorama/auth/auth_service.dart';
import 'package:pictorama/core/error/exceptions.dart';
import 'package:pictorama/features/dashboard/data/model/mobile_wall_paper_response.dart';
import 'package:http/http.dart' as http;

abstract class GetPhotosListDataSource {
  Future<ApiResponse<List<MobileWallPaper>>> getPhotosListFromServer(
      int pageNo, String orderBy);
}

class GetPhotosListDataSourceImpl implements GetPhotosListDataSource {
  final http.Client client;
  final ApiBaseHelper apiBaseHelper;
  GetPhotosListDataSourceImpl(
      {required this.apiBaseHelper, required this.client});

  @override
  Future<ApiResponse<List<MobileWallPaper>>> getPhotosListFromServer(
      int pageNo, String orderBy) async {
    try {
      final response = await apiBaseHelper.get(
          "/search/photos?query=mobile-wallpapers&page=$pageNo&order_by=$orderBy&orientation=portrait&per_page=30");
      if (response.isSuccess) {
        MobileWallPaperResponse mobileWallPaperResponse =
            MobileWallPaperResponse.fromJson(response.data);
        return ApiResponse.success(
            mobileWallPaperResponse.mobileWallPaperList ?? []);
      } else {
        return ApiResponse.error(response.error!);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw AppException();
    }
  }
}
