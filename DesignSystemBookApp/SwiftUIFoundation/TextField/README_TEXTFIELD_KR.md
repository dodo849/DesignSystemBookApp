# TextField
## 기본 사용법
`.styled()`를 이용해 텍스트필드에 스타일링을 적용할 수 있습니다.
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


`error`, `success`등의 상태를 바인딩하고 싶다면 `.state()`를 이용하세요.
```swift
@State var text: String = ""
@State var state: TextFieldState = .normal // 추가적인 상태는 error와 success가 있습니다.

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

기존의 `.disabled()`를 그대로 사용할 수 있습니다.
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

또한 특별한 suffix나 prefix를 추가할 수 있습니다. `.prefix()`와 `.suffix()`를 통해 추가하세요.
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

## 컴포넌트 조합하기
텍스트 필드 외부의 컴포넌트를 설정하기 위한 추가적인 방법을 제공합니다.
`TextFieldContainer`와 `TextFieldCaption` 입니다.

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

그 외에도 다양한 컴포넌트를 추가적으로 조합할 수 있습니다.
```swift
@State var text: String = ""
@State var state: TextFieldState = .normal

TextFieldContainer(state: state) {
    VStack(alignment: .leading) {
        HStack {
            Text("Title")
                .font(.system(size: 14, weight: .semibold))
            if isSuccess {
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

var isSuccess: Bool {
    state == .success
}
```
![image](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/669de758-0bea-4347-bd38-4926e981c488)
