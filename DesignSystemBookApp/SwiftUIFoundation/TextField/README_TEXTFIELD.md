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
![image](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/d69f4916-55cb-475e-824c-46ddd9b0e41f)


If you want to bind a state to the text field, use `.state()`.
```swift
@State var text: String = ""
@State var state: TextFieldState = .normal // We also have error and success states.

TextField("Placeholder", text: $text)
    .styled(
        variant: .outlined,
        color: .primary,
        size: .large,
        shape: .round
    )
    .state(state)
```
_[error]_
<br/>
![image](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/000a83af-5c48-4d68-a7e3-d41d9719f985)
<br/>
_[success]_
<br/>
![image](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/67e62cef-d6d8-47c4-9c0d-e6dcc7e19051)


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
![image](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/5f29436e-efea-4288-9007-3eacb24118e0)

We also provide a way to specify suffixes and prefixes. Use `.prefix()` and `.suffix()` to add elements.
```swift
@State var text: String = ""

TextField("Placeholder", text: $text)
    .styled()
    .prefix {
        Image(systemName: "square.and.pencil")
            .foregroundColor(.gray)
    }
    .suffix {
        Text("\(text.count)/10")
            .foregroundColor(.gray)
    }
```
![image](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/a664c710-1e04-494e-89de-50413a223acb)

<br/>

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
![image](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/01149a76-efe1-4cde-9d44-2e5f448814ee)
![image](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/59856c93-0f79-4526-b2b7-5f9ebbe075ad)


Furthermore, you can add additional elements to the composition.
```swift
@State var text: String = ""
@State var state: TextFieldState = .normal

TextFieldContainer(state: state) {
    VStack(alignment: .leading) {
        HStack {
            Text("Title")
                .font(.system(size: 14, weight: .semibold))
            if (state == .success) {
                Image(systemName: "checkmark.circle")
                    .foregroundStyle(.success)
            }
        }
        TextField("Message example", text: $text)
            .styled()
        TextFieldCaption {
            HStack {
                Image(systemName: "exclamationmark.circle.fill")
                Text("error or success description")
            }
        }
    }
}
```
![image](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/669de758-0bea-4347-bd38-4926e981c488)

