# Force a Constraint when Needed

Let's say you still want your user interface to flow seamlessly height-wise and stretch nicely, but what if your users are shrinking their screen and instead of squishing your UI, you want to force a minimum height, then a scrollbar kicks in. This way you don't have to necessarily remove content, since the content is critical and must be shown at all times.

You can use a ```ConstrainedBox``` in most situations, but in this particular case you want to use a ```Container``` widget, set its height to be the available vertical constraints for the enclosing widget (```constraints.maxHeight```) and set the constraints on the container based on some fixed height you want to impose upon reaching a specific threshold based on the supported screen. Then the scrolling functionality kicks in.

This is what it looks like right now:

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/layoutconstraints_bad.gif)

And this is what we'll accomplish in this section:

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/layoutconstraints_scroll.gif)

Let's apply this on both the main body and on the navigation on the left.

Locate the ```FlutterAirWelcome``` custom widget, which represents the main welcome screen, which holds both the ```FlutterAirSideBar``` and the ```FlutterAirFlightInfo```.

This is the structure we want to accomplish:

```dart

// we will build the following structure, 
// starting with the Expanded widget below the FlutterAirSideBar:

- Expanded
    - LayoutBuilder
        - SingleChildScrollView
            - Container
                - Padding
                    - FlutterAirFlightInfo

```

Go to the helper class called ```FlutterAirFlightInfoStyles``` which defines all styles defined for the corresponding breakpoint; add an additional property called ```minHeight```, type ```double``` in which we'll store what we consider is the appropriate minimum height under each breakpoint that delivers the optimal viewport until scrolling kicks in. Add a corresponding constructor parameter as well.

```dart
// TODO: add the additional property in the
// "FlutterAirFlightInfoStyles" class, called
// "minHeight", type double?, and add its corresponding
// constructor param as well
```

Next, go to the ```Utils``` class and locate its corresponding mapping called ```flightInfoStyles```, and under each of the supported device breakpoints mapping, set the ```minHeight``` value to 500px for all of them (mobile, tablet, laptop, desktop and tv) - let's start with that value, then you can adjust accordingly.

```dart
// TODO: populate the values in the "flightInfoStyles" mapping
// by setting their "minHeight" values to 500px
```

With that in place, now we're ready to tackle the widget structure.

Start by importing the updated flight info styles mapping at the top of the ```build``` method of the ```FlutterAirWelcome``` widget, as such:

```dart

@override
Widget build(BuildContext context) {

    // TODO: add this at the top of the build method in the 
    // FlutterAirWelcome widget

    FlutterAirFlightInfoStyles? flightInfoStyles = 
        Utils.flightInfoStyles[Utils.getDeviceType(context)];

    // ... rest of the code omitted for brevity
}
    
```


Then, proceed to wrap the existing ```Padding``` widget inside a ```LayoutBuilder``` widget, and return it out of its ```builder``` method:


```dart

// TODO: wrap the Padding widget enclosing the
// FlutterAirFlightInfo widget inside a LayoutBuilder
// so we can extract the constraints 

// ... rest of the code omitted for brevity

Expanded(
    child: LayoutBuilder(
        builder: (context, constraints) {
            // ... rest of the Padding widget stays the same
        }
    )
)

```

The ```LayoutBuilder``` will supply the constraints needed to read what the ```maxHeight``` and ```minHeight``` values are available for this widget.

Continue wrapping the ```Padding``` in yet another widget, a ```SingleChildScrollView``` - this is so that once it hits the optimal viewport height we've designated, the scrolling kicks in; populate the ```controller``` property by feeding a new instance of ```ScrollController``` so its scrolling is independent from any other scrolling entity on this page and doesn't cause any conflicts:

```dart

// TODO: wrap the returning Padding with a
// SingleChildScrollView

// ... rest of the code omitted for brevity

Expanded(
    child: LayoutBuilder(
        builder: (context, constraints) {
            return SingleChildScrollView(
                controller: ScrollController(),
                child: // Padding widget stays the same
            );
        }
    )
)

```

Next, inside the ```SingleChildScrollView```, wrap the ```Padding``` widget containing the ```FlutterAirFlightInfo``` widget in one last widget:  a ```Container``` widget. This is the widget that will adopt the constraints passed down by the ```LayoutBuilder```.

Set the ```Container```'s ```height``` property to be the ```constraints.maxHeight``` to force it to always be the height of the maximum available space; then populate the ```Container```'s ```constraints``` property by creating an instance of ```BoxConstraints``` and populating its ```minHeight``` property with the ```flightInfoStyles.minHeight``` property we added earlier, only if the ```constraints.minHeight``` value is smaller than the preset ```minHeight``` we established earlier. Your ```Container``` structure should look like this:

```dart

// TODO: wrap the Padding inside a Container
// and set its constraints and height accordingly
Container(
    // set the height
    height: constraints.maxHeight,

    // set the constraints using
    // the one supplied by the LayoutBuilder above
    constraints: BoxConstraints(
        minHeight: 
        constraints.minHeight < flightInfoStyles!.minHeight! ? 
            flightInfoStyles.minHeight! : constraints.minHeight
    ),
    
    // this remains the same
    child: Padding(
        padding: const EdgeInsets.all(50),
        child: FlutterAirFlightInfo()
    ),
)
```

## Applying the same strategy to the FlutterAirSideBar widget

If you do the shrinking on the page once again, we've fixed the yellow and black lines indicators on the flight info in the main region of the page; now let's take care of it on the side bar widget. We'll pretty much follow the same approach.

Start by locating the side bar item styles helper class called ```FlutterAirSideBarItemStyles``` and add a new property called ```minHeight```, also ```double```. Add its corresponding constructor parameter to it.

```dart

// TODO: go to the "FlutterAirSideBarItemStyles" class
// and also add an additional property called "minHeight",
// make it type double?; add its named constructor parameter as well

```

Next, go to the ```Utils``` class and locate its corresponding mapping called ```sideBarItemStyles```, and under each of the supported device breakpoints mapping, set the ```minHeight``` value to 200px for all of them (mobile, tablet, laptop, desktop and tv) - let's start with that value, then you can adjust according to what you think the optimal viewport for your sidebar is at any given breakpoint.

```dart

// TODO: go to the Utils.sideBarItemStyles and set
// the "minHeight" property on all mappings to 200px
// as an initial value to start with

```


Now go back to the ```FlutterAirSideBar``` widget - no need to import the ```sidebarItemStyles``` since we're already doing it.

Inside its ```build``` method, locate the ```Column``` widget that is consuming the ```Utils.sideBarItems``` via the ```List.generate``` factory method, and wrap it inside the following structure:

```dart

// Structure inside the FlutterAirSideBar widget:

// TODO: wrap the Column widget inside the following
// structure, as in the FlutterAirWelcome widget
Expanded(
  child: LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            height: constraints.maxHeight,
            constraints: BoxConstraints(
                minHeight: 
                    constraints.minHeight < sideBarItemStyles!.minHeight! ?
                    sideBarItemStyles.minHeight! : constraints.minHeight),
            child: // Column widget remains the same
          )
      );
    }
  )
)
```

It does pretty much the same thing as before: the ```LayoutBuilder``` sets the constraints in which the ```Column``` widget should be rendered, then the ```Container``` widget dictates what the minimum height should be based on an optimal preset value, and lastly the ```SingleChildScrollView``` jumps to the rescue so as not to cut off the content but to provide scrolling capabilities to the ```Container``` widget wrapping our structure.

And with that, you've solved the issue of content smooshing against each other, and instead a scrollbar shows automatically when applicable so as to display the content while maintaining flexibility and fluidity.
