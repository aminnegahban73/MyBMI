// import 'package:demo_13/Models/Note.dart';
// import 'package:demo_13/ViewControllers/TrashPage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:kf_drawer/kf_drawer.dart';

// import '../screens/auth_page.dart';
// import '../screens/calendar_page.dart';
// import '../screens/main_page.dart';
// import '../utils/class_builder.dart';
// import './HomePage.dart';
// import '../Models/PlaceHolder.dart';
// import 'NotePage.dart';
// import './SettingsPage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DrawerPage extends StatefulWidget {
//   DrawerPage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _DrawerPageState createState() => _DrawerPageState();
// }

// class _DrawerPageState extends State<DrawerPage> with TickerProviderStateMixin {
//   KFDrawerController _drawerController;
//   List<String> theme;
//   String logo;
//   @override
//   void initState() {
//     super.initState();
//     theme = PlaceHolder.theme ?? PlaceHolder.theme1;
//     logo = PlaceHolder.logo ?? PlaceHolder.logoGrey;
//     onchange().then((_) {
//       setState(() {
//         theme = PlaceHolder.theme ?? PlaceHolder.theme1;
//         logo = PlaceHolder.logo ?? PlaceHolder.logoGrey;
//       });
//     });
//     //onchange();
//     _drawerController = KFDrawerController(
//       initialPage: ClassBuilder.fromString('MainPage'),
//       items: [
//         KFDrawerItem.initWithPage(
//           text: Text('New Note',
//               style: TextStyle(
//                   color: Color(PlaceHolder.hexToInt(theme[1])),
//                   fontFamily: PlaceHolder.fontfamily)),
//           icon: Icon(Icons.note, color: Color(PlaceHolder.hexToInt(theme[10]))),
//           page: MainPage(),
//           onPressed: () {
//             _newNoteTapped(PlaceHolder.homePageContext);
//           },
//         ),
//         KFDrawerItem.initWithPage(
//           text: Text(
//             'Trash',
//             style: TextStyle(
//                 color: Color(PlaceHolder.hexToInt(theme[1])),
//                 fontFamily: PlaceHolder.fontfamily),
//           ),
//           icon:
//               Icon(Icons.delete, color: Color(PlaceHolder.hexToInt(theme[10]))),
//           page: CalendarPage(),
//           onPressed: () {
//             Navigator.pushReplacement(
//                 PlaceHolder.homePageContext,
//                 MaterialPageRoute(
//                     builder: (BuildContext context) => TrashPage()));
//           },
//         ),
//         KFDrawerItem.initWithPage(
//           text: Text(
//             'Settins',
//             style: TextStyle(
//                 color: Color(PlaceHolder.hexToInt(theme[1])),
//                 fontFamily: PlaceHolder.fontfamily),
//           ),
//           icon: Icon(Icons.settings,
//               color: Color(PlaceHolder.hexToInt(theme[10]))),
//           page: ClassBuilder.fromString('SettingsPage'),
//           onPressed: () {
//             Navigator.push(PlaceHolder.homePageContext,
//                 MaterialPageRoute(builder: (ctx) => SettingsOnePage()));
//           },
//         ),
//       ],
//     );
//   }

//   onchange() async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();

//     String fontsize = pref.getString("fontsize");
//     String theme = pref.getString("theme");
//     String fontfamily = pref.getString("fontfamily");

//     if (fontsize == null) {
//       pref.setString("fontsize", "f2");
//       PlaceHolder.fontsize = PlaceHolder.fontsize2;
//       PlaceHolder.fs = 1;
//     }
//     if (theme == null) {
//       pref.setString("theme", "t2");
//       PlaceHolder.theme = PlaceHolder.theme2;
//       PlaceHolder.ts = 1;
//     }
//     if (fontfamily == null) {
//       pref.setString("fontfamily", "ff2");
//       PlaceHolder.fontfamily = PlaceHolder.fontFamilyPacifico;
//       PlaceHolder.ffs = 1;
//     }
//     if (fontsize != null && theme != null && fontfamily != null) {
//       setState(() {
//         String ttype = pref.getString("theme");
//         String ftype = pref.getString("fontsize");
//         String fftype = pref.getString("fontfamily");

//         if (ttype == "t1") {
//           PlaceHolder.theme = PlaceHolder.theme1;
//           PlaceHolder.logo = PlaceHolder.logoGrey;
//         } else if (ttype == "t2") {
//           PlaceHolder.theme = PlaceHolder.theme2;
//           PlaceHolder.logo = PlaceHolder.logoGrey;
//         } else if (ttype == "t3") {
//           PlaceHolder.theme = PlaceHolder.theme3;
//           PlaceHolder.logo = PlaceHolder.logoBlue;
//         } else if (ttype == "t4") {
//           PlaceHolder.theme = PlaceHolder.theme4;
//           PlaceHolder.logo = PlaceHolder.logoGreen;
//         }

//         if (ftype == "f1") {
//           PlaceHolder.fontsize = PlaceHolder.fontsize1;
//         } else if (ttype == "f2") {
//           PlaceHolder.fontsize = PlaceHolder.fontsize2;
//         } else if (ttype == "f3") {
//           PlaceHolder.fontsize = PlaceHolder.fontsize3;
//         }

//         if (fftype == "ff1") {
//           PlaceHolder.fontfamily = PlaceHolder.fontFamilyRoboto;
//         } else if (fftype == "ff2") {
//           PlaceHolder.fontfamily = PlaceHolder.fontFamilyPacifico;
//         }
//       });
//     }
//   }

//   void _newNoteTapped(BuildContext ctx) {
//     // "-1" id indicates the note is not new
//     var emptyNote = new Note(
//         -1, "", "", DateTime.now(), DateTime.now(), Colors.white, 0, 0);
//     Navigator.push(
//         ctx, MaterialPageRoute(builder: (ctx) => NotePage(emptyNote)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       body: KFDrawer(
// //        borderRadius: 0.0,
// //        shadowBorderRadius: 0.0,
// //        menuPadding: EdgeInsets.all(0.0),
// //        scrollable: true,
//         controller: _drawerController,
//         header: Align(
//           alignment: Alignment.centerLeft,
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 16.0),
//             width: MediaQuery.of(context).size.width * 0.6,
//             child: Image.asset(
//               logo,
//               height: 150,
//               width: 150,
//             ),
//             //   child:CircleAvatar(backgroundImage: AssetImage(
//             //     'Assets/logo.jpg',

//             //     //alignment: Alignment.centerLeft,
//             //   ),minRadius: 50,
//             // maxRadius: 90,)
//           ),
//         ),
//         footer: KFDrawerItem(
//           text: Text(
//             'Help & Feedback',
//             style: TextStyle(
//                 color: Color(PlaceHolder.hexToInt(theme[1])),
//                 fontFamily: PlaceHolder.fontfamily),
//           ),
//           icon: Icon(
//             Icons.help_outline,
//             color: Color(PlaceHolder.hexToInt(theme[1])),
//           ),
//           onPressed: () {
//             Navigator.of(context).push(CupertinoPageRoute(
//               fullscreenDialog: true,
//               builder: (BuildContext context) {
//                 return AuthPage();
//               },
//             ));
//           },
//         ),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(PlaceHolder.hexToInt(theme[1])),
//               Color(PlaceHolder.hexToInt(theme[10]))
//             ],
//             //colors: [Colors.green],
//             tileMode: TileMode.repeated,
//           ),
//         ),
//       ),
//     );
//   }
// }
