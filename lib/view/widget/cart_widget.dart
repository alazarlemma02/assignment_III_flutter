// import 'package:asbeza/bloc/bloc/item_bloc.dart';
// import 'package:asbeza/data/model/item.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// final ItemBloc itemBloc = ItemBloc();
// final DismissDirection _dismissDirection = DismissDirection.horizontal;

// Widget getCartWidget() {
//   /*The StreamBuilder widget,
//     basically this widget will take stream of data (todos)
//     and construct the UI (with state) based on the stream
//     */
//   return StreamBuilder(
//     stream: itemBloc.items,
//     builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
//       return getCartCardWidget(snapshot);
//     },
//   );
// }

// Widget getCartCardWidget(AsyncSnapshot<List<Item>> snapshot) {
//   /*Since most of our operations are asynchronous
//     at initial state of the operation there will be no stream
//     so we need to handle it if this was the case
//     by showing users a processing/loading indicator*/
//   if (snapshot.hasData) {
//     /*Also handles whenever there's stream
//       but returned returned 0 records of Todo from DB.
//       If that the case show user that you have empty Todos
//       */
//     return snapshot.data!.isNotEmpty
//         ? ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, itemPosition) {
//               Item item = snapshot.data![itemPosition];
//               // ignore: unnecessary_new
//               final Widget dismissibleCard = new Dismissible(
//                 background: Container(
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Deleting",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   color: Colors.redAccent,
//                 ),
//                 onDismissed: (direction) {
//                   /*The magic
//                     delete Todo item by ID whenever
//                     the card is dismissed
//                     */
//                   // itemBloc.deleteItemById(item.id);
//                 },
//                 direction: _dismissDirection,
//                 key: new ObjectKey(item),
//                 child: Card(
//                     shape: RoundedRectangleBorder(
//                       side: BorderSide(color: Colors.grey, width: 0.5),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     color: Colors.white,
//                     child: ListTile(
//                       leading: InkWell(
//                         onTap: () {
//                           //Reverse the value

//                           item.is_added = !item.is_added;
//                           /*
//                             Another magic.
//                             This will update Todo isDone with either
//                             completed or not
//                           */
//                           itemBloc.updateItem(item);
//                         },
//                         child: Container(
//                           //decoration: BoxDecoration(),
//                           child: Padding(
//                             padding: const EdgeInsets.all(15.0),
//                             child: item.is_added
//                                 ? Icon(
//                                     Icons.done,
//                                     size: 26.0,
//                                     color: Colors.indigoAccent,
//                                   )
//                                 : Icon(
//                                     Icons.check_box_outline_blank,
//                                     size: 26.0,
//                                     color: Colors.tealAccent,
//                                   ),
//                           ),
//                         ),
//                       ),
//                       title: Text(
//                         item.name,
//                         style: TextStyle(
//                             fontSize: 16.5,
//                             fontFamily: 'RobotoMono',
//                             fontWeight: FontWeight.w500,
//                             decoration: item.is_added
//                                 ? TextDecoration.lineThrough
//                                 : TextDecoration.none),
//                       ),
//                     )),
//               );
//               return dismissibleCard;
//             },
//           )
//         : Container(
//             child: Center(
//             //this is used whenever there 0 Todo
//             //in the data base
//             child: noItemMessageWidget(),
//           ));
//   } else {
//     return Center(
//       /*since most of our I/O operations are done
//         outside the main thread asynchronously
//         we may want to display a loading indicator
//         to let the use know the app is currently
//         processing*/
//       child: loadingData(),
//     );
//   }
// }

// Widget loadingData() {
//   //pull todos again
//   itemBloc.getItems(query: '');
//   return Container(
//     child: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           CircularProgressIndicator(),
//           Text("Loading...",
//               style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
//         ],
//       ),
//     ),
//   );
// }

// Widget noItemMessageWidget() {
//   return Container(
//     child: Text(
//       "Start adding Todo...",
//       style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
//     ),
//   );
// }

// dispose() {
//   /*close the stream in order
//     to avoid memory leaks
//     */
//   itemBloc.dispose();
// }
