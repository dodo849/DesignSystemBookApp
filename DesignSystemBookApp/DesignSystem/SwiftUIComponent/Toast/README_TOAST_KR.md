# Toast

## Basic Usage

첫번째로, 앱 루트뷰를 `ToastFactory`로 감싸주세요.
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

그리고 토스트를 띄우고 싶은 시점에 ToastManager를 통해 `showToast()`를 호출하세요
토스트가 유지되는 시간은 `duration`을 통해 설정할 수 있습니다.
```swift
ToastManager.shared.showToast(
    message: "Toast test",
    variant: .success,
    shape: .pill,
    alignment: .bottom,
    duration: 2
)
```

https://github.com/dodo849/DesignSystemBookApp/assets/71880682/c50ebd4f-f738-4e03-8af0-105dbfdde4a2
