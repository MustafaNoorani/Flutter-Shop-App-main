import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../provider/user_id_class.dart';
import '../../routes/routes.dart';
import '/provider/product_provider.dart';

class AddUserProduct extends StatefulWidget {
  const AddUserProduct({Key? key}) : super(key: key);

  @override
  State<AddUserProduct> createState() => _AddUserProductState();
}

class _AddUserProductState extends State<AddUserProduct> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _productDescription = TextEditingController();
  final TextEditingController _productImage = TextEditingController();
  final TextEditingController _productQuantity = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _productName.dispose();
    _productPrice.dispose();
    _productDescription.dispose();
    _productImage.dispose();
    _productQuantity.dispose();
    super.dispose();
  }
  XFile? _image;
  final _picker = ImagePicker();
  var image;
  Future getImage(ImageSource media) async {
    var img = await _picker.pickImage(source: media,imageQuality: 20,maxHeight: 626,maxWidth: 417);
    if(img != null ) {
      String imagepath = img.path;
//image path, you can get it with image_picker package
      File imagefile = File(imagepath); //convert Path to File
      Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
      image = base64.encode(imagebytes); //convert bytes to base64 string
    }

    setState(() {
      _image = img;
    });
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }


  void _submitForm(String userId,product) {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    product.add_product(userId,_productName.text,_productPrice.text,_productQuantity.text,_productDescription.text,image,SelectedItem,"w");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Product Added successfully",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.of(context).pushNamed(Routes.userProduct);
    // Navigator.pop(context);
  }
  List<String> items = ['Body Parts', 'Electrical Parts', 'Engine Parts'];
  String? SelectedItem= 'Electrical Parts';

  String Email= "";
  var username = "";
  @override
  void initState()  {
    super.initState();
    UserID.updateJsonDataWholesaler();
    username =UserID.userid_Wholesaler.toString() ;

  }
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    var product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Product",
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          TextButton(
            onPressed: () {
              //print(SelectedItem);
              _submitForm(username,product);
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
      body: username != "" || username != null ?
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
                controller: _productName,
                decoration: const InputDecoration(
                  labelText: "product name",
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
                    return "Please provide product name.";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: _screenSize.height * 0.04,
              ),
              TextFormField(
                controller: _productPrice,
                decoration: const InputDecoration(
                  labelText: "price",
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
                    return "Product price is empty.";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: _screenSize.height * 0.04,
              ),
              TextFormField(
                controller: _productQuantity,
                decoration: const InputDecoration(
                  labelText: "Quantity",
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
                    return "Product Quantity is empty.";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: _screenSize.height * 0.04,
              ),
              TextFormField(
                controller: _productDescription,
                decoration: const InputDecoration(
                  labelText: "Description",
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
                maxLines: 4,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                validator: (inputValue) {
                  if (inputValue == "") {
                    return "Product description is empty.";
                  }
                  if (inputValue!.length < 2) {
                    return "Product description must be greater than 15.";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: _screenSize.height * 0.04,
              ),
              DropdownButtonFormField<String>(
                //controller: _productDescription,
                decoration: const InputDecoration(
                  labelText: "Category Type",
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
                value: SelectedItem,items:items.map((item) => DropdownMenuItem<String>(value: item,child: Text(item,style: TextStyle(fontSize: 15),),)).toList(),
                onChanged:(item)=> setState(() {
                  SelectedItem=item;
                }),

              ),

              SizedBox(
                height: _screenSize.height * 0.04,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            myAlert();
                          },
                          child: Text('Upload Photo'),
                        ),
                        SizedBox(
                          height: _screenSize.height * 0.04,
                        ),
                        //if image not null show the image
                        //if image null show text
                        _image != null
                            ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              //to show image, you type like this.
                              File(_image!.path),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width/2,
                              height: MediaQuery.of(context).size.height/6,
                            ),
                          ),
                        )
                            : Text(
                          "No Image",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ) : CircularProgressIndicator(),
    );
  }
}
