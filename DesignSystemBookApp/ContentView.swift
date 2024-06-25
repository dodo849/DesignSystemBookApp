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
                        .padding(.bottom, 20)
                    
                    sectionHeader(title: "Button")
                    
                    exampleSection(
                        title: "Basic Button",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        uikitDestination: ButtonBookRepresentable()
                            .ignoresSafeArea(),
                        swiftuiDestination: BasicButtonBook()
                    )
                    
                    exampleSection(
                        title: "Gray Button",
                        colorTheme: "Gray",
                        figureTheme: "Basic",
                        swiftuiDestination: GrayButtonBook()
                    )
                    
                    sectionHeader(title: "ToggleButton")
                    
                    exampleSection(
                        title: "CheckButton",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        swiftuiDestination: CheckButtonBook()
                    )
                    
                    exampleSection(
                        title: "RadioButton",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        swiftuiDestination: RadioButtonBook()
                    )
                    
                    sectionHeader(title: "TextField")
                    
                    exampleSection(
                        title: "Basic TextField",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        uikitDestination: TextFieldBookRepresentable(),
                        swiftuiDestination: TextFieldBook()
                    )
                    
                    sectionHeader(title: "Skeleton")
                    
                    exampleSection(
                        title: "Basic Skeleton",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        swiftuiDestination: SkeletonBook()
                    )
                    
                    sectionHeader(title: "Toast")
                    
                    exampleSection(
                        title: "Basic Toast",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        swiftuiDestination: ToastBook()
                    )
                    
                    sectionHeader(title: "Picker")
                    
                    exampleSection(
                        title: "Basic Segment",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        swiftuiDestination: SegmentControlBook()
                    )
                    
                    exampleSection(
                        title: "Basic Chip",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        swiftuiDestination: ChipControlBook()
                    )
                    
                    Spacer().frame(height: 100)
                }
                .padding(.horizontal)
                .frameMax([.width], alignment: .leading)
            }
            .background(.basicBackground)
        }
    }
    
    @ViewBuilder
    private func sectionHeader(title: String) -> some View {
        Text(title)
            .typo(.heading3)
    }
    
    @ViewBuilder
    private func exampleSection<UIKitDestination: View, SwiftUIDestination: View>(
        title: String,
        colorTheme: String,
        figureTheme: String,
        uikitDestination: UIKitDestination = Text("준비중입니다 🙇"),
        swiftuiDestination: SwiftUIDestination
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .typo(.body0b)
            Text("Color theme **\(colorTheme)** | Figure theme **\(figureTheme)**")
                .font(.system(size: 14))
                .foregroundStyle(.gray)
            NavigationLink(destination: uikitDestination) {
                Text("UIKit example")
                    .foregroundStyle(.blue)
            }
            NavigationLink(destination: swiftuiDestination) {
                Text("SwiftUI example")
                    .foregroundStyle(.blue)
            }
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    ContentView()
}
