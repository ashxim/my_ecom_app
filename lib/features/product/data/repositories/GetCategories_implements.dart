import 'package:my_ecom_app/features/product/data/data_sources/remote_data_souces/categorie_remote_datasources.dart';
import 'package:my_ecom_app/features/product/data/models/categorie/categories.dart';
import '../../domain/repositories/categories_repository.dart';

class GetcategoriesImplements implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  GetcategoriesImplements({required this.categoryRemoteDataSource});

  @override
  Future<List<CategoryModel>> getCategories() async {
    return await categoryRemoteDataSource.getCategories();
  }
}
