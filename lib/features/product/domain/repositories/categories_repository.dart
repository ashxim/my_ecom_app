import 'package:my_ecom_app/features/product/data/models/categorie/categories.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getCategories();
}
