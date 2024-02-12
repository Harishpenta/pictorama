import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pictorama/core/error/failures.dart';
import 'package:pictorama/features/dashboard/data/model/mobile_wall_paper_response.dart';
import 'package:pictorama/features/dashboard/domain/repositories/get_photos_list_repositiry.dart';
import 'package:pictorama/usecases/usecase.dart';

class GetPhotosList
    implements UseCase<List<MobileWallPaper>, ParamsForWallPaperList> {
  final GetPhotoListRepository repository;
  GetPhotosList(this.repository);

  @override
  Future<Either<Failure, List<MobileWallPaper>>> call(
      ParamsForWallPaperList params) async {
    return await repository.getPhotosList(params.pageNo, params.orderBy);
  }
}

class ParamsForWallPaperList extends Equatable {
  final int pageNo;
  final String orderBy;
  const ParamsForWallPaperList({required this.pageNo, required this.orderBy});

  @override
  List<Object?> get props => [pageNo];
}
