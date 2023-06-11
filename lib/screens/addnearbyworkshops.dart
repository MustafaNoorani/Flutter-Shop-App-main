
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/provider/nearbyworkshps_class.dart';
import 'package:shop_app/screens/WholesalerProfile.dart';
import '../../routes/routes.dart';

class AddNearByWorkshops extends StatefulWidget {
  const AddNearByWorkshops({Key? key}) : super(key: key);

  @override
  State<AddNearByWorkshops> createState() => _AddNearByWorkshopsState();
}

class _AddNearByWorkshopsState extends State<AddNearByWorkshops> {
  final TextEditingController _lat = TextEditingController();
  final TextEditingController _long = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _lat.dispose();
    _long.dispose();
    _title.dispose();
    super.dispose();
  }


  void _submitForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    workshop().add_marker(double.parse(_lat.text), double.parse(_long.text), _title.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Shop Added successfully",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) =>WholesalerProfile()));
   // Navigator.of(context).pushNamed(Routes.userProduct);
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Shop",
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          TextButton(
            onPressed: () {
              //print(SelectedItem);
              //userId = (user.json_data['data']['userid']);
              _submitForm();
              //add_product(userId,_productName.text,_productPrice.text,_productQuantity.text,_productDescription.text,image,SelectedItem);

            },
            child: const Icon(
              Icons.save,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body:
      Padding(
        padding: EdgeInsets.only(
          left: _screenSize.width * 0.03,
          right: _screenSize.width * 0.03,
        ),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              SizedBox(
                height: _screenSize.height * 0.05,
              ),
              TextFormField(
                controller: _lat,
                decoration: const InputDecoration(
                  labelText: "Lat",
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
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validator: (inputValue) {
                  if (inputValue == "") {
                    return "Lat is empty.";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: _screenSize.height * 0.04,
              ),
              TextFormField(
                controller: _long,
                decoration: const InputDecoration(
                  labelText: "Long",
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
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validator: (inputValue) {
                  if (inputValue == "") {
                    return "Long is empty.";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: _screenSize.height * 0.04,
              ),

              TextFormField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: "Title",
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
                    return "Please provide Title.";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: _screenSize.height * 0.04,
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}
