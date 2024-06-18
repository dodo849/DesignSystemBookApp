# Toast

## Basic Usage

First, wrap the app's root view with `ToastFactory`.
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

Then, call `showToast()` through ToastManager at the point where you want to display the toast.
You can control the toast display duration with `duration`.
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



