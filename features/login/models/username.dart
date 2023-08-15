/* **********************************************************************
    File: username.dart
    Date: 02-22-2023
    Author: Daryl Ng
    Copyright Information:
    Information contained herein is proprietary to and constitutes valuable
    confidential trade secrets of Top Run , or its licensors, and
    is subject to restrictions on use and disclosure.
    Copyright (c)  2023 Top Run Inc. All rights reserved.
    The copyright notices above do not evidence any actual or
    intended publication of this material.
    Description :
    Main class for Username's Fields, Constructor, and Functions
 *************************************************************************/

import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError>
{
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  /* **********************************************************************
      Function Name:  UsernameValidationError? validator
      Input Parameters:
      String value - value of the username
      Output Parameter:
      UsernameValidationError? - value if the username is empty
      Null - value if the username is not empty
      Description :
      Checks if username is empty.
   *************************************************************************/  @override
  UsernameValidationError? validator(String value)
  {
    if (value.isEmpty)
    {
      return UsernameValidationError.empty;
    }

    return null;
  }
}