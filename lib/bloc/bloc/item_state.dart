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
