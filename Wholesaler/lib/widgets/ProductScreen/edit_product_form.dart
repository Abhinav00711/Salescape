import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/global.dart';
import '../../models/product.dart';
import '../../services/firebase_storage_service.dart';
import '../../services/firestore_service.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  static final _formKey = new GlobalKey<FormState>();

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  UploadTask? task;
  File? image;
  bool _imgChange = false;

  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      setState(() {
        this.image = File(image.path);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String _name = '';
    String _price = '';
    String _stock = '';
    String _unit = '';
    String _desc = '';

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Edit Product',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          child: Form(
            key: EditProduct._formKey,
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color(0xFF3A5160).withOpacity(0.6),
                              offset: const Offset(2.0, 4.0),
                              blurRadius: 8),
                        ],
                      ),
                      child: image == null
                          ? new Image.network(
                              widget.product.imageUrl,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              image!,
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                    ),
                    FloatingActionButton(
                      child: Icon(Icons.add_a_photo),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text('Camera'),
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  await pickImage(ImageSource.camera);
                                  _imgChange = true;
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.image),
                                title: Text('Gallery'),
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  await pickImage(ImageSource.gallery);
                                  _imgChange = true;
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Name',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: widget.product.name,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 18.0),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: const Color(0xffFFA62B)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, color: const Color(0xffFFA62B)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          errorStyle: const TextStyle(color: Colors.amber),
                        ),
                        keyboardType: TextInputType.name,
                        autocorrect: false,
                        cursorColor: Colors.black,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product name.';
                          } else if (!RegExp('[a-zA-Z]')
                              .hasMatch(value.trim())) {
                            return 'Invalid product name';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _name = newValue!.trim();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Price',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: widget.product.price.toString(),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 18.0),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: const Color(0xffFFA62B)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, color: const Color(0xffFFA62B)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          errorStyle: const TextStyle(color: Colors.amber),
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),
                        autocorrect: false,
                        cursorColor: Colors.black,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product price.';
                          } else if (double.tryParse(value.trim()) == null) {
                            return 'Invalid Price';
                          } else if (double.parse(value.trim()) == 0.0) {
                            return 'Enter some value larger than 0';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _price = newValue!.trim();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Stock',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: widget.product.stock.toString(),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 18.0),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: const Color(0xffFFA62B)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, color: const Color(0xffFFA62B)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          errorStyle: const TextStyle(color: Colors.amber),
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: false,
                          signed: false,
                        ),
                        autocorrect: false,
                        cursorColor: Colors.black,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product stock.';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _stock = newValue!.trim();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Unit',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: widget.product.unit,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 18.0),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: const Color(0xffFFA62B)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.0, color: const Color(0xffFFA62B)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            errorStyle: const TextStyle(color: Colors.amber),
                            hintText: '(Eg:Pcs/Kg)'),
                        keyboardType: TextInputType.name,
                        autocorrect: false,
                        cursorColor: Colors.black,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product unit.';
                          } else if (!RegExp('[a-zA-Z]')
                              .hasMatch(value.trim())) {
                            return 'Invalid product unit';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _unit = newValue!.trim();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: widget.product.description,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 18.0),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: const Color(0xffFFA62B)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, color: const Color(0xffFFA62B)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          errorStyle: const TextStyle(color: Colors.amber),
                        ),
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 5,
                        maxLength: 200,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        autocorrect: false,
                        cursorColor: Colors.black,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product description.';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _desc = newValue!.trim();
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                      child: SizedBox(
                        child: ElevatedButton(
                          child: Text(
                            'CONFIRM',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () async {
                            if (EditProduct._formKey.currentState!.validate()) {
                              EditProduct._formKey.currentState!.save();
                              String url = widget.product.imageUrl;
                              if (_imgChange == true) {
                                task = FirebaseStorageService.uploadImage(
                                    Global.userData!.wid,
                                    widget.product.pid,
                                    image!);
                                final snapshot =
                                    await task!.whenComplete(() {});
                                url = await snapshot.ref.getDownloadURL();
                              } else {
                                url = widget.product.imageUrl;
                              }

                              Product product1 = Product(
                                pid: widget.product.pid,
                                wid: Global.userData!.wid,
                                wname: Global.userData!.name,
                                bname: Global.userData!.bname,
                                industry: Global.userData!.industry,
                                name: _name,
                                description: _desc,
                                price: double.parse(_price),
                                stock: int.parse(_stock),
                                unit: _unit,
                                imageUrl: url,
                              );
                              await FirestoreService().addProduct(product1);
                              Navigator.of(context).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            primary: Colors.amber,
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            shadowColor: Colors.amberAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      child: SizedBox(
                        child: ElevatedButton(
                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            primary: Colors.amber,
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            shadowColor: Colors.amberAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
