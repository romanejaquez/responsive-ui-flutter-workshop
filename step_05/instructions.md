# Using MediaQueries in a Real-Life Scenario

## FlutterAir

In this step you'll put into practice the concepts mentioned in the previous steps with a simple app called **FlutterAir**  that simulates a online flight reservation experience across multiple devices.

As the user resizes the screen and simulates the multiple screen sizes in which the app is supported, you'll notice a change in layout - it adapts according to the constraints imposed by the screen to deliver the most optimal user experience.

You can apply certain rule-of-thumb guidelines when it comes to achieving good responsiveness in your apps, such as:

## Showing content when there's room for it
You should make sure that when you hide content, you provide an alternative on how to bring it back. 

This is usually reserved for non-critical content that the user doesn't need to have visible all the time, for example an expandable navigation.

When there's room on the screen, the non-critical content can be shown all the time, otherwise it can be hidden, and then shown at the click of a button on a smaller screen.

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/flutterair1.gif)

In the above image, you see how the sidebar widget either expands when there's room, and shrinks until is not visible for smaller screens. Clicking on the hamburger menu exposes those options on a drawer menu.

## Define the styles for your breakpoints

Start by creating a helper class called ```FlutterAirSideBarItemStyles``` that will hold the values for both the icon size and label size at the different breakpoints your app will be supporting. This will allow you, as the application window resizes and the widget rebuilds, to tap into each of the configured styles mapped per breakpoint enum (Step #8 of this workshop will dive deeper on this approach).

Use the following specs when creating the ```FlutterAirSideBarItemStyles``` class:
- add two properties:
  - ```iconSize```, type ```double```
  - ```labelSize```, type ```double```
- add a constructor with named parameters for both properties

```dart
// Step #1: add the bottom class called "FlutterAirSideBarItemStyles";
// this class to hold the style configuration associated
// to a supported breakpoint / screen size.

class FlutterAirSideBarItemStyles {
  final double iconSize;
  final double labelSize;

  FlutterAirSideBarItemStyles({
    required this.iconSize,
    required this.labelSize
  });
}

```

Now go to the ```Utils``` class, and create a ```static``` **Map** called ```sideBarItemStyles```, type ```Map<DeviceType, FlutterAirSideBarItemStyles>```; its entries will hold a key of type ```DeviceType```, one for each of the supported breakpoints, and as their value, an instance of ```FlutterAirSideBarItemStyles```, which will hold the configuration for the icon and label sizes.

```dart

// Step #2: add the sideBarItemStyles map

static Map<DeviceType, FlutterAirSideBarItemStyles> sideBarItemStyles = {
    DeviceType.mobile: FlutterAirSideBarItemStyles(
       iconSize: 30,
       labelSize: 15
    ),
    DeviceType.tablet: FlutterAirSideBarItemStyles(
       iconSize: 30,
       labelSize: 15
    ),
    DeviceType.laptop: FlutterAirSideBarItemStyles(
       iconSize: 25,
       labelSize: 15
    )
};

```

With that in place, proceed to enable a custom widget, called ```FlutterAirSideBar``` created for you, which consumes the styles you created earlier.

```dart

// Step #3 - enable the FlutterAirSideBar widget

```

Add it to the widget structure, all the way up in the ```FlutterAirWelcome``` widget, as the first child of the ```body```'s ```Row``` widget:

```dart

// Step #4: add the enabled FlutterAirSideBar widget
// as a child of the Scaffold's body's Row widget

// ... rest of the code omitted
body: Row(
  children: [
    FlutterAirSideBar(),
    // ... rest of the code remains the same
  ]
)

```


If you run this now through DartPad, you will see the ```FlutterAirSideBar``` in place, however if you stretch it, it still shows all the time.

How do you make it so it only shows the icons when the screen is larger than ```mobile```, but then show both icons and labels when the screen is larger than ```tablet```?

Go back to the top of the structure of the ```FlutterAirSideBar``` widget.

Wrap the ```Material``` widget inside a ```Visibility``` widget, and set its ```visible``` property to ```true``` only if the screen width is larger than ```mobile```, as such:

```dart

// Step #5: Use MediaQuery.of(context).size.width to compare the screen's
// width against your preset mobileMaxWidth value:

// ... rest of the code omitted for brevity:

return Visibility(
    visible: MediaQuery.of(context).size.width > Utils.mobileMaxWidth,
    child: Material(
      // ... rest of the code remains the same
    )
  )
);

```

With the code above, you ensure that this widget's hierarchy is only visible under those conditions (i.e. only when larger than ```mobileMaxWidth```, otherwise it will be hidden for mobile users).

You still haven't taken care of showing the labels if the screen's real estate allows it.

Go down into this widget's hierarchy and locate the ```Padding``` widget that is wrapping the ```Text``` widget representing the sidebar's label. Wrap this widget inside yet another ```Visibility``` widget, and set its ```visible``` property to ```true``` only if the screen's width is larger than a tablet's screen, as such:

```dart

// Step #6: Use MediaQuery.of(context).size.width to compare the screen's
// width against your preset tabletMaxWidth value:

// ... rest of the code omitted for brevity:

Visibility(
  visible: MediaQuery.of(context).size.width > Utils.tabletMaxWidth,
  child: Padding(
    // ... rest of the code remains the same.
  )
)

```

Now take this for a spin by hitting ```Run``` on DartPad and stretching the **UI Output** panel width-wise, so you will see that when it hits the expected breakpoints, the sidebar widget behaves accordingly.

