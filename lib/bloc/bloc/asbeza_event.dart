part of 'asbeza_bloc.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class ItemPageInitializedEvent extends ItemEvent {}

class ItemAddingCartEvent extends ItemEvent {
  final List<Item>? items;

  const ItemAddingCartEvent({this.items});
}

class ItemAddedCartEvent extends ItemEvent {
  final List<Item>? items;

  const ItemAddedCartEvent({this.items});
}
