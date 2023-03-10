// import 'dart:ui';

// // import 'package:cboard_mobile/data/mockData.dart';
// import 'package:Articulate/models/tile_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:provider/provider.dart';

// class WhiteboardWidget extends StatefulWidget {
//   final Function() tapped;

//   const WhiteboardWidget({Key? key, required this.tapped}) : super(key: key);

//   @override
//   _WhiteboardWidgetState createState() => _WhiteboardWidgetState();
// }

// class _WhiteboardWidgetState extends State<WhiteboardWidget> {
//   bool _enterText = false, _expandView = false;
//   TextEditingController textController = TextEditingController();
//   FlutterTts tts = FlutterTts();
//   late FocusNode enterTextFocusNode;

//   @override
//   void initState() {
//     super.initState();
//     enterTextFocusNode = new FocusNode();
//   }

//   @override
//   void dispose() {
//     enterTextFocusNode.dispose();
//     textController.dispose();
//     super.dispose();
//   }

//   _createTile(String text) {
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final dialogModel = Provider.of<DialogModel>(context);
//     final homeModel = Provider.of<HomeModel>(context);
//     final words = homeModel.getWords();

//     Future _speak(String text) async {
//       await tts.speak(text);
//     }

//     return Row(
//       children: [
//         SizedBox(width: 3),
//         Expanded(
//             child: GestureDetector(
//           onTap: () {
//             setState(() {
//               _enterText = true;
//             });
//           },
//           child: _enterText == true
//               ? Container(
//                   child: TextField(
//                     focusNode: enterTextFocusNode,
//                     autofocus: true,
//                     style: TextStyle(height: 1.3, color: Colors.black),
//                     // cursorHeight: 3.0,
//                     controller: textController,
//                     decoration: null,
//                     textInputAction: TextInputAction.done,
//                     maxLines: null,
//                     onSubmitted: (String text) {
//                       if (text != null && text.isNotEmpty) {
//                         final tile = _createTile(text);
//                         homeModel.addWords(tile);
//                       }
//                       setState(() {
//                         _enterText = false;
//                       });
//                       textController.clear();
//                       enterTextFocusNode.unfocus();
//                     },
//                   ),
//                 )
//               : words.length == 0
//                   ? Text(
//                       'Enter text or add tiles',
//                     )
//                   : ListView.builder(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 10.0,
//                         horizontal: 10.0,
//                       ),
//                       //User can scroll tiles horizontally
//                       scrollDirection: Axis.horizontal,
//                       itemCount: words.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         TileModel tileInfo = words[index];
//                         String title = tileInfo.labelKey.split('.').last;
//                         return SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.2,
//                             child: TileWidget(
//                               labelPos: dialogModel.tileLabelTop,
//                               text: title,
//                               content: (tileInfo.image != null)
//                                   ? "assets" + tileInfo.image
//                                   : "assets/symbols/A.svg",
//                               color: dialogModel.tileBackgrfoundColor,
//                               labelColor: dialogModel.tileTextColor,
//                               tapped: () => {
//                                 //Speak word in the tile
//                                 _speak(title),
//                               },
//                             ));
//                       },
//                     ),
//         )),
//         SizedBox(width: 5),
//         // Backspace Button
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               if (words.length > 0) {
//                 words.removeLast();
//               }
//             });
//           },
//           child: _enterText == true
//               ? Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         _speak(textController.text);
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(10),
//                         // width: MediaQuery.of(context).size.width/10,
//                         // height: MediaQuery.of(context).size.height/50,
//                         //  color: Colors.orange,
//                         decoration: BoxDecoration(
//                             color: tangerine,
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(100))),
//                         child: Icon(
//                           Icons.volume_up,
//                           color: white,
//                           size: 30.0,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     GestureDetector(
//                       onTap: () {
//                         print("Tapped!");
//                         setState(() {
//                           _enterText = false;
//                         });
//                         String text = textController.text;
//                         textController.clear();
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ExpandTextScreen(
//                                       text: text,
//                                     )));
//                       },
//                       child: Container(
//                         child: Icon(
//                           Icons.open_in_full,
//                           color: Theme.of(context).primaryColor,
//                           size: 25.0,
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               : Icon(
//                   Icons.backspace,
//                   color: Theme.of(context).primaryColor,
//                   size: 25.0,
//                 ),
//         ),
//         SizedBox(width: 5),
//       ],
//     );
//   }
// }
