import 'package:api/Api1/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // logo
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
               ),
              ),
            ),

          // home title
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25.0),
            child: ListTile(
              title: Text("H O M E"),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),

          // setting title
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 0.0),
            child: ListTile(
              title: Text("S E T T I N G S"),
              leading: Icon(Icons.home),
              onTap: () {
                // Pop Drawer
              //  Navigator.pop(context);
                // navigate to setting page
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),));
              },
            ),
          )
        ],

      ),
    );
  }
}
