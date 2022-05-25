import 'package:flutter/cupertino.dart';

class ListOfLists {
  List<int> codeId = [];
  List<String> nameUser = [];
  List<String> dob = [];
  List<String> email = [];
  List<String> homeAddress = [];
  List<Row> dataBase = [];

  void codeIdSetter(int value){
    codeId.add(value);
  }
  int codeIdGetter(int value){
    return codeId[value];
  }
  void nameUserSetter(String value){
    nameUser.add(value);
  }
  String nameUserGetter(int value){
    return nameUser[value];
  }
  void dobSetter(String value){
    dob.add(value);
  }
  String dobGetter(int value){
    return dob[value];
  }
  void emailSetter(String value){
    email.add(value);
  }
  String emailGetter(int value){
    return email[value];
  }
  void addressSetter(String value){
    homeAddress.add(value);
  }
  String addressGetter(int value){
    return homeAddress[value];
  }

  void dataBaseSetter(Row rowToDisplay){
    dataBase.add(rowToDisplay);
  }

  List<Row> dataBaseGetter(){
    return dataBase;
  }
}