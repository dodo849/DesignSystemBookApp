# SegmentControl
## 기본 사용법

`Segment` 컴포넌트와 `styled()`를 사용하여 세그먼트형 피커를 생성할 수 있습니다.
content 클로저로는 각 세그먼트의 내용과 컴포넌트를 추가할 수 있습니다.
```swift
private options = ["0", "1", "2"] // 실제로는 Equatable & Identifiable 채택 필요
@State var selection: Int = 0

SegmentControl(
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

## 조합하기
content 클로저에서 여러 컴포넌트와 조합하여 사용할 수 있습니다.
```swift
private options = ["0", "1", "2"] // 실제로는 Equatable & Identifiable 채택 필요
@State var selection: Int = 0

SegmentControl(
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
