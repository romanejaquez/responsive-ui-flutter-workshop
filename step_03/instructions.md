# Using the LayoutBuilder Widget

Sometimes users may not be concerned with the dimensions of the app's screen, but rather how much space a parent widget has devoted to its child widgets for them to render appropriately. For this case, there's a special widget called ```LayoutBuilder```.

The [```LayoutBuilder```](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html) widget is a simpler ```MediaQuery``` widget for basic size requests, but the best thing about it is that it tells the underlying widget tree how much space it has available.

It is similar to the ```Builder``` widget, except that the framework calls the ```builder``` function at layout time and provides the parent widget's constraints.

Its ```builder``` function is fed both the ```BuildContext``` and a ```BoxConstraints``` instance, from which you can pull the **maxWidth** and **maxHeight**, which after the parent builds, it passes these values to a child for them to know the available dimensions in which they can render.

Let's put it in practice.

First, find a custom widget we created for you called ```LayoutBuilderIndicator```, which should display the space dimensions available to it, then pass it down to its child widgets.

Replace the existing ```Builder``` widget by a ```LayoutBuilder``` widget:

```dart

// Step #1 - replace the existing Builder
// by LayoutBuilder widget, as shown below:
child: LayoutBuilder(
    // ... rest of the code
)

```

Next, inside the body of this widget, in its ```builder``` method, next to the ```context``` parameter, add an additional parameter available to the ```LayoutBuilder``` - the ```constraints``` parameter (an instance of ```BoxConstraints```), as shown below:

```dart

// Step #2: add the missing additional parameter
// so make it look like this:
builder: (context, constraints) {
    // ... rest of the code
}

```

And now that we have the **constraints** object fed to the builder from the ```LayoutBuilder```, let's extract the ```constraints.maxWidth``` and ```constraints.maxHeight``` values, and store them in the corresponding available local variables ```maxWidth``` and ```maxHeight``` respectively:

```dart

// Step #3: assign the maxWidth and maxHeight values
// from the constraints to these local variables

var maxWidth = 0.0; // assign maxWidth from constraints
var maxHeight = 0.0; // assign maxHeight from constraints

```

After all changes above are made, go to the **UI Console** panel on the right and hit **Run** on DartPad to see the output. You will see an inner child widget panel in purple showing the maximum width and height available to it for its future child widgets to render accordingly.

Go ahead and stretch the panel by dragging both from above and the sides to see the values changing. Instead of the values being relative to the outer edges of the window, the ```LayoutBuilder``` exposes the values relative to the parent's position and dimensions, or the parent's constraints (the ```Positioned``` widget).

You will see something like the bottom image, which gives a very useful illustration of the constrast between the values that the ```MediaQuery``` generates versus the values a ```LayoutBuilder``` widget produces.

![LayoutBuilder](https://romanejaquez.github.io/responsive-ui-flutter-workshop/images/s3-1.png)