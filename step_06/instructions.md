# Switching Layouts

Another rule-of-thumb guideline that you can apply to achieve good responsiveness in your apps is the following:

## Switching layouts / reordering content as best fits the space available

In this section we'll see how you can change the layout of one of the flight information sections from a row when space is limited, to an additional column when there's more room to expand.

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/layoutswitch.gif)

Let's proceed!

Locate the ```FlutterAirFlightInfo``` widget, and go to the ```return``` statement on its ```build``` method. We are currently just returning a ```Column``` widget; each of its children is a ```Row``` widget.

Take a look at both ```flightInfoColumn``` which is a ```Column``` widget that contains the ```Row``` widgets representing the rows of information. We'll switch the layout from this - a single column with rows:

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/step6_1.png)

To a two-column layout, where the top row switches to becoming a column and shifts its contents to the right side of the main column: 

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/step6_2.png)

Let's execute!

We'll wrap this existing widget structure inside a ```LayoutBuilder``` and return it only if the constraints' ```maxWidth``` is smaller than a specified threshold, which we found our sweet spot to be 600px, so let's do just that:

```dart

// TODO: Step #1: wrap the return Column statement
// inside a LayoutBuilder, after checking that the provided
// constraints are less than the specified threshold:

return LayoutBuilder(
    builder: (context, constraints) {
    
        // TODO: if constraints.maxWidth is less than than 600px
        // then return the existing Column widget as usual
    }
});

```

Now return another layout otherwise - when the constraints do not satisfy that condition, i.e. the one when the ```constraints.maxWidth``` are greater than or equals the specified threshold (600 px), as shown below:

```dart

return LayoutBuilder(
    builder: (context, constraints) {
    
    // TODO: if constraints.maxWidth is less than than 600px
    // then return the existing Column widget as usual
    
    // otherwise return the bottom structure:
    // a Row with two (2) columns:
    // left side shows the main flight details
    // and right side shows the flight and seat info only
    return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
            Expanded(
                flex: 2,
                child: flightInfoColumn
            ),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: flightInfoWidgets
                )
            )
        ]
    );
});

```

This way, as the user stretches the screen, the ```LayoutBuilder``` widget supplies the available constraints, which get evaluated until it satisfies the corresponding condition, which then gets returned by the build method and thus displayed to the user accordingly.

Notice we're making use of the ```Expanded``` widget here, which allows us to distribute the available space in the parent ```Row``` among the child ```Expanded``` widgets. Notice we're setting the ```flex``` property to 2 to the top one; this gives sizing priority to this one when layout space is being distributed, making it twice the available space as the other one. This is a way to achieve fluidity out of the box in Flutter.

Go ahead now and stretch the **UI Output** panel after hitting ```Run``` on DartPad to see how, as you stretch and shrink the screen and you cross over the 600px threshold established, the layout switches from being a ```Column``` to a ```Row```, and notice the ```Expanded``` widgets in action as the space stretches in a flexible manner, keeping the content flowing on the screen.
