import '../../../dao/cart_dao.dart';
import '../item.dart';

class CartRepository {
  final cartDao = CartDao();
  // Future getAllItems({required String query}) =>
  //     cartDao.getItems(query: query, columns: []);

  Future insertItems(Item item) => cartDao.createItem(item);

  readItem() async {
    return await cartDao.getItems();
  }

  Future updateItems(Item item) => cartDao.updateItem(item);

  Future deleteItemById(int id) => cartDao.deleteItem(id);

  //We are not going to use this in the demo
  Future deleteAllItems() => cartDao.deleteAllItems();
}
