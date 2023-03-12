import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:asbeza/data/model/repository/car_items.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<AddButtonPressed>((event, emit) async {
      emit(CartLoadingState());
      List added_items = addedItems;
      emit(CartLoadedState(added_items));
    });
  }
}
