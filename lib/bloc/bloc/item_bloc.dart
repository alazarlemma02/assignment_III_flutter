import 'package:asbeza/presentation/screens/item_list.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/item.dart';
import 'package:asbeza/data/model/repository/apiServicesProvider.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ApiServiceProvider apiServiceProvider = ApiServiceProvider();
  List<Item> cartData = [];
  late Item quantity;

  // int quantity = quan.getQuantity as int;
  ItemBloc() : super(ItemInitial()) {
    on<ItemEvent>((event, emit) async {
      emit(ItemLoadingState());
      // if (event is ItemLoadingState) {
      List<Item>? item = await apiServiceProvider.fetchItem();

      emit(ItemLoadedState(item: item!, cartData: cartData));
      // } else {
      // emit(ItemInitial());
      // }
    });
    on<ItemAddedCartEvent>(
      (event, emit) => {cartData.add(event.items)},
    );
    on<QuantityDecresedEvent>(
      (event, emit) async {
        int quan = quantity.getQuantity();
        emit(QuantityState(quantity: quan--));
      },
    );
    on<QuantityAddedEvent>(
      (event, emit) async {
        int quan = quantity.getQuantity();
        emit(QuantityState(quantity: quan++));
      },
    );
  }
}
