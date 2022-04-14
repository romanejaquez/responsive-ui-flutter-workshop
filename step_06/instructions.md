# Switching Layouts

Another rule-of-thumb guideline that you can apply to achieve good responsiveness in your apps is the following:

## Switching layouts / reordering content as best fits the space available

In this section you'll see how you can change the layout of one of the flight information sections from a row when space is limited, to an additional column when there's more room to expand.

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/layoutswitch.gif)


Locate the ```FlutterAirFlightInfo``` widget, and go to the ```return``` statement on its ```build``` method. Currently a ```Column``` widget is being returned, and each of its children is a ```Row``` widget.

Take a look at both ```flightInfoColumn``` which is a ```Column``` widget that contains the ```Row``` widgets representing the rows of information. You'll switch the layout from this - a single column with rows:

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/step6_1.png)

To a two-column layout, where the top row switches to become a column and shifts its contents to the right side of the main column: 

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/step6_2.png)


Wrap this existing widget structure inside a ```LayoutBuilder``` and return it only if the constraints' ```maxWidth``` is smaller than a specified threshold, for which a ```const``` called ```twoColumnLayoutWidth``` was defined in the ```Utils``` class for this purpose:

```dart

// TODO: Step #1: wrap the return Column statement
// inside a LayoutBuilder, after checking that the provided
// constraints are less than the specified threshold:

return LayoutBuilder(
    builder: (context, constraints) {
    
        // TODO: Step #1 (cont.): if constraints.maxWidth is less than our 
        // predefined "twoColumnLayoutWidth" threshold,
        // then return the existing Column widget as usual
    }
);

```

Now return another layout otherwise - when the constraints do not satisfy that condition, i.e. the one when the ```constraints.maxWidth``` is greater than or equals the specified threshold (```Utils.twoColumnLayoutWidth```), as shown below:

```dart

return LayoutBuilder(
    builder: (context, constraints) {
    
        // TODO: Step #1 (cont.) if constraints.maxWidth is less than our 
        // predefined "twoColumnLayoutWidth" threshold,
        // then return the existing Column widget as usual
        
        // otherwise return the bottom structure:
        // TODO: Step #2
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
    }
);

```

This way, as the user stretches the screen, the ```LayoutBuilder``` widget supplies the available constraints, which get evaluated until it satisfies the corresponding condition, then it gets returned by the build method and thus displayed to the user accordingly.

Notice the use of the ```Expanded``` widget here, which allows us to distribute the available space in the parent ```Row``` among both child ```Expanded``` widgets. Notice also the setting of the ```flex``` property to 2 on the top one; this gives sizing priority to it when layout space is being distributed, making it twice the available space as the other one. This is a way to achieve fluidity out of the box in Flutter.

Go ahead now and stretch the **UI Output** panel after hitting ```Run``` on DartPad to see how, as you stretch and shrink the screen and you cross over the threshold established, the layout switches from being a ```Column``` to a ```Row```, and notice the ```Expanded``` widgets in action as the space stretches in a flexible manner, keeping the content flowing on the screen.


Note: aside from the predefined breakpoints for all common device screens established earlier, you can define arbitrary values like the one defined (```Utils.twoColumnLayoutWidth```), which provide your app with intermediate values that make it trigger required changes and cause adjustments in your app to make it flow better. Use your best judgement in these cases.
