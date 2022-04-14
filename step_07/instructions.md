# Force a Constraint when Needed

Say you still want your user interface to flow seamlessly height-wise and stretch nicely, but what if your users are shrinking their screen and instead of squishing your UI, you want to force a minimum height, then you want a scrollbar to kick in. This way you don't have to necessarily remove content, since the content is critical and must be shown at all times.

You can use a ```ConstrainedBox``` widget in most situations, but in this particular case you want to use a ```Container``` widget, set its height to be the available vertical constraints for the enclosing widget (```constraints.maxHeight```) and set the constraints on the container based on some fixed height you want to impose upon reaching a specific threshold based on the supported screen. Then the scrolling functionality kicks in.

This is what it looks like right now:

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/layoutconstraints_bad.gif)

And this is what you'll accomplish in this section:

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/layoutconstraints_scroll.gif)

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

Next, go to the ```Utils``` class and locate its corresponding mapping called ```flightInfoStyles```, and under each of the supported device breakpoints mapping, set the ```minHeight``` value to 500px for all of them (mobile, tablet, and laptop) - let's start with that value, then you can adjust accordingly.

```dart
// TODO: Step #2 - populate the values in the "flightInfoStyles" mapping
// by setting their "minHeight" values to 500px
```

With that in place, proceed to tackle the widget structure.

The updated flight info styles mapping is already being referenced for you at the top of the ```build``` method of the ```FlutterAirWelcome``` widget, so you're all set there.

This method is currently returning a ```Scaffold``` widget. Inside the ```Scaffold```'s structure, find the ```Padding``` widget currently wrapping the ```FlutterAirFlightInfo``` widget.

Then, proceed to wrap the ```Padding``` widget above inside a ```LayoutBuilder``` widget, and return it out of its ```builder``` method:


```dart

// TODO: Step #3 - wrap the Padding widget enclosing the
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

            // TODO: Step #4 - wrap the returning Padding with a
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

// TODO: Step #5 - wrap the Padding inside a Container
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

And with that, you've solved the issue of content smooshing against each other, and instead a scrollbar shows automatically when applicable so as to display the content while maintaining flexibility and fluidity.
