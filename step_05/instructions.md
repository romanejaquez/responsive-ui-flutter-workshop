# Using MediaQueries in a Real-Life Scenario

## FlutterAir

We'll put in practice the concepts we've mentioned in the previous steps with a simple app called **FlutterAir**  that simulates a online flight reservation experience across multiple devices.

As the user resizes the screen and simulates the multiple screen sizes in which the app is supported, you'll notice a change in layout and experience - it adapts according to the constraints imposed by the screen to deliver the most optimal user experience.

You can apply certain rule-of-thumb guidelines when it comes to achieving good responsiveness in your apps, such as:

## Showing content when there's room for it
Make sure that when you hide content, you provide an alternative on how to bring it back. This is usually reserved for non-critical content that the user can do away with not having apparently visible all the time, for example an expandable navigation, that when there's room on the screen we can show all the time, otherwise we can hide it and show it at the click of a button on a smaller screen.

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/flutterair1.gif)

In the above image, you see how the sidebar widget either expands when there's room, and shrinks until is not visible for smaller screens. Clicking on the hamburger menu exposes those options on a drawer menu.

Let's work on this.

## Define the styles for your breakpoints

Let's start by creating a helper class called ```FlutterAirSideBarItemStyles``` that will hold the values for both the icon size and label size at the different breakpoints our app will be supporting. This will allow us, as the application window resizes and the widget rebuilds, to tap into each of the configured styles mapped per breakpoint enum (we'll dive deeper on this on step #8 of this workshop).

Use the following specs when creating the ```FlutterAirSideBarItemStyles``` class:
- add two properties:
  - ```iconSize```, type ```double?```
  - ```labelSize```, type ```double?```
- add a constructor with named parameters for both properties

```dart
// Step #1: create a class called "FlutterAirSideBarItemStyles";
// this class to hold the style configuration associated
// to a supported breakpoint / screen size.
// (See existing class "FlutterAirSideBarItem" for reference)

```

Now let's go to the ```Utils``` class, and create a ```static``` **Map** called **sideBarItemStyles**, type ```Map<DeviceBreakpoints, FlutterAirSideBarItemStyles>```; its entries will hold a key of type ```DeviceBreakpoints```, one for each of the supported breakpoints, and as their value, an instance of ```FlutterAirSideBarItemStyles```, which will hold the configuration for the icon and label sizes.

Build it according to these specs:
- for ```mobile``` and ```tablet```: set the iconSize to **30** and labelSize to **15**
- for ```laptop```: set the iconSize to **25** and labelSize to **15**
- for ```desktop``` and ```tv```: set the iconSize to **25** and labelSize to **20**

```dart

// Step #2: add the sideBarItemStyles map and populate it
// according to the specs above
static Map<DeviceBreakpoints, FlutterAirSideBarItemStyles> sideBarItemStyles = {
    DeviceBreakpoints.mobile: FlutterAirSideBarItemStyles(
       iconSize: 30,
       labelSize: 15
    ),
    // TODO: add mapping for tablet,
    // TODO: add mapping for laptop
    // TODO: add mapping for desktop
    // TODO: add mapping for tv
};

```

With that in place, let's proceed and create our custom widget, which we'll call ```FlutterAirSideBar```.
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

In the steps below, we'll focus only on the ```build``` method of this class.


As the first thing in this ```build``` method, retrieve the ```sideBarItemStyles``` corresponding to the breakpoint enum obtained by the call ```Utils.getDeviceType``` and passing the context, as follows:

```dart

// Step #4: add this inside the build method:

// ... rest of the code omitted for brevity 

DeviceBreakpoints deviceType = Utils.getDeviceType(context);
FlutterAirSideBarItemStyles? sideBarItemStyles = Utils.sideBarItemStyles[deviceType];

```

We'll be  using that styles config class to populate our side bar widget in a minute.

Let's start building the structure on this widget, and start by returning a ```Material``` widget with the following specs:

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

Let's now focus our attention to that ```Column``` widget - the child of the ```Padding``` widget above.
Inside the ```Column```, add three components:
- a ```const``` ```SizedBox``` widget, with 20px in height
- an ```Expanded``` widget wrapping a ```Column``` widget - here we'll place our main content - the icons and labels
- another ```const``` ```Expanded``` widget, wrapping an empty ```SizedBox```; we only want it as a placeholder to compete in space with the top ```Expanded``` widget.

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
    const Expanded(
      child: SizedBox()
    )
  ]
)

```

Let's continue diving right in, now focusing our attention on the nested ```Column``` widget above, inside the first ```Expanded``` widget. Here's where we'll place our icons and labels.


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

We'll use a pre-created list of items to populate the side bar icons and labels from the ```Utils``` class called ```sideBarItems``` - a collection of object instances of type ```FlutterAirSideBarItem```, each of which contains an ```icon``` and a ```label``` property.

Let's populate the ```Column```'s ***children*** property with this ```Utils.sideBarItems``` collection by using a ```List.generate()``` factory method,  which will receive the collection to iterate on, and hook up to a callback that supplies the ```index``` of the iteration, out of which we'll return a ```Row``` widget, since the icon and label will be placed horizontally, and left-aligned, as follows:

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

As part of the ```children``` of the ```Row``` widget, add an ```IconButton``` to which you set its ```icon``` property accordingly, using the ```Utils.sideBarItem``` item in the iteration:

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
    size: sideBarItemStyles!.iconSize // use the configured style
  )
),

```

Now, right under the ```IconButton``` widget, add a ```Text``` widget wrapped inside a ```Padding```, and populate the ```Text``` accordingly, using the ```label``` from the corresponding ```Utils.sideBarItems``` item in the iteration, as follows:


```dart

// Step #9: add a Text widget with some padding
// and populate it with the Utils.sideBarItems.label

Padding(
  padding: const EdgeInsets.only(left: 10, top: 10, right: 20, bottom: 10),
  child: Text(
    Utils.sideBarItems[index].label!, 
    style: TextStyle(
      color: Colors.white,
      fontSize: sideBarItemStyles.labelSize
    )
  ),
)

```

The basic widget is complete. Let's add it to the widget structure, all the way in the ```FlutterAirWelcome``` widget, as the first child of the ```body```'s ```Row``` widget:

```dart

// Step #10: add the newly created FlutterAirSideBar widget
// as a child of the Scaffold's body's Row widget

// ... rest of the code omitted
body: Row(
  children: [
    FlutterAirSideBar(),
    // ... rest of the code remains the same
  ]
)

```


Our structure should be all set. If you run this now through DartPad, you will see the ```FlutterAirSideBar``` in place, however if you stretch it, it shows all the time.

How do we make it so it only shows when the screen is larger than ```mobile``` but only the icons, and show both icons and labels when the screen is larger than ```tablet```?

Let's go back to the top of the structure of the ```FlutterAirSideBar``` widget.

Wrap the ```Material``` widget inside a ```Visibility``` widget, and set its ```visible``` property to ```true``` only if the screen width is larger than ```mobile```, as such:

```dart

// Step #11: Use MediaQuery.of(context).size.width to compare the screen's
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

With the code above, we ensure that this widget's hierarchy is only visible under those conditions (i.e. only when larger than ```mobileMaxSize```, otherwise it will be hidden for mobile users).

We still haven't taken care of showing the labels if the screen's real estate allows it.

Go down into this widget's hierarchy and locate the ```Padding``` widget that is wrapping the ```Text``` widget representing the sidebar's label. Wrap this widget inside yet another ```Visibility``` widget, and set its ```visible``` property to ```true``` only if the screen's width is larger than a tablet's screen, as such:

```dart

// Step #12: Use MediaQuery.of(context).size.width to compare the screen's
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

