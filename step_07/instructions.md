# Force a Constraint when Needed

Say you still want your user interface to flow seamlessly height-wise and stretch nicely, but what if your users are shrinking their screen and instead of squishing your UI, you want to force a minimum height, then you want a scrollbar to kick in. This way you don't have to necessarily remove content, since the content is critical and must be shown at all times.

You can use a ```ConstrainedBox``` widget in most situations, but in this particular case you want to use a ```Container``` widget, set its height to be the available vertical constraints for the enclosing widget (```constraints.maxHeight```) and set the constraints on the container based on some fixed height you want to impose upon reaching a specific threshold based on the supported screen. Then the scrolling functionality kicks in.

This is what it looks like right now:

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/layoutconstraints_bad.gif)

And this is what you'll accomplish in this section:

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/layoutconstraints_scroll.gif)

You will apply this on both the main body and on the navigation on the left.

Locate the ```FlutterAirWelcome``` custom widget, which represents the main welcome screen, which holds both the ```FlutterAirSideBar``` and the ```FlutterAirFlightInfo```.

This is the structure you want to accomplish:

```dart

// you will build the following structure, 
// starting with the Expanded widget below the FlutterAirSideBar:

- Expanded
    - LayoutBuilder
        - SingleChildScrollView
            - Container
                - Padding
                    - FlutterAirFlightInfo

```

Go to the helper class called ```FlutterAirFlightInfoStyles``` which defines all styles defined for the corresponding breakpoint; add an additional property called ```minHeight```, type ```double``` in which you'll store what is considered the appropriate minimum height under each breakpoint that delivers the optimal viewport until scrolling kicks in. Add a corresponding constructor parameter as well.

```dart
// TODO: Step #1 - add the additional final property in the
// "FlutterAirFlightInfoStyles" class, called
// "minHeight", type double, and add its corresponding
// constructor param as well (required)
```

Next, go to the ```Utils``` class and locate its corresponding mapping called ```flightInfoStyles```, and under each of the supported device breakpoints mapping, set the ```minHeight``` value to 500px for all of them (mobile, tablet, laptop, and desktop) - let's start with that value, then you can adjust accordingly.

```dart
// TODO: Step #2 - populate the values in the "flightInfoStyles" mapping
// by setting their "minHeight" values to 500px
```

With that in place, proceed to tackle the widget structure.

Start by importing the updated flight info styles mapping at the top of the ```build``` method of the ```FlutterAirWelcome``` widget, as such:

```dart

@override
Widget build(BuildContext context) {

    // TODO: Step #3 - add this at the top of the build method in the 
    // FlutterAirWelcome widget

    FlutterAirFlightInfoStyles flightInfoStyles = 
        Utils.flightInfoStyles[Utils.getDeviceType(context)] as FlutterAirFlightInfoStyles;

    // ... rest of the code omitted for brevity
}
    
```

This method is currently returning a ```Scaffold``` widget. Inside the ```Scaffold```'s structure, find the ```Padding``` widget currently wrapping the ```FlutterAirFlightInfo``` widget.

Then, proceed to wrap the ```Padding``` widget above inside a ```LayoutBuilder``` widget, and return it out of its ```builder``` method:


```dart

// TODO: Step #4 - wrap the Padding widget enclosing the
// FlutterAirFlightInfo widget inside a LayoutBuilder
// so the constraints can be extracted

// ... rest of the code omitted for brevity

Expanded(
    child: LayoutBuilder(
        builder: (context, constraints) {
            // ... rest of the Padding widget stays the same
        }
    )
)

```

The ```LayoutBuilder``` will supply the constraints to get the ```maxHeight``` and ```minHeight``` values available for this widget.

Continue wrapping the ```Padding``` in yet another widget, a ```SingleChildScrollView``` - this is so that once it hits the optimal viewport height designated, the scrolling kicks in; populate the ```controller``` property by feeding a new instance of ```ScrollController``` so its scrolling is independent from any other scrolling entity on this page and doesn't cause any conflicts:

```dart

// ... rest of the code omitted for brevity

Expanded(
    child: LayoutBuilder(
        builder: (context, constraints) {

            // TODO: Step #5 - wrap the returning Padding with a
            // SingleChildScrollView
            return SingleChildScrollView(
                controller: ScrollController(),
                child: // Padding widget stays the same
            );
        }
    )
)

```

Next, inside the ```SingleChildScrollView```, wrap the ```Padding``` widget containing the ```FlutterAirFlightInfo``` widget in one last widget:  a ```Container``` widget. This is the widget that will adopt the constraints passed down by the ```LayoutBuilder```.

Set the ```Container```'s ```height``` property to be the ```constraints.maxHeight``` to force it to always be the height of the maximum available space; then populate the ```Container```'s ```constraints``` property by creating an instance of ```BoxConstraints``` and populating its ```minHeight``` property with the ```flightInfoStyles.minHeight``` property added earlier, but only if the ```constraints.minHeight``` value is smaller than the preset ```minHeight``` established earlier. Your ```Container``` structure should look like this:

```dart

// ... rest of the code omitted for brevity

// TODO: Step #6 - wrap the Padding inside a Container
// and set its constraints and height accordingly
Container(
    // set the height
    height: constraints.maxHeight,

    // set the constraints using
    // the one supplied by the LayoutBuilder above
    constraints: BoxConstraints(
        minHeight: 
        constraints.minHeight < flightInfoStyles.minHeight ? 
            flightInfoStyles.minHeight : constraints.minHeight
    ),
    
    child: // Padding widget stays the same,
)
```

## Applying the same strategy to the FlutterAirSideBar widget

If you do the shrinking on the page once again, the yellow and black line error indicators have been fixed on the flight info in the main region of the page; now it's time to take care of it on the side bar widget, following pretty much the same approach.

Start by locating the side bar item styles helper class called ```FlutterAirSideBarItemStyles``` and add a new property called ```minHeight```, also type ```double```. Add its corresponding named constructor parameter to it.

```dart

// TODO: Step #7 - go to the "FlutterAirSideBarItemStyles" class
// and also add an additional property called "minHeight",
// make it type double; add its named constructor parameter as well

```

Next, go to the ```Utils``` class and locate its corresponding mapping called ```sideBarItemStyles```, and under each of the supported device breakpoints mapping, set the ```minHeight``` value to 200px for all of them (mobile, tablet, laptop, and desktop) - let's start with that value, then you can adjust according to what you think the optimal viewport for your sidebar is at any given breakpoint.

```dart

// TODO: Step #8 - go to the Utils.sideBarItemStyles and set
// the "minHeight" property on all mappings to 200px
// as an initial value to start with

```


Now go back to the ```FlutterAirSideBar``` widget - no need to import the ```sidebarItemStyles``` here since it's being done already.

Inside its ```build``` method, locate the ```Column``` widget that is consuming the ```Utils.sideBarItems``` via the ```List.generate``` factory method, and wrap it inside the following structure:

```dart

// Structure inside the FlutterAirSideBar widget:

// TODO: Step #9 - wrap the Column widget inside the following
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
                    constraints.minHeight < sideBarItemStyles.minHeight ?
                    sideBarItemStyles.minHeight : constraints.minHeight),
            child: // Column widget remains the same
          )
      );
    }
  )
)

```

It does pretty much the same thing as before: the ```LayoutBuilder``` sets the constraints in which the ```Column``` widget should be rendered, then the ```Container``` widget dictates what the minimum height should be based on an optimal preset value, and lastly the ```SingleChildScrollView``` jumps to the rescue so as not to cut off the content but to provide scrolling capabilities to the ```Container``` widget wrapping the structure.

And with that, you've solved the issue of content smooshing against each other, and instead a scrollbar shows automatically when applicable so as to display the content while maintaining flexibility and fluidity.
