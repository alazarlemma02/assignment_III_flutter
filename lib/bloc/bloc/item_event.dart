part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  //AsbezaEvent
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class ItemInitializedEvent extends ItemEvent {}

class ItemAddingCartEvent extends ItemEvent {
  @override
  List<Object> get props => [];
}

class ItemAddedCartEvent extends ItemEvent {
  final Item items;
  const ItemAddedCartEvent({required this.items});

  @override
  List<Object> get props => [];
  get data => items;
}

class QuantityAddedEvent extends ItemEvent {
  final int quantity;
  const QuantityAddedEvent({required this.quantity});
}

class QuantityDecresedEvent extends ItemEvent {
  final int quantity;
  const QuantityDecresedEvent({required this.quantity});
}
