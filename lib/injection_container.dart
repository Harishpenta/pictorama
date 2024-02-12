import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:pictorama/auth/auth_service.dart';
import 'package:pictorama/features/dashboard/data/data_sources/get_photos_list_data_source.dart';
import 'package:pictorama/features/dashboard/data/repositories_impl/get_photos_list_repository_impl.dart';
import 'package:pictorama/features/dashboard/domain/repositories/get_photos_list_repositiry.dart';
import 'package:pictorama/features/dashboard/domain/usecases/get_photos_list.dart';
import 'package:pictorama/features/dashboard/presenter/cubit/dashboard_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Cubit
  sl.registerFactory(() => DashboardCubit(getPhotosListUsecase: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetPhotosList(sl()));

  // Repository
  sl.registerLazySingleton<GetPhotoListRepository>(
    () => GetPhotosoListRepositoryImpl(dataSource: sl()),
  );

  // Data sources

  sl.registerLazySingleton<GetPhotosListDataSource>(
    () => GetPhotosListDataSourceImpl(client: sl(), apiBaseHelper: sl()),
  );

  //! Core
  sl.registerSingleton<ApiBaseHelper>(ApiBaseHelper());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
