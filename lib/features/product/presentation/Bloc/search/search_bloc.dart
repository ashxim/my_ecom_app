import 'package:bloc/bloc.dart';
import 'package:my_ecom_app/features/product/data/data_sources/remote_data_souces/search_remote_datasouces.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRemoteDatasouces searchRemoteDatasouces;
  SearchBloc(this.searchRemoteDatasouces) : super(SearchInitial()) {
    on<SearchProducts>((event, emit) async {
      print('Searching for: ${event.query}');
      emit(SearchLoading());
      try {
        final products =
            await searchRemoteDatasouces.searchProducts(event.query);
        print("Search success: ${products.length} items found");
        emit(SearchLoaded(products: products));
      } catch (e) {
        print("Search error: $e");
        emit(SearchError(message: e.toString()));
      }
    });
  }
}
