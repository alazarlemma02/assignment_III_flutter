part of 'cart_bloc.dart';

abstract class CartState extends Equatable {}

class CartInitialState extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadingState extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadedState extends CartState {
  final List item;

  CartLoadedState(
    this.item,
  );

  @override
  List<Object> get props => [];
}

// class CartFailState extends CartState {
//   String message;

//   CartFailState(this.message);

//   @override
//   List<Object> get props => [];
// }
