import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerLazySingleton<ApiService>(() => ApiService(Dio()));
  }

  if (!getIt.isRegistered<HomeRepo>()) {
    getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(getIt()));
  }
}
