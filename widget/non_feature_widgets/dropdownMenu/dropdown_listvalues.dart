import '/utilities/strDictionary.dart';

class DropDownVar {
  // Defined list of payment term
  static final List<String> _paymentTermList = <String>[
    '1 day',
    '2 days',
    '5 days',
    '10 days',
    '15 days',
    '30 days'
  ];

  // Defined list of payment type
  static final List<String> _paymentTypeList = <String>[
    'Mailed Check',
    'ACH',
    'COD',
    'COP (Charge on Pickup)'
  ];

  // Defined list of States
  static final List<String> _usaStates = <String>[
    'AL',
    'AK',
    'AS',
    'AZ',
    'AR',
    'CA',
    'CO',
    'CT',
    'DE',
    'DC',
    'FM',
    'FL',
    'GA',
    'GU',
    'HI',
    'ID',
    'IL',
    'IN',
    'IA',
    'KS',
    'KY',
    'LA',
    'ME',
    'MH',
    'MD',
    'MA',
    'MI',
    'MN',
    'MS',
    'MO',
    'MT',
    'NE',
    'NV',
    'NH',
    'NJ',
    'NM',
    'NY',
    'NC',
    'ND',
    'MP',
    'OH',
    'OK',
    'OR',
    'PW',
    'PA',
    'PR',
    'RI',
    'SC',
    'SD',
    'TN',
    'TX',
    'UT',
    'VT',
    'VI',
    'VA',
    'WA',
    'WV',
    'WI',
    'WY'
  ];

  // Initializing _statusList
  static List<String> _statusList = <String>[];

  /* **********************************************************************
      Function Name: setCurrentStatus
      Input Parameters:
      String status - current status of the delivery
      String role - account type (shipper, transporter, ...)
      Output Parameter:
      None
      Description :
      Setting drop down list item to deffer depending on delivery 
      status and role
   *************************************************************************/
  static void setCurrentStatus(String status, String role) {
    if (role == "transporter") {
      if (status == "In Contract") {
        _statusList = <String>["In Contract", "Picked up", "Abort"];
      } else if (status == "Available") {
        _statusList = <String>["Make Offer"];
      } else if (status == "Make Offer") {
        _statusList = <String>["Offer Made", "Delete Offer"];
      } else if (status == "Abort") {
        _statusList = <String>["Abort"];
      } else if (status == "Picked up") {
        _statusList = <String>["Picked up"];
      } else if (status == "Verified Pickup") {
        _statusList = <String>["Verified Pickup", "In Route"];
      } else if (status == "In Route") {
        _statusList = <String>["In Route", "Delivered"];
      } else if (status == "Delivered") {
        _statusList = <String>["Delivered"];
      } else if (status == "Complaint") {
        _statusList = <String>["Complaint"];
      }
      else {
        // Default case for illegal input
        _statusList = <String>["Make Offer"];
      }
    } else if (role == "shipper") {
      if (status == "new") {
        _statusList = <String>["Available", "Save As Draft"];
      } else if (status == "Save As Draft") {
        _statusList = <String>["Save As Draft", "Available", "Deleted"];
      } else if (status == "Available") {
        _statusList = <String>["Available", "In Contract", "Deleted"];
      } else if (status == "Offers Available") {
        _statusList = <String>["Offers Available", "In Contract", "Deleted"];
      } else if (status == "In Contract") {
        _statusList = <String>["In Contract", "Abort"];
      } else if (status == "Abort") {
        _statusList = <String>["Abort", "Available", "Deleted"];
      } else if (status == "Picked up") {
        _statusList = <String>["Picked up", "Verified Pickup"];
      } else if (status == "Verified Pickup") {
        _statusList = <String>["Verified Pickup"];
      } else if (status == "In Route") {
        _statusList = <String>["In Route"];
      } else if (status == "Delivered") {
        _statusList = <String>["Delivered", "Complaint"];
      } else if (status == "Complaint") {
        _statusList = <String>["Complaint"];
      }
      else {
        // Default case for illegal input - Assume Available
        _statusList = <String>["Available", "In Contract", "Deleted"];
      }
    }
  }

  static List<String> getPaymentTermList() {
    return _paymentTermList;
  }

  static List<String> getPaymentTypeList() {
    return _paymentTypeList;
  }

  /* **********************************************************************
      Function Name: getStatusList
      Input Parameters:
      String curStatus - current status of the delivery
      String role - account type (shipper, transporter, ...)
      Output Parameter:
      None
      Description :
      To change the current status to be displayed different on the dropdown
      depending on account type
   *************************************************************************/
  static List<String> getStatusList(String curStatus, String role) {
    if (curStatus == "Make Offer" && role == "shipper") {
      curStatus = "Offers Available";
    }

    if (curStatus == "Delete Offer" && role == "transporter") {
      curStatus = "Available";
    }

    setCurrentStatus(curStatus, role);

    return _statusList;
  }

  static List<String> getStateList() {
    return _usaStates;
  }

  // new lists added by Daryl

  // bool getContractStatus for valid packages to route (routing all packages)
  /* **********************************************************************
      Function Name: static final List<String> _accountTypeList
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      List of Account Types for CustomDropDown Widget.
   *************************************************************************/
  static final List<String> _accountTypeList = <String>[
    'Customer',
    'Shipper',
    'Transporter',
    'Dispatcher',
    'Employee',
  ];

  /* **********************************************************************
      Function Name: static List<String> getAccountTypeList
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Get List of Account Types for CustomDropDown Widget.
   *************************************************************************/
  static List<String> getAccountTypeList() {
    return _accountTypeList;
  }

  static final List<String> _customerAccountTypeList = <String>[
    'Customer',
    'Shipper',
  ];

  static List<String> getCustomerAccountTypeList() {
    return _customerAccountTypeList;
  }

  /* **********************************************************************
      Function Name: static final List<String> _paymentSettingList
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      List of Payment Settings for CustomDropDown Widget.
   *************************************************************************/
  static final List<String> _paymentSettingList = <String>[
    'Bank Transfers',
    // 'Credit Card',
  ];

  /* **********************************************************************
      Function Name: static List<String> getPaymentSettingList
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Get List of Payment Settings for CustomDropDown Widget.
   *************************************************************************/
  static List<String> getPaymentSettingList() {
    return _paymentSettingList;
  }

  /* **********************************************************************
      Function Name: static final List<String> _monthList
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      List of Months for CustomDropDown Widget.
   *************************************************************************/
  static final List<String> _monthList = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  /* **********************************************************************
      Function Name: static List<String> getMonthList
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Get List of Months for CustomDropDown Widget.
   *************************************************************************/
  static List<String> getMonthList() {
    return _monthList;
  }

  /* **********************************************************************
      Function Name: static final List<String> _monthList
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      List of Years for CustomDropDown Widget starting from first year to
      the last year.
   *************************************************************************/
  static List<String> getYearList(int firstYear, int lastYear) {
    Set<String> years = {};
    for (int i = firstYear; i <= lastYear; i++) {
      years.add(i.toString());
    }

    return years.toList();
  }

  /* **********************************************************************
      Function Name: static final List<String> _bankAccountType
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      List of Bank Account Types for CustomDropDown Widget.
   *************************************************************************/
  static final List<String> _bankAccountType = <String>[
    'Checking',
    'Savings',
  ];

  /* **********************************************************************
      Function Name: static List<String> getMonthList
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Get List of Bank Account Types for CustomDropDown Widget.
   *************************************************************************/
  static List<String> getBankAccountTypeList() {
    return _bankAccountType;
  }

  /* **********************************************************************
      Function Name: static final Map<String, String?> _dispatcherMenu
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      List of Dispatcher Options for Pull Down Menu Widget.
   *************************************************************************/
  static final Map<String, String?> _dispatcherMenu = <String, String?>{
    'Home': dispatcherRoute,
    'Switch/Delete Accounts': null,
    'Add Accounts': null,
    'Transporter Vehicle Configuration': null,
    'Account and Credit': accountRoute,
    'Deliveries Status': null,
    'Transporter Configuration': null,
    'Accounting': null,
    'Logout': loginRoute,
  };

  /* **********************************************************************
      Function Name: static List<String> getMonthList
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Get List of Dispatcher Options for Pull Down Menu Widget.
   *************************************************************************/
  static Map<String, String?> getDispatcherMenuList() {
    return _dispatcherMenu;
  }

  /* **********************************************************************
      Function Name: static final Map<String, String?> _dispatcherMenu
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      List of Delivery Details Options for Pull Down Menu Widget.
   *************************************************************************/
  static final Map<String, String?> _deliveryDetailsMenu = <String, String?>{
    'Home': transporterRoute,
    'Switch/Delete Accounts': null,
    'Add Accounts': null,
    'Deliveries Packages': null,
    'Bill of Lading': null,
    'Shipper Information': null,
    'Transporter Vehicle Configuration': null,
    'Account and Credit': accountRoute,
    'Deliveries Status': null,
    'Transporter Configuration': null,
    'Accounting': null,
    'Logout': loginRoute,
  };

  /* **********************************************************************
      Function Name: static List<String> getMonthList
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Get List of Delivery Details Options for Pull Down Menu Widget.
   *************************************************************************/
  static Map<String, String?> getDeliveryDetailsMenuList() {
    return _deliveryDetailsMenu;
  }
}
