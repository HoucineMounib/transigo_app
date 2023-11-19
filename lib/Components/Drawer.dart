import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Widget DrawerTabs(String tabName, String iconUrl, String routeName) {
      return Container(
        margin: EdgeInsets.only(bottom: 40, left: 24),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(routeName),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    iconUrl,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    tabName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: 230,
                height: 1,
                color: Colors.white.withOpacity(0.6),
              ),
            ],
          ),
        ),
      );
    }

////////////The Drawer Returned
    return Drawer(
      backgroundColor: Theme.of(context).primaryColorDark,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context).primaryColorLight),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Account',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColorLight,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              DrawerTabs('Home', 'assets/icons/Home.svg', 'home'),
              DrawerTabs('Tracking', 'assets/icons/Map.svg', 'login'),
              DrawerTabs('English', 'assets/icons/Language.svg', 'home'),
              DrawerTabs('Notification', 'assets/icons/Notification white.svg',
                  'home'),
              DrawerTabs('Setting', 'assets/icons/Setting.svg', 'home'),
              DrawerTabs('Contact Us', 'assets/icons/Phone.svg', 'home'),

              /////Log Out Button////
              ///
              ///////////////////////
              Container(
                margin: EdgeInsets.only(top: 24, left: 24),
                child: GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacementNamed('login');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/Logout.svg',
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Text(
                            'Log Out',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
