/*import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:my_ecom_app/features/product/data/repositories/GetCategories_implements.dart';
import '../../features/product/data/data_sources/remote_data_souces/categorie_remote_datasources.dart';
import '../../features/product/domain/repositories/categories_repository.dart';
import '../../features/product/domain/use_cases/categories/categorie_usecases.dart';
import '../../features/product/presentation/Bloc/categories/categories_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  // Register data sources
  getIt.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSource(client: http.Client()),
  );

  // Register repositories
  getIt.registerLazySingleton<CategoryRepository>(
    () => GetcategoriesImplements(
        categoryRemoteDataSource: getIt<CategoryRemoteDataSource>()),
  );

  // Register use cases
  getIt.registerLazySingleton<GetCategories>(
    () => GetCategories(repository: getIt<CategoryRepository>()),
  );

  getIt.registerFactory<CategoriesBloc>(() => CategoriesBloc(
        getCategories: getIt<GetCategories>(),
      ));
}
*/
