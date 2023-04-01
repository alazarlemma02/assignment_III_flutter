import 'dart:async';

import 'package:asbeza/data/model/repository/cart_provider.dart';
import 'package:asbeza/data/model/repository/cart_repositroy.dart';

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
  List cartItem = [];
  final _cartRepository = CartRepository();
  final _cartController = StreamController<List<Item>>.broadcast();
  get items => _cartController.stream;
  CartPageProvider cartPageProvider = CartPageProvider();

  ItemBloc() : super(ItemInitial()) {
    on<ItemEvent>((event, emit) async {
      emit(ItemLoadingState());
      List<Item>? item = await apiServiceProvider.fetchItem();

      emit(ItemLoadedState(item: item!, cartData: cartData));
    });
    on<ItemAddedCartEvent>((event, emit) async {
      emit(ItemLoadingState());
      await _cartRepository.readItem().then((val) => {
            cartData = val,
          });
      cartItem = Item.itemList(cartData);
      if (!cartItem.contains(event.items)) {
        cartItem.add(event.items);
        event.items.is_added = true;
        _cartRepository.insertItems(event.items);
      }
      // emit(ItemLoadedState(item: items, cartData: cartItem));
    });
  }
}
