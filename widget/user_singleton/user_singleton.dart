/* **********************************************************************
    File: user_singleton.dart
    Date: 03-21-2023
    Author Daryl Ng
    Copyright Information:
    Information contained herein is proprietary to and constitutes valuable
    confidential trade secrets of Top Run , or its licensors, and
    is subject to restrictions on use and disclosure.
    Copyright (c)  2023 Top Run Inc. All rights reserved.
    The copyright notices above do not evidence any actual or
    intended publication of this material.
    Description :
    Singleton Model that handles if there is an existing user logged in.
 *************************************************************************/

import 'package:flutter/material.dart';

class UserSingleton extends StatelessWidget
{
  bool existingUser;

  static final UserSingleton _existingUserSingleton = UserSingleton._internal();

  factory UserSingleton() {return _existingUserSingleton;}

  UserSingleton._internal():existingUser = false;

  bool getExistingUser() {return existingUser;}
  void setExistingUser(bool existingUser) => this.existingUser = existingUser;

  @override
  Widget build(BuildContext context)
  {
    throw UnimplementedError();
  }
}