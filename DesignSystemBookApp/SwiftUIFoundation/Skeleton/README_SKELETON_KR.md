# Skeleton
## 기본 사용법
`.skeleton()`메서드를 이용해서 스켈레톤을 적용할 수 있습니다.
```swift
@State var state: SkeletonState = .loading

Text(selectedState == .loading ? "loading..." : "loaded")
    .skeleton(
        variant: .shining,
        state: state,
        shape: .round
    )
```
![Jun-17-2024 18-04-57](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/1eb57283-fffa-41c8-94fe-8ba4f44357ad)
<br>


## 조합하기
여러 Shape를 조합해 실제 컨텐츠와 유사한 스켈레톤을 생성할 수 있습니다.
```swift
HStack {
    Image("logo_padding")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 60)
        .clipShape(.circle)
        .skeleton(
            variant: selectedVariant,
            state: selectedState,
            shape: .circle
        )
    VStack(alignment: .leading) {
        Text("User name")
            .font(.system(size: 16, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .skeleton(
                variant: selectedVariant,
                state: selectedState,
                shape: .pill
            )
        Text("user description")
            .font(.system(size: 14))
            .frame(maxWidth: .infinity, alignment: .leading)
            .skeleton(
                variant: selectedVariant,
                state: selectedState,
                shape: .pill
            )
    }
}
```         
![Jun-17-2024 18-05-03](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/2050688d-1b7b-4a4e-a2b2-f5d8f88ba77e)

