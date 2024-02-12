part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboarSuccess extends DashboardState {
  final List<MobileWallPaper> mobileWallPapaersList;
  const DashboarSuccess({required this.mobileWallPapaersList});
}

final class DashboarFailure extends DashboardState {
  final String errorMessage;

  const DashboarFailure({required this.errorMessage});
}

final class DashboardLoadingMore extends DashboardState {}

final class DashboardSuccessMore extends DashboardState {
  final List<MobileWallPaper> mobileWallPapaersList;
  const DashboardSuccessMore({required this.mobileWallPapaersList});
}

final class DashboardFailureMore extends DashboardState {
  final String errorMessage;

  const DashboardFailureMore({required this.errorMessage});
}

final class DashboarTrendingGridviewListType extends DashboardState {
  final bool isStaggered;

  const DashboarTrendingGridviewListType({required this.isStaggered});
}
