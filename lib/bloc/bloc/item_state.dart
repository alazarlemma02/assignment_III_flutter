part of 'item_bloc.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoadingState extends ItemState {}

class ItemLoadedState extends ItemState {
  final List item;
  final List cartData;
  int cartLength() {
    return cartData.length;
  }

  const ItemLoadedState({required this.item, required this.cartData});
}

class QuantityState extends ItemState {
  final int quantity;
  const QuantityState({required this.quantity});
}

// // @immutable
// class CartInitialState extends ItemState {}

// // @immutable
// class CartLoadingState extends ItemState {}

// // @immutable
// class CartLoadedState extends ItemState {
//   final List<Item> cartProducts;
//   const CartLoadedState({required this.cartProducts});

//   @override
//   List<Object> get props => [];
// }

// // @immutable
// class CartErrorState extends ItemState {}
