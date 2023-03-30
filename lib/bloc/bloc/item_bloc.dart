import 'dart:async';

import 'package:asbeza/dao/cart_dao.dart';
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
  late CartDao _cartDao = CartDao();
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
    on<ItemAddedCartEvent>((event, emit) => {
          if (!cartData.contains(event.data))
            {
              cartData.add(event.data),
              _cartRepository.insertItems(event.data),
              _cartDao.getItems()
            }
        });
  }
}
