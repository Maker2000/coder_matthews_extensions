## 1.12.3

- Fixed null issue when trying to get render box.

## 1.12.2

- Updated android gradle version.

## 1.12.1

- Updated dependencies.

## 1.12.0

- Added a new widget for switching the theme mode. It uses radio buttons

## 1.11.3

- added a modification to the add or update function. There is a new [modifyElementIfFound] function property.

## 1.11.2

- added [toListNotNull] and [toListEmptyWhenNull] to object extensions.

## 1.11.1

- made a change to [ErrorData] onject to allow for a list of additional actions.
- **BREAKING CHANGE**:
  - [ErrorData] interface now only accepts a list of error actions.
  - [AppException] not only accepts a list of [ErrorActions]
  - validation contracts now accept an optional list of [ErrorActions]

## 1.11.0

- add a new set of extensions for files. Includes the following functions: (check the in code documentation for their uses)

  - [sizeInGb]
  - [sizeInMb]
  - [sizeInKb]
  - [sizeInBytes]
  - [fileSizeDescription]

- added [isNotNullOrEmptyWhiteSpace] and [isNullOrEmptyWhiteSpace] to string extensions.

## 1.10.3

- added [addOrUpdate] function to list extensions.

## 1.10.2

- slight bug fix with custom http client create functions.

## 1.10.1

- slight change to how base headers are accepted for the [CoderHttpClient]. It now takes a [FutureOr] rather than a [Future]
- added three new functions to StringExtensions and EnumExtensions
  - [camelCaseToPascalCase]
  - [camelCaseToSnakeCase]
  - [pascalCaseToCamelCase]

## 1.10.0

- added new widget [Unfocus] which can help to unfocus text input fields when the user taps outside the input field.
- add a new extention category [ColorExtenstions]. Comes with the following functions; check the in code documentation for the function:

  - [withHue]
  - [withSaturation]
  - [withValue]

## 1.9.7

- [IsNotNullOrEmpty] bug fix

## 1.9.6

- Build error fix

## 1.9.5

- Updated packages

## 1.9.4

- added bug fixes to the [JsonHelper]:

## 1.9.3

- added bug fixes to the [JsonHelper]:

## 1.9.2

- added bug fixes to the [JsonHelper]

## 1.9.1

- added another two functions to the [JsonHelper]:
  - [encodeWithType]
  - [decodeWithType]
- cleaned up function documentation.

## 1.9.0

- added a new helper, the [JsonHelper] that makes it easier to make more generic json encoding and decoding.

## 1.8.7

- bug fixes: unable to extend [ControllerException]
- **BREAKING CHANGE** remove [CoderMatthewsExtensions.isTablet] function, moved to [TabletExtensions.isTablet]
- added [fileExtension] and [actualFileExtension] to string extensions
- updated packages

## 1.8.6

- bug fixes relating to [GlobalErrorHandler]
- added a few string exceptions: [remove] which removes characters from a string

## 1.8.5

- bug fixes

## 1.8.4

- made assepted [ErrorData] more generic (T extends ErrorData)
- bug fixes

## 1.8.3

- added exception object as a parameter to [IAppErrorHandler]

## 1.8.2

- **BREAKING CHANGES**:
  - [maxElement], [maxDate], [maxValue] have been replaced with [max] which supports the comparable data type
  - [minElement], [minDate], [minValue] have been replaced with [min] which supports the comparable data type
- minor change to the [inIgnoreCase], [containsIgnoreCase] and [equalsIgnoreCase] functions. Now accepts an optional parameter [trim] for whether or not the strings should be trimmed for comparison.

- [FutureHelper] now supports up to running 10 [Future] functions in parallel

## 1.8.1

- Made it so that [ControllerException] implements [Exception]

## 1.8.0

- added a global error handler as well as a custom http client called [MakerHttpClient] that allows throwing exceptions on certain [Response] status codes from http.

## 1.7.0

- added shimmer loading widgets (check the example project to see it in action!)

- added a minor bug fix for checking whether device is a tablet or not

## 1.6.0

- added a new orderby type function [orderByMany] which allows you to order a list of complex object by multiple fields

## 1.5.1

- bug fixed for [orderBy] extension function

- added an [order] function for list of nullable premitive data types
  - [Enum]
  - [DateTime]
  - [String]
  - [num]
  - [Duration]
  - [TimeOfDay]
  - [Comparable]

## 1.5.0

- added a [FutureHelper] that allows you to run up to 6 future functions in parallel
- added more extensions to [list_extensions]
  - [intersectBy]
  - [orderBy] <- supports the following data types (see in code documentation for more information)
    - [Enum]
    - [DateTime]
    - [String]
    - [num]
    - [Duration]
    - [TimeOfDay]
- reorganized files

## 1.4.0

- added a new functions to list extensions
  - [minDate]
  - [maxDate]
  - [mapWithIndex]
- added a [maxParallelisms] property to [mapAsync] and [expandAsync]. (see in code docs for more)

- other bug fixes with correcting documentation

- added example widget pages to demonstrate using [getKeyPosition]

- added extension functions on [Brightness]. Get functions [isLight] and [isDark]

- **BREAKING CHANGES**:
  - class name changed from [PositionDate] to [WidgetPositionData]
  - properties name change in [PositionData] (now [WidgetPositionData])
    - [position] -> [relativeRect]
    - [widgetBox] -> [renderBox]

## 1.3.2

- bug fix with android not properly recognizing tablet

## 1.3.1

- bug fix with android not properly recognizing tablet

## 1.3.0

- **Added platform implementations**
  - There is a new class called [CoderMatthewsExtensions] which has a new function called [isTablet()] which returns a bool whether the current device is a tablet or a regulat phone.

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

- **BREAKING CHANGE**: removed [compoundAnd] and [compoundOr] from list extensions as dart already has a function like it.

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
