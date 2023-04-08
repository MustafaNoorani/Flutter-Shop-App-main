
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/product_provider.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({Key? key}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _productQuantity = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _productPrice.dispose();
    _productQuantity.dispose();
    super.dispose();
  }

  void _submitForm(product,String productId ) {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    product.update_product(productId,_productPrice.text,_productQuantity.text);
    //product.updateproduct();
    _form.currentState!.save();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Product updated successfully",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    var product = Provider.of<ProductProvider>(context);
    String productId = ModalRoute.of(context)!.settings.arguments as String;
    print(productId);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Product",
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _submitForm(product,productId);

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

            ],
          ),
        ),
      ),
    );
  }
}
