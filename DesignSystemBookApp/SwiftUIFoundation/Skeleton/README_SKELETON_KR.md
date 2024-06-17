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
