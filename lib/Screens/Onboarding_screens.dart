import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:transigo_app/Models/onboarding_data.dart';
import 'package:transigo_app/main.dart';

class OnboardignScreen extends StatefulWidget {
  const OnboardignScreen({super.key});

  @override
  State<OnboardignScreen> createState() => _OnboardignScreenState();
}

class _OnboardignScreenState extends State<OnboardignScreen> {
// Geting the Data for Pages
  List<DataOnboard> oboardignPages = [
    DataOnboard(
      title: 'Easy creation of shipments with detailed information.',
      description:
          'With our app, you can easily create shipments with detailed information',
      imageUrl: "assets/Onboarding 01.png",
    ),
    DataOnboard(
      title: 'Access to reliable Drivers with transparent pricing',
      description:
          "Choose Your Driver & Get a Fast Shipping for your Package with best drivers in our app",
      imageUrl: "assets/Onboarding 02.png",
    ),
    DataOnboard(
      title: 'Access to reliable Drivers with transparent pricing',
      description:
          "Choose Your Driver & Get a Fast Shipping for your Package with best drivers in our app",
      imageUrl: "assets/Onboarding 03.png",
    ),
    DataOnboard(
      title: '',
      description: "",
      imageUrl: "assets/Onboarding 04.png",
    ),
  ];

  int _currentindex = 0;
  final _controller = PageController(initialPage: 0);

  _onchange(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
            controller: _controller,
            itemCount: oboardignPages.length,
            onPageChanged: _onchange,
            itemBuilder: (BuildContext context, index) {
              return Container(
                color: index == 3
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColorLight,
                child: Column(
                  children: [
/////////////////////the indicator & Skip
                    ////////////////////////
                    ///
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List<Widget>.generate(4, (index) {
                              return AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: 500,
                                ),
                                height: 12,
                                width: index == _currentindex ? 40 : 12,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                    color: index == 3 && index == _currentindex
                                        ? Theme.of(context).primaryColorLight
                                        : index != _currentindex &&
                                                _currentindex == 3
                                            ? Theme.of(context)
                                                .primaryColorLight
                                                .withOpacity(0.5)
                                            : index == _currentindex
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(16)),
                              );
                            }),
                          ),
                          GestureDetector(
                            onTap: index == 3
                                ? () => setState(() {
                                      Navigator.of(context)
                                          .pushReplacementNamed('login');
                                    })
                                : () => setState(() {
                                      _controller.animateToPage(3,
                                          duration:
                                              const Duration(milliseconds: 800),
                                          curve: Curves.ease);
                                    }),
                            child: index == 3
                                ? Row(
                                    children: [
                                      Text(
                                        "Let's Start",
                                        style: TextStyle(
                                            color: index == 3
                                                ? Theme.of(context)
                                                    .primaryColorLight
                                                : Theme.of(context)
                                                    .primaryColor,
                                            fontSize: 20,
                                            fontFamily: 'Poppins',
                                            fontWeight: index == 3
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      )
                                    ],
                                  )
                                : Text(
                                    'Skip',
                                    style: TextStyle(
                                        color: index == 3
                                            ? Theme.of(context)
                                                .primaryColorLight
                                            : Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        fontWeight: index == 3
                                            ? FontWeight.bold
                                            : FontWeight.w400),
                                  ),
                          )
                        ],
                      ),
                    ),
/////////////////////// The Image
                    Expanded(
                      flex: index == 3 ? -1 : 3,
                      child: Image.asset(
                        oboardignPages[index].imageUrl,
                        scale: index == 3 ? 4 : 1,
                      ),
                    ),
/////////////////////// The Content
//////
////

                    ///
                    Expanded(
                      child: index == 3
                          ? Container(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                'assets/delivery_man.png',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              children: [
                                Text(
                                  oboardignPages[index].title!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: 24,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  oboardignPages[index].description!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(0.8),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                    ),

                    /////
/////////////////////// The Prograss
                    ///
                    index != 3
                        ? Expanded(
                            child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _controller.nextPage(
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.easeInOut);
                              });
                            },
                            child: CircularPercentIndicator(
                              animationDuration: 1000,
                              animation: true,
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor:
                                  Theme.of(context).primaryColorLight,
                              radius: 50.0,
                              lineWidth: 5.0,
                              percent: index == 0
                                  ? 0.33
                                  : index == 1
                                      ? 0.55
                                      : 1,
                              center: Container(
                                width: 79,
                                height: 79,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 32,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
                              progressColor: Theme.of(context).primaryColor,
                            ),
                          ))
                        : Container()
                  ],
                ),
              );
            }),
      ),
    );
  }
}
