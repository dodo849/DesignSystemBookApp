# RadioButton
> 라디오 버튼은 Toggle Style을 이용하므로 ToggleButton의 하위 컴포넌트로 분류됩니다.

## 기본 사용법
`SingleRadioButton`을 이용해 라디오 버튼을 선언하고 `styled()`를 이용해 스타일을 적용합니다.
```swift
@State private var selected: Bool = 0

SingleRadioButton(
    isOn: $selected,) {
    Text("Click me")
}
.styled(
    color: .primary,
    shape: .circle
)
```

SingleRadioButton은 기본적으로 CheckboxButton과 동일하게 동작하므로, 여러 개의 라디오 버튼 중 하나만 선택되도록 하려면 직접 해당 기능을 구현해야 합니다.
```swift
@State private var isOn: [Bool] = [false, false, false]

ForEach(0..<3) { index in
    SingleRadioButton(
        isOn: Binding<Bool>(
            get: { self.isOn[index] },
            set: { newValue in
                if newValue {
                    for isOnIndex in isOn.indices {
                        isOn[isOnIndex] = (isOnIndex == index)
                    }
                } else {
                    isOn[index] = false
                }
            }
        )
    ) {
        Text("Click me")
    }
    .styled()
}
```

## RadioGroup
`RadioGroup` 컴포넌트를 사용하면 간단하게 여러 라디오 버튼 중 하나만 선택되도록 할 수 있습니다.

```swift 
@State private var selection: AnyEnum = .first

RadioGroup(
    selection: $selection
) {
    ForEach(AnyEnum.allCases, id: \.self) { option in.
        RadioOption(value: option) {
            Text("\(option.rawValue)")
        }
        .styled()
    }
}
```
