# ChipControl
## Basic Usage

You can create a segmented picker using the `ChipControl` component and `styled()`. 
The content closure allows you to add the content and components for each segment.
```swift
private options = [
        "Swift", "Long description", "Short", "Very long description chip",
        "Chip"
    ] // Implementing `Equatable` and `Identifiable` is required.
@State var selections: [String] = []

ChipControl(
    options,
    selection: $selections
) { option in
    Text("\(option.id)")
}.styled(
    variant: .fillAndOutline,
    color: .stone,
    shape: .round
)
```
![chip-control-basic](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/31b1fca6-8151-40c3-83b3-269171ae6f0a)


## Options
The `multipleSelection` option enables or disables multiple selection. The default value is '.allow'.

The `overflow` option specifies the strategy for handling chip overflow beyond screen width. 
The default option, `.wrap`, wraps the chip to the next line. 
The `.scroll` option allows horizontal scrolling if the chips overflow.

```swift
private options = [
        "Swift", "Long description", "Short", "Very long description chip",
        "Chip"
    ] // Implementing `Equatable` and `Identifiable` is required.
@State var selections: [String] = []

ChipControl(
    options,
    selection: $selections,
    multipleSelection: false, // Now only one item can be selected
    overflow: .scroll
) { option in
    Text("\(option.id)")
}.styled(
    variant: .fillAndOutline,
    color: .stone,
    shape: .round
)
```
![chip-control-options](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/123809d2-ac88-405e-878e-f37bd7bd69ff)


