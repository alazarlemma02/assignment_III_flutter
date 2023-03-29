import 'dart:async';

import 'package:asbeza/data/model/repository/cart_provider.dart';
import 'package:asbeza/data/model/repository/cart_repositroy.dart';
import 'package:asbeza/database/database.dart';
import 'package:asbeza/view/screens/item_list.dart';
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
  final _cartRepository = CartRepository();
  final _cartController = StreamController<List<Item>>.broadcast();
  get items => _cartController.stream;
  CartPageProvider cartPageProvider = CartPageProvider();

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
    // on<ItemAddedCartEvent>(
    //   (event, emit) => {cartPageProvider.cart.add(event.items)},
    // );
    // on<QuantityDecresedEvent>(
    //   (event, emit) async {
    //     int quan = quantity.getQuantity();
    //     emit(QuantityState(quantity: quan--));
    //   },
    // );
    // on<QuantityAddedEvent>(
    //   (event, emit) async {
    //     int quan = quantity.getQuantity();
    //     emit(QuantityState(quantity: quan++));
    //   },
    // );
    // Stream<ItemState> mapEventToState(ItemEvent event) async* {
    //   if (event is CartLoadedEvent) {
    //     if (state is CartInitialState) {
    //       final cartResults =
    //           await cartPageProvider.cart;

    //       yield CartLoadedState(

    //           price: cartPageProvider.totalPrice,
    //           name: cartResults.na,
    //           promos: promos.promos,
    //           appliedPromo: cartResults.appliedPromo,
    //           cartProducts: cartResults.cartItems);
    //     } else if (state is CartLoadedState) {
    //       yield state;
    //     }
    //   }
    // }
  }
}
