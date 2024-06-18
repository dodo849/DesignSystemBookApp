# Toast

## Basic Usage

첫번째로, 앱 루트뷰를 ToastFactory로 감싸주세요.
```swift
@main
struct DesignSystemApp: App {
    var body: some Scene {
        WindowGroup {
            ToastFactory {
                ContentView()
            }
        }
    }
}

```

그리고 토스트를 띄우고싶은 시점에 ToastManager를 통해 `showToast()`를 호출하세요
```swift
ToastManager.shared.showToast(
    message: "Toast test",
    variant: selectedVariant,
    shape: selectedShape
)
```
