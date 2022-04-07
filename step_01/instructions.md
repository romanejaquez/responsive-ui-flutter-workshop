# Responsive UIs in Flutter: Creating Fluid User Interfaces

## What is Responsive Design?

Responsive Design is the approach that suggests that design and development should adapt or "respond" to the user's screen size, device orientation, and platform, in the hopes of achieving a fluid user interface that satisfies the needs of users and delivers a seamless experience.

When a Flutter app is ***responsive***, the widgets adjust based on the size of the screen they are presented on, and programmatically change based on a set of rules given to the rendering platform.

Flutter provides a set of widgets and constructs to achieve responsiveness in our apps out of the box, starting from the ```MediaQuery``` widget.

# Using the MediaQuery Widget

The ```MediaQuery``` widget is available for when you wish to query your app's screen size at a high level, and can provide more detailed information about user layout preferences.

If you want to learn the size of the current media (e.g., the window containing your app), you can read the ```MediaQueryData.size``` property from the ```MediaQueryData``` returned by ```MediaQuery.of```.

Querying the current media using ```MediaQuery.of``` will cause your widget to rebuild automatically whenever the ```MediaQueryData``` changes (e.g., if the user rotates their device, or stretches the containing window).

## Extracting MediaQueryData

In the code on the right, locate the ***TODO*** in the ```TestMediaQueryWidget``` custom widget we created, and insert the following:

```dart
// Step #1: Put this code in the build() method
// of the TestMediaQueryWidget

MediaQueryData data = MediaQuery.of(context);

```

This extracts the [```MediaQueryData```](https://api.flutter.dev/flutter/widgets/MediaQueryData-class.html) which contains information about the width and height of the current window, as well as other useful information such as orientation.

Now, feed the ```MediaQueryData``` object into each one our indicator widgets **HorizontalSizeIndicator** and **VerticalSizeIndicator** by populating their ```mediaQueryData``` property:

```dart
// Step #2: populate the mediaQueryData property for our indicator widgets,

// first, to our HorizontalSizeIndicator widget:
HorizontalSizeIndicator(mediaQueryData: data),

// then to our VerticalSizeIndicator widget:
VerticalSizeIndicator(mediaQueryData: data)

```

Now that we're passing the ```MediaQueryData``` into these widgets, let's pull the size information from it.

Go to the ```HorizontalSizeIndicator``` widget, and inside its ```build``` method, pull both the width and height out of the provided ```MediaQueryData``` stored in its ```mediaQueryData``` property, and save them on the local variables ```width``` and ```height``` respectively:

```dart

// Step #3: extract both width and height from the 
// MediaQueryData.size property, and assign them
// to these local variables

var height = 0; // extract the height
var width = 0; // extract the width

```


Do the same on the ```VerticalSizeIndicator``` widget inside its ```build``` method, but this one only requires only the ```height```:

```dart

// Step #4: extract the height on from the 
// MediaQueryData.size property, and assign it
// to this local variable
var height = 0; // extract the height;

```

Go ahead now and hit ```Run``` on DartPad to execute the code, and then resize the **UI Output** window to the right from both sides by dragging from the divider controls, so you can see that, as soon as you resize the containing window, your widget is scheduled to be rebuilt, thus causing the ```MediaQuery.of``` to be queried, retrieving the width and height values of the containing window as it changes dimensions and keeping your widget up-to-date.

You should see a couple of cool widgets representing arrows indicating the measurements of the **UI Output** containing window, and in real-time, as you resize, you should see the values changing. Pretty neat!

![Media Query](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/s1-1.png)