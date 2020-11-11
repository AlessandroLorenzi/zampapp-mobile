import 'package:flutter/material.dart';
import 'package:zampapp_mobile/models/user.dart';

class SideMenu extends StatelessWidget {
  final User loggedUser;
  final VoidCallback onLogoutSelected;
  final Function() onLogoutChanged;


  SideMenu({
    @required this.onLogoutChanged,
    @required this.loggedUser,
    this.onLogoutSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Text(
                loggedUser.nickname,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              alignment: Alignment.bottomRight,
              height: 1,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                image: NetworkImage(loggedUser.picture),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: (){
                onLogoutChanged();
                Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

}
