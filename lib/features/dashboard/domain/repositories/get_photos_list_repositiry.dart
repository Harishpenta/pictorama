import 'package:dartz/dartz.dart';
import 'package:pictorama/core/error/failures.dart';
import 'package:pictorama/features/dashboard/data/model/mobile_wall_paper_response.dart';

abstract class GetPhotoListRepository {
  Future<Either<Failure, List<MobileWallPaper>>> getPhotosList(
      int pageNo, String orderBy);
}
