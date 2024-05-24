Name: Rana Sameer Waqar

REG NUM#  2021-ag-9376

THE PLACE MARKER APP BY SAM





1. **Import Statements**:

    - `dart:async`: Used for asynchronous programming.

    - `dart:math`: Used for generating random numbers.

    - `package:flutter/material.dart`: Flutter's material design widgets.

    - `package:google_maps_flutter/google_maps_flutter.dart`: Google Maps Flutter package for integrating Google Maps into the app.



2. **HomeScreen Class**:

    - This is a StatefulWidget representing the main screen of the app.

    - It contains a `Completer<GoogleMapController>` to control the Google Map widget.

    - Defines a static `CameraPosition` `_kGooglePlex` which sets the initial camera position of the map.

    - Maintains a set of markers (`_markers`) on the map.

    - Tracks the current index of the marker (`_currentIndex`) and a boolean flag to control message expansion (`_messageExpanded`).



3. Build Method:

    - Constructs a `Scaffold` widget with an `AppBar` displaying the title "Place Marker App".

    - The body of the scaffold is a `Stack` widget containing:

        - A `GoogleMap` widget displaying the map with initial settings.

        - An `AnimatedPositioned` widget for the message box animation.

    - A `FloatingActionButton` is provided for showing the next marker.



4. Methods:

    - `_onMapTap`: Called when the map is tapped. It displays a bottom sheet with a text field to enter a label for the marker. Upon submission, a new marker is added to `_markers` with a random color hue.

    - `_showNextMarker`: Animates the camera to the next marker's position.



5. **Widget Tree**:

    - The widget tree consists of a `Scaffold` containing a `Stack`, which contains the `GoogleMap` widget and the animated message box (`AnimatedPositioned`). Additionally, there's a `FloatingActionButton` for user interaction.



Overall, this code creates an interactive map-based application where users can add markers with custom labels and navigate through them using a floating action button. Additionally, it includes an animated message box for displaying information about the app creator. 