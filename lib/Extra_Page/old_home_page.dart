// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:voltagelab/Provider/category_provider.dart';
// import 'package:voltagelab/Screen/Polytechnic_bd/listcategory_page.dart';
// import 'package:voltagelab/Screen/Voltage_Lab/listcategory_page.dart';
// import 'package:voltagelab/Screen/Youtube/youtube_playlist.dart';
// import 'package:voltagelab/widget/drawer.dart';




// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var box;
//   List gridnamelist = [
//     "Blog",
//     "Converter",
//     "Blog",
//     "Converter",
//     "Blog",
//     "Converter",
//   ];

//   @override
//   void initState() {
//     box = Hive.box('userdata');
//     Provider.of<CategoryProvider>(context, listen: false).getcategory();
//     Provider.of<CategoryProvider>(context, listen: false).polytechnicbdcategory();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         drawer: const DrawerPage(),
//         appBar: AppBar(
//           title: const Text("Voltage Lab"),
//         ),
//         body: GridView(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2),
//           children: [
//             Container(
//               margin: const EdgeInsets.all(5),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const ListcategoryPage(),
//                           ));
//                     },
//                     child: Container(
//                       height: 80.0,
//                       width: 80.0,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       // ignore: unnecessary_brace_in_string_interps
//                       child: Image.asset("images/img0s.png", fit: BoxFit.cover),
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   const Text(
//                     'Voltage Lab Blog',
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.all(5),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Provider.of<CategoryProvider>(context, listen: false)
//                           .polytechnicbdcategory();
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const PolytechnicListcategoryPage(),
//                           ));
//                     },
//                     child: Container(
//                       height: 80.0,
//                       width: 80.0,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       // ignore: unnecessary_brace_in_string_interps
//                       child: Image.asset("images/img0s.png", fit: BoxFit.cover),
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   const Text(
//                     'Polytechnicbd Lab Blog',
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.all(5),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () {
                     
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const YoutubePlaylistPage(),
//                           ));
//                     },
//                     child: Container(
//                       height: 80.0,
//                       width: 80.0,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       // ignore: unnecessary_brace_in_string_interps
//                       child: Image.asset("images/imdgg1.png", fit: BoxFit.cover),
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   const Text(
//                     'Youtube',
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }


// // CustomScrollView(
// //           shrinkWrap: true,
// //           slivers: [
// //             SliverGrid.count(
// //               crossAxisCount: 2,
// //               children: List.generate(gridnamelist.length, (index) {
// //                 return Container(
// //                   margin: const EdgeInsets.all(5),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       InkWell(
// //                         onTap: () {
                          
// //                           Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (context) => const ListcategoryPage(),
// //                               ));
// //                         },
// //                         child: Container(
// //                           height: 80.0,
// //                           width: 80.0,
// //                           decoration: BoxDecoration(
// //                             color: Colors.green,
// //                             borderRadius: BorderRadius.circular(100),
// //                           ),
// //                           // ignore: unnecessary_brace_in_string_interps
// //                           child: Image.asset("images/img${index}.png",
// //                               fit: BoxFit.cover),
// //                         ),
// //                       ),
// //                       const SizedBox(height: 5),
// //                       Text(
// //                         gridnamelist[index],
// //                       )
// //                     ],
// //                   ),
// //                 );
// //               }),
// //             )
// //           ],
// //         ),
