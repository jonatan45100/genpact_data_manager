import 'package:flutter/material.dart';
import 'package:genpact_data_manager/list_of_lists.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

void main() => runApp(const BodyApp());

class BodyApp extends StatelessWidget {
  const BodyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue.shade500,
          appBar: AppBar(
            backgroundColor: Colors.blue.shade800,
            centerTitle: true,
            title: Text(
              'Genpact Data Base',
              style: GoogleFonts.nunito(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: const CustomForm(),
        ),
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({Key? key}) : super(key: key);

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  int codeIdNumber = 0;

  final myNameController = TextEditingController();
  final myDobDController = TextEditingController();
  final myDobMController = TextEditingController();
  final myDobYController = TextEditingController();
  final myEmailController = TextEditingController();
  final myAddressController = TextEditingController();

  ListOfLists listOfLists = ListOfLists();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    myNameController.dispose();
    myDobMController.dispose();
    myDobDController.dispose();
    myDobYController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Data input',
              style: GoogleFonts.koulen(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                letterSpacing: 2.5,
              ),
            ),
          ),
          Row(
            children: [
              expandedMethod(
                  flexNumber: 4,
                  text: myNameController,
                  hintName: 'Name',
                  stringValue: 'name'),
              expandedMethod(
                  flexNumber: 1,
                  text: myDobMController,
                  hintName: 'Month of birth',
                  stringValue: 'month'),
              expandedMethod(
                  flexNumber: 1,
                  text: myDobDController,
                  hintName: 'Day of birth',
                  stringValue: 'day'),
              expandedMethod(
                  flexNumber: 1,
                  text: myDobYController,
                  hintName: 'Year of birth',
                  stringValue: 'year'),
              expandedMethodNoValidation(
                  flexNumber: 1, text: myEmailController, hintName: 'Email'),
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      myAddressController.text = 'No data';
                    }
                    return null;
                  },
                  controller: myAddressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Address',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.orange.shade500),
                    ),
                    onPressed: () {
                      setState(() {
                        myNameController.text = '';
                        myDobMController.text = '';
                        myDobDController.text = '';
                        myDobYController.text = '';
                        myEmailController.text = '';
                        myAddressController.text = '';
                      });
                    },
                    child: const Text(
                      'Clear text fields',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.orange.shade700),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          listOfLists.codeIdSetter(codeIdNumber);
                          listOfLists.nameUserSetter(myNameController.text);
                          listOfLists.dobSetter(
                              '${myDobMController.text}/${myDobDController.text}/${myDobYController.text}');
                          listOfLists.emailSetter(myEmailController.text);
                          listOfLists.addressSetter(myAddressController.text);
                          listOfLists.dataBaseSetter(listOfData(
                              identifier: listOfLists.codeIdGetter(codeIdNumber),
                              nameUser: listOfLists.nameUserGetter(codeIdNumber),
                              dob: listOfLists.dobGetter(codeIdNumber),
                              emailUser: listOfLists.emailGetter(codeIdNumber),
                              homeAddress: listOfLists.addressGetter(codeIdNumber),
                              context: context));
                          codeIdNumber++;
                        });
                      }
                    },
                    child: const Text(
                      'Add data to List',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.orangeAccent),
                    ),
                    onPressed: () {},
                    child: const Text('Export data'),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: listOfLists.dataBaseGetter(),
          ),
        ],
      ),
    );
  }

  Row listOfData(
      {required int identifier,
        required String nameUser,
        required String dob,
        required String emailUser,
        required String homeAddress,
        required BuildContext context}) {

    return Row(
      children: [
        expandedRow(
          flexValue: 1,
          iconToUse: const Icon(Icons.format_list_numbered_rounded),
          titleName: identifier.toString(),
        ),
        expandedRow(
            flexValue: 3,
            iconToUse: const Icon(Icons.person),
            titleName: nameUser),
        expandedRow(
            flexValue: 3,
            iconToUse: const Icon(Icons.calendar_today),
            titleName: dob),
        expandedRow(
            flexValue: 3,
            iconToUse: const Icon(Icons.email),
            titleName: emailUser),
        expandedRow(
            flexValue: 3,
            iconToUse: const Icon(Icons.house),
            titleName: homeAddress),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () {},
              child: const Icon(Icons.edit),
            ),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Warning!'),
                  content: const Text(
                      'Are you sure? this action cannot be undone, enter the id number to confirm'),
                  actions: <Widget>[
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState((){
                            listOfLists.dataBaseGetter().removeAt(identifier);
                            listOfLists.codeId.removeAt(identifier);
                            listOfLists.nameUser.removeAt(identifier);
                            listOfLists.dob.removeAt(identifier);
                            listOfLists.email.removeAt(identifier);
                            listOfLists.homeAddress.removeAt(identifier);
                            codeIdNumber--;
                          });
                          Navigator.pop(context, 'Confirm');
                        },
                        child: const Text('Confirm'),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: const Icon(Icons.delete),
          ),
        ),
      ],
    );
  }
}

Expanded expandedMethod(
    {required int flexNumber,
      required TextEditingController text,
      required String hintName,
      required String stringValue}) {
  return Expanded(
    flex: flexNumber,
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a $stringValue';
        }
        return null;
      },
      controller: text,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintName,
      ),
    ),
  );
}

Expanded expandedMethodNoValidation(
    {required int flexNumber,
      required TextEditingController text,
      required String hintName}) {
  return Expanded(
    flex: flexNumber,
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          text.text = 'No data';
        } else {
          if (EmailValidator.validate(text.text)) {
          } else {
            return 'Invalid format';
          }
        }
        return null;
      },
      controller: text,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintName,
      ),
    ),
  );
}

Expanded expandedRow(
    {required flexValue, required Icon iconToUse, required String titleName}) {
  return Expanded(
    flex: flexValue,
    child: Card(
      child: ListTile(
        leading: iconToUse,
        title: Text(titleName),
      ),
    ),
  );
}