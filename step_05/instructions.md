# Using MediaQueries in a Real-Life Scenario

## FlutterAir

In this step you'll put into practice the concepts mentioned in the previous steps with a simple app called **FlutterAir**  that simulates a online flight reservation experience across multiple devices.

As the user resizes the screen and simulates the multiple screen sizes in which the app is supported, you'll notice a change in layout - it adapts according to the constraints imposed by the screen to deliver the most optimal user experience.

You can apply certain rule-of-thumb guidelines when it comes to achieving good responsiveness in your apps, such as:

## Showing content when there's room for it
You should make sure that when you hide content, you provide an alternative on how to bring it back. This is usually reserved for non-critical content that the user doesn't need to have visible all the time, for example an expandable navigation, that when there's room on the screen we can show all the time, otherwise we can hide it and show it at the click of a button on a smaller screen.

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

Now go to the ```Utils``` class, and create a ```static``` **Map** called ```sideBarItemStyles```, type ```Map<DeviceBreakpoints, FlutterAirSideBarItemStyles>```; its entries will hold a key of type ```DeviceBreakpoints```, one for each of the supported breakpoints, and as their value, an instance of ```FlutterAirSideBarItemStyles```, which will hold the configuration for the icon and label sizes.

```dart

// Step #2: add the sideBarItemStyles map

static Map<DeviceBreakpoints, FlutterAirSideBarItemStyles> sideBarItemStyles = {
    DeviceBreakpoints.mobile: FlutterAirSideBarItemStyles(
       iconSize: 30,
       labelSize: 15
    ),
    DeviceBreakpoints.mobile: FlutterAirSideBarItemStyles(
       iconSize: 30,
       labelSize: 15
    ),
    DeviceBreakpoints.tablet: FlutterAirSideBarItemStyles(
       iconSize: 30,
       labelSize: 15
    ),
    DeviceBreakpoints.laptop: FlutterAirSideBarItemStyles(
       iconSize: 25,
       labelSize: 15
    ),
    DeviceBreakpoints.desktop: FlutterAirSideBarItemStyles(
       iconSize: 25,
       labelSize: 20
    )
};

```

With that in place, proceed and create a custom widget, called ```FlutterAirSideBar```.
Create the corresponding class for it and make it extend ```StatelessWidget```. You can use the following snippet to start you off:

```dart

// Step #3: custom widget class for the side bar
class FlutterAirSideBar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
      // ... rest of the code will go here
  }
}

```

In the steps below, you'll focus only on the ```build``` method of this class.


As the first thing in this ```build``` method, retrieve the ```sideBarItemStyles``` corresponding to the breakpoint enum obtained by the call ```Utils.getDeviceType``` and passing the context, as follows:

```dart

// Step #4: add this inside the build method:

// ... rest of the code omitted for brevity 

DeviceBreakpoints deviceType = Utils.getDeviceType(context);

FlutterAirSideBarItemStyles sideBarItemStyles =
    Utils.sideBarItemStyles[deviceType] as FlutterAirSideBarItemStyles;

```

You'll be using that styles config helper class to populate your side bar widget in a minute.

Start building the structure on this widget by returning a ```Material``` widget with the following specs:

- color: set to ```Utils.secondaryThemeColor```
- child: a ```Padding``` widget with 8px of padding all around. Add a ```Column``` as its immediate child with an empty ```children``` property.

Your widget structure should start looking like this:

```dart

// Step #5: return a Material widget with the following specs

// ... rest of the code omitted for brevity

return Material(
    color: Utils.secondaryThemeColor,
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // ... rest of the code here
        ]
      )
    )
);

```

Now focus your attention to that ```Column``` widget - the child of the ```Padding``` widget above.
Inside the ```Column```, add three components:
- a ```const``` ```SizedBox``` widget, with 20px in height
- an ```Expanded``` widget wrapping a ```Column``` widget - here we'll place our main content - the icons and labels
- a ```const``` ```Spacer``` widget, which acts as a placeholder to compete in space with the top ```Expanded``` widget.

Your structure inside the ```Column``` should look like this:

```dart

// Step #6: add 3 components inside the Column, as follows:

// ... rest of the code omitted for brevity

Column(
  children: [
    const SizedBox(height: 20),
    Expanded(
      child: Column(
        children: [
          // ... icons and labels will go here
        ]
      )
    ),
    const Spacer()
  ]
)

```

Continue diving right in, now focusing on the nested ```Column``` widget above, inside the first ```Expanded``` widget, where the icons and labels will go.


Ensure that the items in this ```Column``` are left-aligned, and spaced-out with spaces between them:

```dart

// Step #7: add maxAxisAlignment of spaceBetween
// and crossAxisAlignment of start 

// ... rest of the code omitted for brevity
Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // ... generate icons here
  ]
)

```

A pre-created list of items will be used to populate the side bar icons and labels from the ```Utils``` class called ```sideBarItems``` - a collection of object instances of type ```FlutterAirSideBarItem```, each of which contains an ```icon``` and a ```label``` property.

Populate the ```Column```'s ***children*** property with this ```Utils.sideBarItems``` collection by using a ```List.generate()``` factory method,  which will receive the collection to iterate on, and hook up to a callback that supplies the ```index``` of the iteration, out of which we'll return a ```Row``` widget, since the icon and label will be placed horizontally, and left-aligned, as follows:

```dart

// ... rest of the code omitted for brevity
Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.start,

  // Step #8: populate the children property using the Utils.sideBarItems
  // and a List.generate() factory method

  children: List.generate(Utils.sideBarItems.length, (index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // ... icons and labels here
        ]
      );
    }
  )
)

```

As part of the ```children``` of the ```Row``` widget, add an ```IconButton``` to which you set its ```icon``` property accordingly, extracting the ```Utils.sideBarItem``` item using the corresponding index in the iteration:

```dart

// Step #9: add the following code inside the Row widget,
// as the first child...

IconButton(
  color: Utils.secondaryThemeColor,
  splashColor: Utils.mainThemeColor.withOpacity(0.2),
  highlightColor: Utils.mainThemeColor.withOpacity(0.2),
  onPressed: () {},
  icon: Icon(
    Utils.sideBarItems[index].icon, // populate the icon
    color: Colors.white,
    size: sideBarItemStyles.iconSize // use the configured style
  )
),

```

Now, right under the ```IconButton``` widget, add a ```Text``` widget wrapped inside a ```Padding```, and populate the ```Text``` accordingly, using the ```label``` from the corresponding ```Utils.sideBarItems``` item in the iteration, as follows:


```dart

// Step #10: add a Text widget with some padding
// and populate it with the Utils.sideBarItems.label

Padding(
  padding: const EdgeInsets.only(left: 10, top: 10, right: 20, bottom: 10),
  child: Text(
    Utils.sideBarItems[index].label, 
    style: TextStyle(
      color: Colors.white,
      fontSize: sideBarItemStyles.labelSize
    )
  ),
)

```

The basic widget is complete. Let's add it to the widget structure, all the way up in the ```FlutterAirWelcome``` widget, as the first child of the ```body```'s ```Row``` widget:

```dart

// Step #11: add the newly created FlutterAirSideBar widget
// as a child of the Scaffold's body's Row widget

// ... rest of the code omitted
body: Row(
  children: [
    FlutterAirSideBar(),
    // ... rest of the code remains the same
  ]
)

```


The structure should be all set. If you run this now through DartPad, you will see the ```FlutterAirSideBar``` in place, however if you stretch it, it still shows all the time.

How do you make it so it only shows the icons when the screen is larger than ```mobile```, but then show both icons and labels when the screen is larger than ```tablet```?

Go back to the top of the structure of the ```FlutterAirSideBar``` widget.

Wrap the ```Material``` widget inside a ```Visibility``` widget, and set its ```visible``` property to ```true``` only if the screen width is larger than ```mobile```, as such:

```dart

// Step #12: Use MediaQuery.of(context).size.width to compare the screen's
// width against our preset mobileMaxSize value:

// ... rest of the code omitted for brevity:

return Visibility(
    visible: MediaQuery.of(context).size.width > Utils.mobileMaxSize,
    child: Material(
      // ... rest of the code remains the same
    )
  )
);

```

With the code above, you ensure that this widget's hierarchy is only visible under those conditions (i.e. only when larger than ```mobileMaxSize```, otherwise it will be hidden for mobile users).

You still haven't taken care of showing the labels if the screen's real estate allows it.

Go down into this widget's hierarchy and locate the ```Padding``` widget that is wrapping the ```Text``` widget representing the sidebar's label. Wrap this widget inside yet another ```Visibility``` widget, and set its ```visible``` property to ```true``` only if the screen's width is larger than a tablet's screen, as such:

```dart

// Step #13: Use MediaQuery.of(context).size.width to compare the screen's
// width against our preset tabletMaxSize value:

// ... rest of the code omitted for brevity:

Visibility(
  visible: MediaQuery.of(context).size.width > Utils.tabletMaxSize,
  child: Padding(
    // ... rest of the code remains the same.
  )
)

```

Now take this for a spin by hitting ```Run``` on DartPad and stretching the **UI Output** panel width-wise, so you will see that when it hits the expected breakpoints, the sidebar widget behaves accordingly.

