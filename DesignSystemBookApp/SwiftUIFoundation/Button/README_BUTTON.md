# Button
## Bad Example ❌
When using multiple components in a button label, not wrapping the components can make it look like two separate buttons.

```swift
Button {
    <#Action#>
} label: {
    Image(systemName: "square.and.arrow.up")
    Text("Button")
}.styled()
```

## Good Example ✅
When using multiple components, wrap them in a container component.

```swift
Button {
    <#Action#>
} label: {
    HStack {
        Image(systemName: "square.and.arrow.up")
        Text("Button")
    }
}
.styled()
```


## Recommendation 👍
Label is suitable for handling both text and icons, and is used in interactive menus.

```swift
Button {
    <#Action#>
} label: {
    Label("Button", systemImage: "square.and.arrow.up")
}
.styled()
```

