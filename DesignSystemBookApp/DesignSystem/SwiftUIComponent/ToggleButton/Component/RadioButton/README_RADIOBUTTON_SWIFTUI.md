# RadioButton

> Radio buttons are classified as subcomponents of ToggleButton since they use the Toggle Style.
## Basic Usage
Declare a radio button using `SingleRadioButton` and apply `styled()` using styled.
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
![Jun-20-2024 17-54-07](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/5d2ac62a-6163-49d6-ae4a-fa310bb63f8e)

`SingleRadioButton` functions similarly to `CheckboxButton` by default. 
To ensure only one radio button is selected among multiple options, you need to implement this functionality manually.
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
![Jun-20-2024 17-53-12](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/3164e462-bb8f-4754-a98f-584eb1d60092)
## Radio Group
Using the `RadioGroup` component makes it easy to ensure only one radio button is selected among multiple options.
> ⚠️ The `RadioOption` component must be used within a `RadioGroup`.
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
