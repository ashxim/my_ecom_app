// hot_deals_event.dart
import 'package:equatable/equatable.dart';

abstract class HotDealsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchHotDeals extends HotDealsEvent {}
