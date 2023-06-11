import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/user_id_class.dart';
import 'package:shop_app/screens/login_registration/wholesaler_registration.dart';
import 'package:shop_app/screens/profile.dart';
import 'package:shop_app/screens/user_products/user_products.dart';
import '../../models/product.dart';
import '../../provider/user_provider.dart';
import '../../routes/routes.dart';
import '/provider/product_provider.dart';
import 'package:http/http.dart' as http;

class predictimage extends StatefulWidget {
  const predictimage({Key? key}) : super(key: key);

  @override
  State<predictimage> createState() => _predictimageState();
}

class _predictimageState extends State<predictimage> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _productDescription = TextEditingController();
  final TextEditingController _productImage = TextEditingController();
  final TextEditingController _productQuantity = TextEditingController();
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
    _productName.dispose();
    _productPrice.dispose();
    _productDescription.dispose();
    _productImage.dispose();
    _productQuantity.dispose();
    super.dispose();
  }
  Future<void> predictimage(String image) async{
    Product data = Product(
        id: '',
        productName: '',
        price: 0,
        imageUrl: image
      //image: image
    );
    try {
      //print("try");
      http.Response response =
      await http.post(
          Uri.parse("http://4018-34-171-247-56.ngrok.io/returnjson"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.tooJson()));
      var decodedjson = jsonDecode(response.body);
      print(decodedjson);
          _productName.text=decodedjson["ProductName"].toString();
          _productQuantity.text = decodedjson["quantity"].toString();


    }
    catch (e) {
      print(e.toString());
    }

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
                      predictimage(image);
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
                      predictimage(image);
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
    product.add_product(username,_productName.text,_productPrice.text,_productQuantity.text,_productDescription.text,image,SelectedItem);

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
    //Navigator.of(context).pushNamed(Routes.userProduct);
    // Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => Profile()));

  }
  List<String> items = ['Body Parts', 'Electrical Parts', 'Engine Parts'];
  String? SelectedItem= 'Electrical Parts';
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    var user = Provider.of<DataClass>(context);
    var product = Provider.of<ProductProvider>(context);
    String userId = "Default";
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
              userId = (user.json_data['data']['userid']);
              _submitForm(userId,product);
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

              // SizedBox(
              //   height: _screenSize.height * 0.04,
              // ),
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

                  // Text(),
                ],

              ),
              ElevatedButton(
                onPressed: () {
                  predictimage(image);
                },
                child: Text('predict'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
