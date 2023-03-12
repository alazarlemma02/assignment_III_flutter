import 'package:asbeza/data/model/cart.dart';
import 'package:asbeza/presentation/screens/item_list.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/item.dart';
import 'package:asbeza/data/model/repository/apiServicesProvider.dart';

part 'asbeza_event.dart';
part 'asbeza_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ApiServiceProvider apiServiceProvider = ApiServiceProvider();
  ItemList itemList = ItemList();
  ItemBloc() : super(ItemInitial()) {
    on<ItemEvent>((event, emit) {
      add(ItemPageInitializedEvent());
      // TODO: implement event handler
    });
  }

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if (event is ItemLoadingState) {
      List<Item>? item = await apiServiceProvider.fetchItem();

      yield ItemPageLoadedState(item: item!);
    }
    if (event is ItemAddingCartEvent) {
      yield ItemAddingCartState(items: event.items);
    }
    if (event is ItemAddedCartEvent) {
      yield ItemAddedCartState(items: event.items);
    }
  }
}
