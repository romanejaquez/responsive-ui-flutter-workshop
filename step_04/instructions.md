# Nested LayoutBuilder Widgets

As we saw in the previous step, the ```LayoutBuilder``` dictates how much space their children have at their disposal. 

And as you may have noticed, the ```MediaQuery``` is great to obtain a high-level view of your app's screen size and available real estate, while ```LayoutBuilder``` is better for widgets further down the tree.

You can implement ```LayoutBuilder``` widgets within other ```LayoutBuilder``` widgets, in which the outer ```LayoutBuilder``` dictates the dimensions of the enclosing ```LayoutBuilder```, which in turn receives updated constraints to pass down its hierarchy and so on. This provides an accurate picture of the available space respective to their enclosing parent widgets.

Go ahead and add yet another ```LayoutBuilder``` inside another custom widget created for you, called ```ChildLayoutBuilderIndicator```, where you'll do exactly the same thing as before.

Replace the existing ```Builder``` widget by a ```LayoutBuilder``` widget, as in the previous step:

```dart

// Step #1 - replace the Builder widget
// by a LayoutBuilder widget, just like in the previous step

```

Next, inside the body of this widget, in the **builder** method, next to the **context**, add the missing **constraints** parameter, as shown below:

```dart

// Step #2: add the missing additional parameter
// next to the "context" parameter, called "constraints"
// like in the previous step

```

And with the **constraints** object provided to the ```LayoutBuilder```'s ```build``` method, extract the ```constraints.maxWidth``` and ```constraints.maxHeight``` values, and store them in the corresponding available local variables ```childMaxWidth``` and ```childMaxHeight``` respectively:

```dart

// Step #3: assign the maxWidth and maxHeight values
// from the constraints and store them in the
// local variables below
var childMaxWidth = 0.0; // assign maxWidth from constraints
var childMaxHeight = 0.0; // assign maxHeight from constraints

```

Make the changes above and go to the **UI Console** panel on the right and hit **Run** on DartPad to see the output. You will see a nested child, as a child of the previous ```LayoutBuilder``` widget, and notice the constraint values of the ```ChildLayoutBuilderWidget``` are relative to the outer ```LayoutWidget``` as opposed to the app's window, since they are relative to its immediate parent.

You should see something like the illustration below. In the next step you'll make use of these values, but in more realistic scenarios to rearrange the layout based on the available space given to widgets by their parents.

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/s4-1.png)