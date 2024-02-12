import 'package:dartz/dartz.dart';
import 'package:pictorama/core/error/exceptions.dart';
import 'package:pictorama/core/error/failures.dart';
import 'package:pictorama/features/dashboard/data/data_sources/get_photos_list_data_source.dart';
import 'package:pictorama/features/dashboard/data/model/mobile_wall_paper_response.dart';
import 'package:pictorama/features/dashboard/domain/repositories/get_photos_list_repositiry.dart';

class GetPhotosoListRepositoryImpl implements GetPhotoListRepository {
  final GetPhotosListDataSource dataSource;

  GetPhotosoListRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<MobileWallPaper>>> getPhotosList(
      int pageNo, String orderBy) async {
    try {
      final remoteResponse =
          await dataSource.getPhotosListFromServer(pageNo, orderBy);
      return Right(remoteResponse.data ?? []);
    } on AppException {
      return Left(ServerFailure());
    }
  }
}
