# ChipControl
## Basic Usage

You can create a segmented picker using the `ChipControl` component and `styled()`. 
The content closure allows you to add the content and components for each segment.
```swift
private options = [
        "Swift", "Long description", "Short", "Very long description chip",
        "Chip"
    ] // Implementing `Equatable` and `Identifiable` is required.
@State var selections: [Int] = []

ChipControl(
    options,
    selection: $selections
) { option in
    Text("\(option.id)")
}.styled(
    variant: .shadow,
    color: .soft,
    shape: .round
)
```

## Options
The `multipleSelectio`n option enables or disables multiple selection. The default value is '.allow'.

The `overflow` option specifies the strategy for handling chip overflow beyond screen width. 
The default option, `.wrap`, wraps the chip to the next line. 
The `.scroll` option allows horizontal scrolling if the chips overflow.

```swift
private options = [
        "Swift", "Long description", "Short", "Very long description chip",
        "Chip"
    ] // Implementing `Equatable` and `Identifiable` is required.
@State var selections: [Int] = []

ChipControl(
    options,
    selection: $selections
) { option in
    Text("\(option.id)")
}.styled(
    variant: .shadow,
    color: .soft,
    shape: .round
)
```
