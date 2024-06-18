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
```swift
ToastManager.shared.showToast(
    message: "Toast test",
    variant: selectedVariant,
    shape: selectedShape
)
```
