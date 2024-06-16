# TextField

## Basic Usage
Use `.styled()` to apply styles to the text field.
```swift
@State var text: String = ""

TextField("Placeholder", text: $text)
    .styled(
        variant: .outlined,
        color: .primary,
        size: .large,
        shape: .round
    )
```


If you want to bind a state to the text field, use `.state()`.
```swift
@State var text: String = ""
@State var state: TextFieldState = .normal

TextField("Placeholder", text: $text)
    .styled(
        variant: .outlined,
        color: .primary,
        size: .large,
        shape: .round
    )
    .state(state)
```

You can use `.disabled()` directly.
```swift
@State var text: String = ""
@State var state: TextFieldState = .normal

TextField("Placeholder", text: $text)
    .styled(
        variant: .outlined,
        color: .primary,
        size: .large,
        shape: .round
    )
    .state(state)
    .disabled(true)
```



## Composit Components
Additional components are provided to configure external elements of the text field. 
Use `TextFieldContainer` and `TextFieldCaption`.

```swift
@State var text: String = ""
@State var state: TextFieldState = .normal

TextFieldContainer(state: state) {
    TextField("Caption example", text: $text)
        .styled()
    TextFieldCaption("error or success description")
}
```

Furthermore, you can add additional elements to the composition.
```swift
@State var text: String = ""
@State var state: TextFieldState = .normal

TextFieldContainer(state: state) {
    VStack(alignment: .leading) {
        Text("Title")
            .font(.system(size: 14, weight: .semibold))
        HStack {
            TextField("Message example", text: $text)
                .styled()
        }
        TextFieldCaption {
            HStack {
                Image(systemName: "exclamationmark.circle.fill")
                Text("error or success description")
            }
        }
    }
}
```
