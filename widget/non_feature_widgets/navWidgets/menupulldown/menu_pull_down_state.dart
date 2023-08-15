/* **********************************************************************
    File: menu_pull_down_state.dart
    Date: 03-21-2023
    Author: Daryl Ng
    Copyright Information:
    Information contained herein is proprietary to and constitutes valuable
    confidential trade secrets of Top Run , or its licensors, and
    is subject to restrictions on use and disclosure.
    Copyright (c)  2023 Top Run Inc. All rights reserved.
    The copyright notices above do not evidence any actual or
    intended publication of this material.
    Description :
    Handles the states for MenuPullDown.
 *************************************************************************/

import 'package:flutter/material.dart';
import '/utilities/strDictionary.dart';
import '/widget/non_feature_widgets/navWidgets/menupulldown/menu_pull_down.dart';

import '/core/config/authentication.dart';
import '../../../user_singleton/user_singleton.dart';


class MenuPullDownState extends State<MenuPullDown>
{
  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      FractionallySizedBox - all widgets that make up MenuPullDown class
      Description :
      Handles the building, states, and routing for the MenuPullDown
   *************************************************************************/
  @override
  Widget build(BuildContext context) {

    return FractionallySizedBox(
      child: PopupMenuButton(onSelected: (value) {
        setState(() async {
          if(value == loginRoute)
          {
            AmplifyAuthentication auth = AmplifyAuthentication();
            UserSingleton existingUser = UserSingleton();

            await auth.signOutUser();
            existingUser.setExistingUser(await auth.isUserSignedIn());
            print("inside dispatcher menu pull down: _isSignedIn: ${existingUser.getExistingUser()}");
          }

          Navigator.pushNamed(context, value);
        });
      }, itemBuilder: (BuildContext context) {
        return widget.routes.entries.map((MapEntry<String, String?> element) {
          return PopupMenuItem(
            value: element.value,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(element.key),
            ),
          );
        }).toList();
      }),
    );
  }
}
