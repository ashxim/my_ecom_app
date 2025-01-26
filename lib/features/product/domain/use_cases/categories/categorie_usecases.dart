import 'package:my_ecom_app/features/product/data/models/categorie/categories.dart';

import '../../repositories/categories_repository.dart';

class GetCategories {
  final CategoryRepository repository;

  GetCategories({required this.repository});

  Future<List<CategoryModel>> call() async {
    return await repository.getCategories();
  }
}
