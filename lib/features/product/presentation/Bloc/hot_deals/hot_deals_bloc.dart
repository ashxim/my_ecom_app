// hot_deals_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/features/product/domain/use_cases/product/GetHotDeals.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/hot_deals/hot_deals_state.dart';
import 'hot_deals_event.dart';

class HotDealsBloc extends Bloc<HotDealsEvent, HotDealsState> {
  final GetHotDeals getHotDeals;

  HotDealsBloc({required this.getHotDeals}) : super(HotDealsLoading()) {
    on<FetchHotDeals>(_onFetchHotDeals);
  }
  void _onFetchHotDeals(
      FetchHotDeals event, Emitter<HotDealsState> emit) async {
    emit(HotDealsLoading());
    try {
      final hotDeals = await getHotDeals();
      emit(HotDealsLoaded(hotDeals: hotDeals));
    } catch (e) {
      emit(HotDealsError(message: e.toString()));
    }
  }
}
