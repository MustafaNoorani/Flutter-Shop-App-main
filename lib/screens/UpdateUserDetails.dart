
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/user_id_class.dart';
import '../../provider/user_provider.dart';

class UpdateUserDetails extends StatefulWidget {
  const UpdateUserDetails({Key? key}) : super(key: key);

  @override
  State<UpdateUserDetails> createState() => _UpdateUserDetailsState();
}

class _UpdateUserDetailsState extends State<UpdateUserDetails> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _userphone = TextEditingController();
  final _form = GlobalKey<FormState>();
  String Email= "";
  var username = "";
  @override
  void initState()  {
    super.initState();
    UserID.updateJsonDataWholesaler();
    username =UserID.userid_Wholesaler.toString() ;

  }
  @override
  void dispose() {
    _username.dispose();
    _userphone.dispose();
    super.dispose();
  }

  void _submitForm(user) {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "User Data updated successfully",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    var vendor = Provider.of<DataClass>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Details",
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _submitForm(vendor);
              vendor.updatedata(username, _userphone.text.toString(), _username.text.toString());

            },
            child: const Icon(
              Icons.save,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: _screenSize.width * 0.03,
          right: _screenSize.width * 0.03,
        ),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              SizedBox(
                height: _screenSize.height * 0.04,
              ),
              TextFormField(
                controller: _username,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                textInputAction: TextInputAction.next,
                validator: (inputValue) {
                  if (inputValue == "") {
                    return "Name is empty.";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: _screenSize.height * 0.04,
              ),
              TextFormField(
                controller: _userphone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                textInputAction: TextInputAction.next,
                validator: (inputValue) {
                  if (inputValue == "") {
                    return "Number is empty.";
                  } else {
                    return null;
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
