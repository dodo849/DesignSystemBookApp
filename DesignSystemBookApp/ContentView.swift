import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                Spacer().frame(height: 100)
                
                VStack(alignment: .leading, spacing: 4) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                    
                    Spacer().frame(height: 20)
                    
                    sectionHeader(title: "Button")
                    
                    exampleSection(
                        title: "Basic Button",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        uikitDestination: ButtonBookRepresentable(),
                        swiftuiDestination: BasicButtonBook()
                    )
                    
                    Spacer().frame(height: 10)
                    
                    exampleSection(
                        title: "Gray Button",
                        colorTheme: "Gray",
                        figureTheme: "Basic",
                        swiftuiDestination: GrayButtonBook()
                    )
                    
                    Spacer().frame(height: 20)
                    
                    sectionHeader(title: "ToggleButton")
                    
                    exampleSection(
                        title: "CheckButton",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        swiftuiDestination: CheckButtonBook()
                    )
                    
                    Spacer().frame(height: 20)
                    
                    exampleSection(
                        title: "RadioButton",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        swiftuiDestination: RadioButtonBook()
                    )
                    
                    Spacer().frame(height: 20)
                    
                    sectionHeader(title: "TextField")
                    
                    exampleSection(
                        title: "Basic TextField",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        swiftuiDestination: TextFieldBook()
                    )
                    
                    Spacer().frame(height: 20)
                    
                    sectionHeader(title: "Skeleton")
                    
                    exampleSection(
                        title: "Basic Skeleton",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        swiftuiDestination: SkeletonBook()
                    )
                    
                    Spacer().frame(height: 100)
                }
                .padding(.horizontal)
                .frameMax([.width], alignment: .leading)
            }
        }
    }
    
    @ViewBuilder
    private func sectionHeader(title: String) -> some View {
        Text(title)
            .font(.system(size: 24, weight: .bold))
    }
    
    @ViewBuilder
    private func exampleSection<UIKitDestination: View, SwiftUIDestination: View>(
        title: String,
        colorTheme: String,
        figureTheme: String,
        uikitDestination: UIKitDestination = EmptyView(),
        swiftuiDestination: SwiftUIDestination
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
            Text("Color theme **\(colorTheme)** | Figure theme **\(figureTheme)**")
                .font(.system(size: 14))
                .foregroundStyle(.gray)
            NavigationLink(destination: uikitDestination) {
                Text("UIKit example")
            }
            NavigationLink(destination: swiftuiDestination) {
                Text("SwiftUI example")
            }
        }
    }
}

#Preview {
    ContentView()
}
