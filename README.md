# calculatorapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Calculator Implementation Rationale

## Introduction

This document outlines the rationale behind the implementation of a basic calculator application using Flutter and the `math_expressions` package. It describes the design choices, challenges encountered, and strategies employed to overcome them.

## Implementation Rationale

1.  **Flutter for Cross-Platform Development:**
    * Flutter was chosen for its ability to create cross-platform applications with a single codebase. This significantly reduces development time and effort.
    * Flutter's rich set of UI widgets and responsive layout capabilities made it suitable for designing an intuitive calculator interface.

2.  **`math_expressions` Package for Expression Evaluation:**
    * The `math_expressions` package was selected to handle the parsing and evaluation of mathematical expressions.
    * This package provides a robust and reliable way to convert user input strings into executable mathematical operations.
    * Using this package avoids the complex and error prone process of manually parsing the input string.

3.  **State Management with `setState()`:**
    * For this relatively simple calculator application, `setState()` was deemed sufficient for managing the application's state (i.e., the displayed text).
    * This approach is straightforward and avoids the complexity of more advanced state management solutions.

4.  **Grid Layout for Buttons:**
    * A `GridView.builder` widget was used to create the calculator button grid. This provides a flexible and efficient way to arrange the buttons.
    * `GridView` simplifies the layout and ensures consistent button sizing.

5.  **Decimal Point Handling:**
    * The decimal point button implementation was created to prevent multiple decimal points within one number. Also the implementation allows the user to add a decimal point after an operator.

## Challenges and Strategies

1.  **Handling Decimal Points:**
    * **Challenge:** Preventing multiple decimal points within a single number and allowing decimals after operators required careful logic.
    * **Strategy:** The `buttonPressed` function was modified to include checks that prevent multiple decimal points within a number. The logic now checks if the display string already contains a decimal point, and if it does, it prevents adding another. Also, it now checks if the last character is an operator, and if it is, it allows adding a decimal point.
    * Regular expressions were used to accurately determine the last operator, and to check if a number already contains a decimal after a operator.

2.  **Error Handling:**
    * **Challenge:** Invalid mathematical expressions entered by the user could cause the application to crash.
    * **Strategy:** A `try-catch` block was implemented in the `buttonPressed` function to catch any exceptions during expression evaluation. If an error occurs, the display is set to "Error".

3.  **User Experience:**
    * **Challenge:** Ensuring a smooth and intuitive user experience was crucial.
    * **Strategy:** The layout was designed to be clean and uncluttered. Button sizes and spacing were carefully adjusted to optimize usability.

## Conclusion

The calculator application was successfully implemented using Flutter and the `math_expressions` package. The chosen architecture and strategies effectively addressed the challenges encountered, resulting in a functional and user-friendly application.
