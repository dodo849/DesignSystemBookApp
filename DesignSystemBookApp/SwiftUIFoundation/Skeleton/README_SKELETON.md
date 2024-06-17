# Skeleton
## Basic Usage
You can apply a skeleton using the `.skeleton()` method.
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


## Composition
By compositing various shapes, you can create a skeleton that closely resembles the actual content.
```swift
@State var state: SkeletonState = .loading

HStack {
    Image("logo_padding")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 60)
        .clipShape(.circle)
        .skeleton(
            variant: .shining,
            state: state,
            shape: .circle
        )
    VStack(alignment: .leading) {
        Text("User name")
            .font(.system(size: 16, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .skeleton(
                variant: /shining,
                state: state,
                shape: .pill
            )
        Text("user description")
            .font(.system(size: 14))
            .frame(maxWidth: .infinity, alignment: .leading)
            .skeleton(
                variant: .shining,
                state: state,
                shape: .pill
            )
    }
}
```
![Jun-17-2024 18-05-03](https://github.com/dodo849/DesignSystemBookApp/assets/71880682/2050688d-1b7b-4a4e-a2b2-f5d8f88ba77e)
