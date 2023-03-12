part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {}

class AddButtonPressed extends CartEvent {
  @override
  List<Object> get props => [];
}
