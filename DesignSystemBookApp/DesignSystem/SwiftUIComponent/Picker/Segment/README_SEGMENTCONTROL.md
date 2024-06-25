# SegmentControl
## Basic Usage

You can create a segmented picker using the `Segment` component and `styled()`. 
The content closure allows you to add the content and components for each segment.
```swift
private options = ["0", "1", "2"] // Implementing `Equatable` and `Identifiable` is required.
@State var selection: Int = 0

Segment(
    options,
    selection: $selection
) { option in
    Text("\(option.id)")
}.styled(
    variant: .shadow,
    color: .soft,
    shape: .round
)
```
![Jun-20-2024 14-35-35](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/da4a5e60-7877-4d78-8124-103324132432)


## Composition
In the content closure, you can composit multiple components.
```swift
private options = ["0", "1", "2"] // Implementing `Equatable` and `Identifiable` is required.
@State var selection: Int = 0

Segment(
    options,
    selection: $selection
) { option in
    HStack {
        Text("\(option.id)")
        if option.id == 1 {
            Text("N")
                .typo(.detail)
                .padding(6)
                .foregroundStyle(.white)
                .background(.destructive)
                .clipShape(Circle())
        }
    }
}.styled(
    variant: .shadow,
    color: .soft,
    shape: .round
)
```
![Jun-20-2024 14-36-17](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/704a4537-ad73-481a-a7f7-f68d57bcc7d6)
