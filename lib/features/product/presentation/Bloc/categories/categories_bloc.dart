import 'package:bloc/bloc.dart';

import '../../../domain/use_cases/categories/categorie_usecases.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategories getCategories;

  CategoriesBloc({required this.getCategories}) : super(CategoriesLoading()) {
    on<FetchCategories>(_onFetchCategories);
  }
  void _onFetchCategories(
      FetchCategories event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());
    try {
      final categories = await getCategories();
      emit(CategoriesLoaded(categories: categories));
    } catch (e) {
      emit(categoriesError(message: e.toString()));
    }
  }
}
