## 2.2.3

- **Added platform implementations**
  - There is a new class called [CoderMatthewsExtensions] which has a new function called [isTablet] which returns a bool whether the current device is a tablet or a regulat phone.

## 1.2.3

- bug fix within [inIgnoreCase]

## 1.2.2

- **BREAKING CHANGE**: renamed [inIgnoreCase] to [containsIgnoreCase]
- added an [inIgnoreCase] and [equalsIgnoreCase] to string extensions

## 1.2.1

- added a few async helpers for mapping list of futures [mapAsync] and for expanding futures [expandAsync]

## 1.2.0

- added a material helper function to get the [RenderBox] of a widget global key

## 1.1.0

- added a new class [ValidationContract] for an exception workflow for validating conditions, null objects and empty/null strings.
- added an extension on object for checking if any object is null.
- **BREAKING CHANGE**: removed [compundAnd] and [compoundOr] from list extensions as dart already has a function like it.

## 1.0.4

- added [toJsonEncodedString] to map extensions and [toDecodedJson] to string entensions for converting to and from json.
- added [addBetween] to list extensions.

## 1.0.3

- **BREAKING CHANGE**: renamed [firstOrNull] to [firstWhereOrNull] for list extensions.

## 1.0.2

- Added [splitCamelCase] funtion to string extensions.
- Added enum extensions.

## 1.0.1

- Added [firstOrNull] function to list extensions.
- Added a [removeNulls] function on map types.

## 1.0.0

- Initial version.
