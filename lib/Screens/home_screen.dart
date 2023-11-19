import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transigo_app/Components/Drawer.dart';
import 'package:transigo_app/Components/Offer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> offers = [
    Offer(
      offerImage: 'assets/Offer 01.png',
    ),
    Offer(
      offerImage: 'assets/Offer 2.png',
    ),
    Offer(
      offerImage: 'assets/Offer 3.png',
    ),
    Offer(
      offerImage: 'assets/Offer 4.png',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => scaffoldKey.currentState!.openDrawer(),
          child: Container(
            margin: const EdgeInsets.only(left: 8.0),
            child: SvgPicture.asset(
              'assets/icons/Drawer Menu.svg',
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SvgPicture.asset(
              'assets/icons/Notification.svg',
            ),
          )
        ],
        title: Image.asset(
          'assets/Logo.png',
          scale: 3.5,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
          size: 32,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
                child: CarouselSlider.builder(
                    itemCount: offers.length,
                    itemBuilder: (context, index, realIndex) => offers[index],
                    options: CarouselOptions(
                        aspectRatio: 2,
                        viewportFraction: 0.8,
                        initialPage: 1,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true))),
          ],
        ),
      ),
    );
  }
}
