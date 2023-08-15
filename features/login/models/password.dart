/* **********************************************************************
    File: password.dart
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
    Main class for Password's Fields, Constructor, and Functions
 *************************************************************************/

import 'package:formz/formz.dart';

enum PasswordValidationError { empty }

class Password extends FormzInput<String, PasswordValidationError>
{
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  /* **********************************************************************
      Function Name:  PasswordValidationError? validator
      Input Parameters:
      String value - value of the password
      Output Parameter:
      PasswordValidationError? - value if the password is empty
      Null - value if the password is not empty
      Description :
      Checks if password is empty.
   *************************************************************************/  @override
  PasswordValidationError? validator(String value)
  {
    if (value.isEmpty)
    {
      return PasswordValidationError.empty;
    }

    return null;
  }
}