# Handling Multiple Screen Sizes

With the increasing amount of devices coming into the market, we're getting to the point in which we're unable to keep up with their resolutions and sizes.

It would result not only cumbersome but impractical to create a version of our UI for each of the multiple platforms Flutter lets you publish your app.

For that, designers and developers have come up with conventions based on user patterns in media consumption from the most popular devices, target audience, etc.

Enter the **breakpoints**!

## What's a Breakpoint?

In responsive design, a breakpoint is the screen size at which a website or app's content and design will adjust in a certain way in order to provide the best possible user experience.

Essentially, breakpoints are pixel values that a developer/designer can define in code. When a responsive app reaches those pixel values, a transformation occurs so that the website offers an optimal user experience for the screen dimensions (in pixels) in which it renders.

Let's represent that in our code.

Find the ```Utils``` class in our code and let's start by adding the most common breakpoints that our app should handle based on the devices in which our users will consume our app, ranging from mobile, tablet, laptop, and desktop, as a set of ```const``` values:

```dart

// Step #1: add the device screen size breakpoints
static const int mobileMaxSize = 480;
static const int tabletMaxSize = 768;
static const int laptopMaxSize = 1024;
static const int desktopMaxSize = 1200;

```

These values are to be used as a guideline, using the maximum size available for the device category that match the screen dimensions, that way we can establish a range between them and be a bit more flexible.

Now let's define an ```enum``` that will map to the corresponding device screen sizes that we're supporting. Place your enum code above the ```Utils``` class if you want.

```dart

// Step #2: Add an enum called "DeviceBreakpoints"
// for the supported device screen sizes; use the following values:

// mobile, tablet, laptop, desktop, tv

```

Now it is time to establish the relationship between the multiple screen sizes supported by our app and the values queried by the ```MediaQuery.of```, available in ```MediaQueryData.size```.

Let's add an additional ```static``` method to our ```Utils``` class, that takes in a ```BuildContext``` reference, through which we'll pull the ```MediaQuery``` reference inherited by the inquiring widget.

Let's call the method ```getDeviceType```, and return the corresponding enum value created earlier:

```dart

// Step #3: add this method to the "Utils" class
static DeviceBreakpoints getDeviceType(BuildContext context) {

    // extract the media query information for this screen
    MediaQueryData data = MediaQuery.of(context);

    // default value is mobile
    DeviceBreakpoints bk = DeviceBreakpoints.mobile;

    // if the data.size.width is greater than "mobileMaxSize"
    // but less than or equal to "tabletMaxSize", then
    // my breakpoint will be "tablet"
    if (data.size.width > Utils.mobileMaxSize 
      && data.size.width <= Utils.tabletMaxSize) {
      bk = DeviceBreakpoints.tablet;
    }

    // TODO: ADD THE ELSE-IF LOGIC FOR LAPTOP,
    // if the width is greater than tabletMaxSize
    // and less than or equal to laptopMaxSize

    // TODO: ADD THE ELSE-IF LOGIC FOR DESKTOP,
    // if the width is greater than laptopMaxSize
    // and less than or equal to desktopMaxSize
    
    // TODO: ADD THE ELSE-IF LOGIC FOR TV
    // if the width is greater than desktopMaxSize

    return bk;
  }

```

Great! Now it's all a matter of consuming this method inside the widget that requires this information. We've already set it up for you, therefore locate a widget called ```DeviceScreenIndicator``` widget, and add the following missing line at the top of the widget's ```build``` method:

```dart

// Step #4: pull the breakpoint enum value
DeviceBreakpoints deviceBreakpoint = Utils.getDeviceType(context);

```

As you notice, we are feeding the **BuildContext** provided to this widget down to the ```Utils.getDeviceType``` method, which internally determines the corresponding device screen size, and returns the corresponding enum for us to do further processing.

Now, using that enum value, extract the value corresponding to it from the ```Utils.deviceTypes``` mapping, which returns a ```DeviceDescription``` object - a model helper class that contains an icon and a label and maps to the matched supported screen type.

```dart

// Step #5: pull the "DeviceDescription" out of the 
// Utils.deviceTypes Map, passing the deviceBreakpoint retrieved above
DeviceDescription? deviceDesc = Utils.deviceTypes[deviceBreakpoint];

// TODO: Use deviceDesc!.icon and deviceDesc.label
// to populate both "icon" and "label" variables
// inside the build method

```

If you want to see the values for the ```icon``` and ```label``` as widgets, then populate the ```Column``` widget on the ```DeviceScreenIndicator``` by adding two widgets: 
- an ```Icon``` widget, with the value of ``icon``, with a color of ```Colors.blueAccent```, and size ```70```
- a ``Text`` widget, with the value of ``label!``, and with its ```style``` property set to a ```const```  ``TextStyle`` object, also color ```Colors.blueAccent``` and a font size of ``20``.
  

```dart

// Step #6: Add the two widgets detailed above:
// an Icon widget and a Text widget

// (OPTIONAL): add a const SizedBox
// with 20px height in between

```

Go ahead now an run this on **DartPad** and if you've replaced all code well, you should see in the **UI Output** panel window to the right that, as you stretch horizontally, you will see an icon and a label at the top left corner, corresponding to each of the breakpoints that the screen falls under as we resize. Very useful!

![Breakpoints](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/s2-1.png)


***Suggestion***: don't go by device-specific screen size breakpoints. Instead of forcing your design into a specific device size, you should let your content flow, for the sake of delivering a great user experience and content consumption by your users.

You should start with the most common device-screen breakpoints (as defined above), but you should always strive for "content-based" breakpoints, where you set a breakpoint at each point where content layout truly meets the expectations of your consumers. This method greatly simplifies the implementation along with easing the management of media queries.