import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(FlutterAirApp());
}

class FlutterAirApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.redHatDisplayTextTheme(
          Theme.of(context).textTheme
        )
      ),
      home: FlutterAirWelcome()
    );
  }
}

class FlutterAirWelcome extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Drawer(),
      appBar: FlutterAirAppBar(),
      body: Row(
        children: [
          // TODO: Step #11: add the FlutterAirSideBar widget
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: FlutterAirFlightInfo()
            )
          )
        ]
      )
    );
  }
}

// TODO: Step #3: create a custom widget called FlutterAirSideBar

class FlutterAirFlightInfo extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    FlutterAirFlightInfoStyles? flightInfoStyles = Utils.flightInfoStyles[Utils.getDeviceType(context)];
    
    Column flightInfoColumn = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Origin', style: TextStyle(color: Utils.normalLabelColor, fontSize: flightInfoStyles!.labelSize)),
                  Text('BOS', style: TextStyle(color: Utils.normalLabelColor, fontSize: flightInfoStyles.primaryValueSize))
                ]
              ),
              Expanded(
                child: SizedBox(
                  height: 120,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
                          height: flightInfoStyles.flightLineSize,
                          color: Utils.lightPurpleColor.withOpacity(0.3)
                        )
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: flightInfoStyles.flightLineEndRadiusSize,
                          height: flightInfoStyles.flightLineEndRadiusSize,
                          margin: const EdgeInsets.only(top: 20, left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(flightInfoStyles.flightLineEndRadiusSize!),
                            color: Colors.white,
                            border: Border.all(
                              color: Utils.lightPurpleColor.withOpacity(0.3),
                              width: flightInfoStyles.flightLineSize!
                            )
                          ),
                        )
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: flightInfoStyles.flightLineEndRadiusSize,
                          height: flightInfoStyles.flightLineEndRadiusSize,
                          margin: const EdgeInsets.only(top: 20, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(flightInfoStyles.flightLineEndRadiusSize!),
                            color: Colors.white,
                            border: Border.all(
                              color: Utils.lightPurpleColor.withOpacity(0.3),
                              width: flightInfoStyles.flightLineSize!
                            )
                          ),
                        )
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Transform.rotate(
                          origin: Offset.zero,
                          angle: 1.575,
                          child: Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(bottom: 20, left: 25, top: 20),
                            child: Icon(Icons.flight, color: Utils.mainThemeColor, size: flightInfoStyles.flightIconSize)
                          )
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Destination', style: TextStyle(color: Utils.normalLabelColor, fontSize: flightInfoStyles.labelSize)),
                  Text('STI', style: TextStyle(color: Utils.normalLabelColor, fontSize: flightInfoStyles.primaryValueSize))
                ]
              ),
            ]
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gate', style: TextStyle(color: Utils.normalLabelColor, fontSize: flightInfoStyles.labelSize)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Icon(Icons.door_sliding, color: Utils.secondaryThemeColor, size: flightInfoStyles.secondaryIconSize),
                      const SizedBox(width: 10),
                      Text('G23', style: TextStyle(color: Utils.secondaryThemeColor, fontSize: flightInfoStyles.secondaryValueSize))
                    ],
                  )
                ]
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Baggage Claim', style: TextStyle(color: Utils.normalLabelColor, fontSize: flightInfoStyles.labelSize)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Icon(Icons.work, color: Utils.secondaryThemeColor, size: flightInfoStyles.secondaryIconSize),
                      const SizedBox(width: 10),
                      Text('B5', style: TextStyle(color: Utils.secondaryThemeColor, fontSize: flightInfoStyles.secondaryValueSize))
                    ],
                  )
                ]
              )
            ]
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Departure Time', style: TextStyle(color: Utils.normalLabelColor, fontSize: flightInfoStyles.labelSize)),
                  Text('5:24 AM', style: TextStyle(color: Utils.darkThemeColor, fontSize: flightInfoStyles.tertiaryValueSize))
                ]
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Arrival Time', style: TextStyle(color: Utils.normalLabelColor, fontSize: flightInfoStyles.labelSize)),
                  Text('7:30 AM', style: TextStyle(color: Utils.darkThemeColor, fontSize: flightInfoStyles.tertiaryValueSize))
                ]
              )
            ]
          )
        ]
      );
    
    List<Widget> flightInfoWidgets = [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Flight', style: TextStyle(color: Utils.normalLabelColor, fontSize: flightInfoStyles.labelSize)),
          const Text('785', style: TextStyle(color: Utils.darkThemeColor, fontSize: 30))
        ]
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: flightInfoStyles.seatBadgePaddingSize! / 2, 
              bottom: flightInfoStyles.seatBadgePaddingSize! / 2, 
              left: flightInfoStyles.seatBadgePaddingSize!, 
              right: flightInfoStyles.seatBadgePaddingSize!
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Utils.lightPurpleColor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.airline_seat_recline_normal, color: Colors.white, size: flightInfoStyles.seatBadgeIconSize),
                Text('23A', style: TextStyle(color: Colors.white, fontSize: flightInfoStyles.seatBadgetLabelSize))
              ]
            )
          )
        ]
      )
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: flightInfoWidgets
        ),
        ...flightInfoColumn.children
      ]
    );
  }
}

class FlutterAirAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {

    FlutterAirAppBarStyles? appBarStyles = Utils.appBarStyles[Utils.getDeviceType(context)];
    
    return AppBar(
      backgroundColor: appBarStyles!.backgroundColor,
      elevation: 0,
      title: FlutterAirAppHeaderTitle(),
      leading:  Builder(
        builder: (context) {
          return Material(
            color: appBarStyles.leadingIconBackgroundColor,
            child: InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Icon(Icons.menu, color: appBarStyles.leadingIconForegroundColor)
              )
            )
          );
        } 
      ),
    );
  }
}

class FlutterAirAppHeaderTitle extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    FlutterAirAppBarStyles? appBarStyles = Utils.appBarStyles[Utils.getDeviceType(context)];
    
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Utils.secondaryThemeColor,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Icon(Icons.flight_takeoff, color: appBarStyles!.titleIconColor, size: 20)
        ),
        const SizedBox(width: 10),
        Text('Welcome', style: TextStyle(fontSize: 18, color: appBarStyles.titleColor))
      ]
    );
  }
}

// Utility Classes

enum DeviceBreakpoints {
  mobile,
  tablet,
  laptop,
  desktop,
  tv
}

class Utils {

  static const int mobileMaxSize = 480;
  static const int tabletMaxSize = 768;
  static const int laptopMaxSize = 1024;
  static const int desktopMaxSize = 1200;

  static const Color mainThemeColor = Color(0xFF5C1896);
  static const Color secondaryThemeColor = Color(0xFFA677FF);
  static const Color darkThemeColor = Color(0xFF44146E);
  static const Color normalLabelColor = Color(0xFF6C6C6C);
  static const Color lightPurpleColor = Color(0xFFC5ABF6);

  static Map<DeviceBreakpoints, FlutterAirAppBarStyles> appBarStyles = {
    DeviceBreakpoints.mobile: FlutterAirAppBarStyles(
      leadingIconBackgroundColor: Colors.transparent,
      leadingIconForegroundColor: Utils.mainThemeColor,
      backgroundColor: Colors.transparent,
      titleColor: Utils.mainThemeColor,
      titleIconColor: Colors.white
    ),
    DeviceBreakpoints.tablet: FlutterAirAppBarStyles(
      leadingIconBackgroundColor: Utils.darkThemeColor,
      leadingIconForegroundColor: Colors.white,
      backgroundColor: Utils.mainThemeColor,
      titleColor: Colors.white,
      titleIconColor: Utils.mainThemeColor,
    ),
    DeviceBreakpoints.laptop: FlutterAirAppBarStyles(
      leadingIconBackgroundColor: Utils.darkThemeColor,
      leadingIconForegroundColor: Colors.white,
      backgroundColor: Utils.mainThemeColor,
      titleColor: Colors.white,
      titleIconColor: Utils.mainThemeColor,
    ),
    DeviceBreakpoints.desktop: FlutterAirAppBarStyles(
      leadingIconBackgroundColor: Utils.darkThemeColor,
      leadingIconForegroundColor: Colors.white,
      backgroundColor: Utils.mainThemeColor,
      titleColor: Colors.white,
      titleIconColor: Utils.mainThemeColor,
    ),
    DeviceBreakpoints.tv: FlutterAirAppBarStyles(
      leadingIconBackgroundColor: Utils.darkThemeColor,
      leadingIconForegroundColor: Colors.white,
      backgroundColor: Utils.mainThemeColor,
      titleColor: Colors.white,
      titleIconColor: Utils.mainThemeColor,
    ),
  };

  static Map<DeviceBreakpoints, FlutterAirFlightInfoStyles> flightInfoStyles = {
    DeviceBreakpoints.mobile: FlutterAirFlightInfoStyles(
      labelSize: 15,
      primaryValueSize: 60,
      secondaryValueSize: 40,
      tertiaryValueSize: 30,
      flightIconSize: 50,
      seatBadgePaddingSize: 15,
      seatBadgeIconSize: 25,
      seatBadgetLabelSize: 25,
      flightLineSize: 3,
      flightLineEndRadiusSize: 10,
      secondaryIconSize: 30
    ),
    DeviceBreakpoints.tablet: FlutterAirFlightInfoStyles(
      labelSize: 20,
      primaryValueSize: 60,
      secondaryValueSize: 50,
      tertiaryValueSize: 30,
      flightIconSize: 60,
      seatBadgePaddingSize: 20,
      seatBadgeIconSize: 30,
      seatBadgetLabelSize: 30,
      flightLineSize: 4,
      flightLineEndRadiusSize: 15,
      secondaryIconSize: 30
    ),
    DeviceBreakpoints.laptop: FlutterAirFlightInfoStyles(
      labelSize: 20,
      primaryValueSize: 70,
      secondaryValueSize: 60,
      tertiaryValueSize: 40,
      flightIconSize: 60,
      seatBadgePaddingSize: 30,
      seatBadgeIconSize: 35,
      seatBadgetLabelSize: 35,
      flightLineSize: 4,
      flightLineEndRadiusSize: 15,
      secondaryIconSize: 30
    ),
    DeviceBreakpoints.desktop: FlutterAirFlightInfoStyles(
      labelSize: 25,
      primaryValueSize: 100,
      secondaryValueSize: 70,
      tertiaryValueSize: 50,
      flightIconSize: 70,
      seatBadgePaddingSize: 30,
      seatBadgeIconSize: 35,
      seatBadgetLabelSize: 35,
      flightLineSize: 4,
      flightLineEndRadiusSize: 20,
      secondaryIconSize: 50
    ),
    DeviceBreakpoints.tv: FlutterAirFlightInfoStyles(
      labelSize: 25,
      primaryValueSize: 100,
      secondaryValueSize: 70,
      tertiaryValueSize: 50,
      flightIconSize: 70,
      seatBadgePaddingSize: 30,
      seatBadgeIconSize: 35,
      seatBadgetLabelSize: 35,
      flightLineSize: 4,
      flightLineEndRadiusSize: 20,
      secondaryIconSize: 50
    ),
  };

  static DeviceBreakpoints getDeviceType(BuildContext context) {

    MediaQueryData data = MediaQuery.of(context);
    DeviceBreakpoints bk = DeviceBreakpoints.mobile;

    if (data.size.width > Utils.mobileMaxSize 
      && data.size.width <= Utils.tabletMaxSize) {
      bk = DeviceBreakpoints.tablet;
    }

    else if (data.size.width > Utils.tabletMaxSize 
      && data.size.width <= Utils.laptopMaxSize) {
      bk = DeviceBreakpoints.laptop;
    }

    else if (data.size.width > Utils.laptopMaxSize &&
            data.size.width <= Utils.desktopMaxSize) {
      bk = DeviceBreakpoints.desktop;
    }
    
    else if (data.size.width > Utils.desktopMaxSize) {
      bk = DeviceBreakpoints.tv;
    }

    return bk;
  }

  static List<FlutterAirSideBarItem> sideBarItems = [
    FlutterAirSideBarItem(
      icon: Icons.home,
      label: 'Home'
    ),
    FlutterAirSideBarItem(
      icon: Icons.face,
      label: 'Passengers'
    ),
    FlutterAirSideBarItem(
      icon: Icons.airplane_ticket,
      label: 'Flight Info'
    ),
    FlutterAirSideBarItem(
      icon: Icons.airline_seat_recline_normal,
      label: 'Reserve Seat'
    )
  ];

  static List<FlutterAirSideBarItem> sideMenuItems = [
    FlutterAirSideBarItem(
      icon: Icons.settings,
      label: 'Settings'
    ),
    FlutterAirSideBarItem(
      icon: Icons.qr_code,
      label: 'Boarding Pass'
    )
  ];

  // TODO: Step #2: add the sideBarItemStyles Map
}

class FlutterAirAppBarStyles {
  Color? leadingIconBackgroundColor;
  Color? leadingIconForegroundColor;
  Color? backgroundColor;
  Color? titleColor;
  Color? titleIconColor;

  FlutterAirAppBarStyles({
    this.leadingIconBackgroundColor,
    this.leadingIconForegroundColor,
    this.backgroundColor,
    this.titleColor,
    this.titleIconColor
  });
}

class FlutterAirFlightInfoStyles {
  double? labelSize;
  double? primaryValueSize;
  double? secondaryValueSize;
  double? tertiaryValueSize;
  double? flightIconSize;
  double? seatBadgePaddingSize;
  double? seatBadgeIconSize;
  double? seatBadgetLabelSize;
  double? flightLineSize;
  double? flightLineEndRadiusSize;
  double? secondaryIconSize;

  FlutterAirFlightInfoStyles({
    this.labelSize,
    this.primaryValueSize,
    this.secondaryValueSize,
    this.tertiaryValueSize,
    this.flightIconSize,
    this.seatBadgeIconSize,
    this.seatBadgePaddingSize,
    this.seatBadgetLabelSize,
    this.flightLineSize,
    this.flightLineEndRadiusSize,
    this.secondaryIconSize
  });
}

// TODO: Step #1: Add a class called FlutterAirSidebarItemStyles

class FlutterAirSideBarItem {
  IconData? icon;
  String? label;

  FlutterAirSideBarItem({ this.icon, this.label });
}
