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
  final List<Item> cartData;
  int cartLength() {
    return cartData.length;
  }

  const ItemLoadedState({required this.item, required this.cartData});
}

class QuantityState extends ItemState {
  final int quantity;
  const QuantityState({required this.quantity});
}

// @immutable
class CartInitialState extends ItemState {}

// @immutable
class CartLoadingState extends ItemState {}

// @immutable
class CartLoadedState extends ItemState {
  final List<Item> cartProducts;
  final String? name;
  final String? image;
  final double? price;

  const CartLoadedState(
      {this.price, this.image, this.name, required this.cartProducts});

  CartLoadedState copyWith(
      {List<Item>? cartProducts, double? price, String? name, String? image}) {
    return CartLoadedState(
      name: name ?? this.name,
      cartProducts: cartProducts ?? this.cartProducts,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  @override
  List<Object> get props => [price!, cartProducts, name!, image!];
}

// @immutable
class CartErrorState extends ItemState {}
