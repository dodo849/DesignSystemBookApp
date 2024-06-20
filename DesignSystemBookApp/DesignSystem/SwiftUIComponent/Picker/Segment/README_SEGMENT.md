# Segment
## Basic Usage

You can create a segmented picker using the `Segment` component and `styled()`. 
The content closure allows you to add the content and components for each segment.
```swift
private options = ["0", "1", "2"] // 실제로는 Equatable & Identifiable 채택 필요
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

## Composition
In the content closure, you can composit multiple components.
```swift
private options = ["0", "1", "2"] // 실제로는 Equatable & Identifiable 채택 필요
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
