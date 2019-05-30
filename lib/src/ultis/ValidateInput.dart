class ValidateInput{
  static String validateEmail(String value){
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if(checkEmpty(value))
      return 'Email is Empty';
    else if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  static String validatePassWord(String value){
    if(value.length < 6){
      return 'Password must be more than 6 digits';
    }else if(checkEmpty(value)){
      return ' Password is Empty';
    }else{
      return null;
    }
  }

  static bool checkEmpty(String value){
    if(value.length == 0){
      return true;
    }else{
      return false;
    }
  }

  static bool checkFinalValidate(String email,String pass){
    if(validateEmail(email) == null && validatePassWord(pass) == null ){
      return true;
    }else{
      return false;
    }
  }
}