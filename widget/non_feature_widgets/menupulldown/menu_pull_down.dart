/* **********************************************************************
    File: menu_pull_down.dart
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
    Main class for MenuPullDown's Fields, Constructor, and Functions
 *************************************************************************/

import 'package:flutter/material.dart';
import '/widget/non_feature_widgets/navWidgets/menupulldown/menu_pull_down_state.dart';

class MenuPullDown extends StatefulWidget {
  // Map<Label, Route>
  Map<String, String?> routes;

  /* **********************************************************************
      Function Name:  MenuPullDown
      Input Parameters:
      String route - Map<String, String?> for routes to navigate to
                      dependent on which is text is clicked
      Output Parameter -
      MenuPullDown - Object for the MenuPullDown class
      Description :
      Constructor of the MenuPullDown used to initialize the object.
   *************************************************************************/
  MenuPullDown(this.routes, {super.key});

  @override
  State<StatefulWidget> createState() => MenuPullDownState();

  Map<String, String?> getRoutes() {
    return routes;
  }

  void setRoutes(Map<String, String?> routes) => this.routes = routes;
}
