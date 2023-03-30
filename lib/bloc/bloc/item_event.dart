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
}

// class QuantityAddedEvent extends ItemEvent {
//   final int quantity;
//   const QuantityAddedEvent({required this.quantity});
// }

// class QuantityDecresedEvent extends ItemEvent {
//   final int quantity;
//   const QuantityDecresedEvent({required this.quantity});
// }


// @immutable
// class CartLoadedEvent extends CartEvent {}

// @immutable
// class CartQuantityChangedEvent extends CartEvent {
//   final CartItem item;
//   final int newQuantity;

//   CartQuantityChangedEvent({required this.item, required this.newQuantity});
// }

// @immutable
// class CartRemoveFromCartEvent extends CartEvent {
//   final CartItem item;

//   CartRemoveFromCartEvent({required this.item});
// }

// @immutable
// class CartAddToFavsEvent extends CartEvent {
//   final CartItem item;

//   CartAddToFavsEvent({required this.item});
// }

// @immutable
// class CartPromoAppliedEvent extends CartEvent {
//   final Promo promo;

//   CartPromoAppliedEvent({required this.promo});
// }

// @immutable
// class CartPromoCodeAppliedEvent extends CartEvent {
//   final String promoCode;

//   CartPromoCodeAppliedEvent({required this.promoCode});
// }

// @immutable
// class CartShowPopupEvent extends CartEvent {}
