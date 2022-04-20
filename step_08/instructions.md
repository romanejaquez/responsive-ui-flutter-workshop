# Single Source of Truth for Styling

I'll reintroduce the concept of helper classes that consolidate all style changes needed to be applied at the different supported breakpoints by your application while implementing the following feature depicted in the image below:

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/flutterair2.gif)

Notice how the font size changes as the screen dimensions match the supported breakpoints, and pay specific attention to the side menu widget (i.e. ```Drawer```) that when it is on a larger screen, its background is white and with a bit of content, but when it is on a smaller screen (i.e. mobile) the background changes to purple and more content appears.

This is so that a tailored experience can be achieved depending on the device in which your users are consuming the same application. This also makes styling each breakpoint in a streamlined fashion, avoiding the ill-fated amount of "if-else" clauses polluting the UI.

## Creating a Helper Class

The first thing to do is: determine which are the values in the widget that you want to change and apply programmatically, as opposed to have them hard-coded in the widget or all over the place.

For example, from this widget, you want to change the following properties upon hitting the supported breakpoints:
- ```backgroundColor``` (type ```Color```): you want the background to change depending on the experience you want to give your users between mobile and laptop
- ```labelColor``` (type ```Color```): you want to provide a constrast between the background and the colors of the label
- ```iconBgColor``` (type ```Color```): the icons should match the labels, so you need to have a separate property for them
- ```iconSize``` (type ```double```): the size of the icon should change depending on the screen size
- ```labelSize``` (type ```double```): same with the size of the labels

Then, with that figured out, create a class called ```FlutterAirSideMenuStyles``` that encapsulates all of the properties above. Use the snippet below to kick things off and fill in the rest:

```dart

// Step #1
// TODO: add the custom helper class
// that encapsulates the styles

class FlutterAirSideMenuStyles {
  // TODO: add all properties defined above as final:
  // backgroundColor, labelColor, iconBgColor, iconSize and labelSize

  FlutterAirSideMenuStyles({
    // add all named constructor parameters
    // as required for each of the properties defined above
  });
}

```

Next, go to the ```Utils``` class and create a ```Map``` of type ```<DeviceType, FlutterAirSideMenuStyles>```, and for every device breakpoint, define the corresponding properties for each. Grab the snippet below:


```dart

// TODO: Step #2 - Add the mappings in the Utils class,
// called "sideMenuStyles", per supported breakpoint

static Map<DeviceType, FlutterAirSideMenuStyles> sideMenuStyles = {
    DeviceType.mobile: FlutterAirSideMenuStyles(
      backgroundColor: Utils.secondaryThemeColor,
      labelColor: Colors.white,
      iconSize: 20,
      labelSize: 20,
      iconBgColor: Utils.mainThemeColor
    ),
    DeviceType.tablet: FlutterAirSideMenuStyles(
      backgroundColor: Colors.white,
      labelColor: Utils.darkThemeColor,
      iconSize: 30,
      labelSize: 20,
      iconBgColor: Utils.secondaryThemeColor
    ),
    DeviceType.laptop: FlutterAirSideMenuStyles(
      backgroundColor: Colors.white,
      labelColor: Utils.darkThemeColor,
      iconSize: 30,
      labelSize: 20,
      iconBgColor: Utils.secondaryThemeColor
    )
};

```

In the image below, notice how for screen sizes larger than mobile there's only two menu items available, while for mobile only, all menu items are available. This is the strategy of showing content when space allows but still having an alternative on how to access it.

![SideMenu](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/step8_1.png)

A widget called ```FlutterAirSideMenu``` has been created for you so go ahead and enable it.

```dart

// Step #3: enable the FlutterAirSideMenu widget

```

Now, inside its ```build``` method, start by fetching the side menu styles corresponding to the current app's breakpoint, and store them in a local variable called ```menuStyles```, as in:

```dart

// TODO: Step #4 - add this at the top of the FlutterAirSideMenu's build method

DeviceType deviceBreakpoint = Utils.getDeviceType(context);
FlutterAirSideMenuStyles menuStyles = Utils.sideMenuStyles[deviceBreakpoint] as FlutterAirSideMenuStyles;

```

Proceed to utilize the newly created method ```getMenuItems``` to generate the menu items to display accordingly, starting from the main menu items (```sideBarItems```), which are the same ones on the side bar, but only when the supported breakpoint is ```mobile```, otherwise return an empty list and store that on a local property called ```mainMenuItems```.

```dart

// TODO: Step #5 - next, if the current breakpoint is for 'mobile',
// then get the Utils.sideBarItems as menu items, otherwise
// return an empty list

List<Widget> mainMenuItems = deviceBreakpoint == DeviceType.mobile ? 
    getMenuItems(Utils.sideBarItems, menuStyles) : [];

```

Next, populate the ones that will be default menu items (```sideMenuItems```) - always showing on the side menu bar, then merge them all if applicable, so as to consider them a single list:

```dart

// TODO: Step #6 - populate the default menu items
List<Widget> defaultMenuItems = getMenuItems(Utils.sideMenuItems, menuStyles);
mainMenuItems.addAll(defaultMenuItems);

```


Now, put this newly updated widget in place by going up to the ```FlutterAirWelcome``` page widget and feed it to the ```Scaffold```'s drawer, setting its instance as the ```Drawer```'s ```child``` property:

```dart

// TODO: Step #7 - add the created FlutterAirSideMenu 
// as a child of the Drawer widget;
// don't forget to remove the 'const' from the Drawer widget

```

It's time to take this for a spin by opening up the ```Drawer``` by clicking on the hamburger menu on the top left corner, and stretching the ```UI Output``` panel by the sides.

Notice how the side menu widget changes color for the background, icons and font sizes based on the breakpoint mappings configured, as well as showing and hiding the content appropriately based on the logic for displaying the content.

## Further exploration

You can check out also how I built the ```FlutterAirAppBar``` widget for you, which pretty much follows the same "single-source-of-truth" style approach when styling it, and notice how the app bar changes color as you move from mobile to larger screens.

These are some approaches you can utilize in your own apps in order to bring responsiveness in a clean and efficient way.