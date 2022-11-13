import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/const/app_colors.dart';
import 'package:e_commerce/ui/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetails extends StatefulWidget {
  var _product;
  ProductDetails(this._product);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var _dotPosition = 0;
  Future addToCard() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-card-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "image": widget._product["product-img"],
    }).then((value) => Fluttertoast.showToast(msg: "Added Successfully"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.deep_orange,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: AppColors.deep_orange,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 2,
                child: CarouselSlider(
                  items: widget._product['product-img']
                      .map<Widget>(
                        (item) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(item),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      }),
                ),
              ),
              Center(
                child: DotsIndicator(
                  dotsCount: widget._product['product-img'].length == 0
                      ? 1
                      : widget._product['product-img'].length,
                  position: _dotPosition.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: Colors.black,
                    color: Colors.grey,
                    spacing: EdgeInsets.all(2),
                    activeSize: Size(10, 10),
                    size: Size(8, 8),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                widget._product["product-name"],
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget._product["product-price"].toString(),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                widget._product["product-description"],
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                width: 1.sw,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    addToCard();
                  },
                  child: Text(
                    "Add to cart",
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.deep_orange,
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
