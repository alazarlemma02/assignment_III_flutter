part of 'asbeza_bloc.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoadingState extends ItemState {}

class ItemPageLoadedState extends ItemState {
  List<Item> item;
  CartData? cartData;
  // TODO1: cart item to be added in the loaded state.

  ItemPageLoadedState({required this.item});
}

class ItemAddingCartState extends ItemState {
  CartData? cartData;
  List<Item>? items;

  ItemAddingCartState({this.cartData, required this.items});
}

class ItemAddedCartState extends ItemState {
  final List<Item>? items;

  const ItemAddedCartState({required this.items});
}
