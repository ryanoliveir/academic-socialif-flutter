

import 'package:flutter/material.dart';
import 'package:social_if/components/drawer_list.dart';

class DrawerCustom extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onLogoutTap;


  const DrawerCustom({
    required this.onProfileTap,
    required this.onLogoutTap,
    super.key
  });


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
              Container(
              margin: const EdgeInsets.only(top: 90, bottom: 70),
              child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 64
            )
            
          ),
          DrawerList(
            icon: Icons.home, 
            textTitle: 'H O M E',
            onTap: () => Navigator.pop(context)
          ),
          DrawerList(
            icon: Icons.person, 
            textTitle: 'P R O F I L E',
            onTap: onProfileTap
          ),
          ],),

          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: DrawerList(
              icon: Icons.logout, 
              textTitle: 'L O G O U T',
              onTap: onLogoutTap
            ),
          ),
        ],
      ),
    );
  }
}