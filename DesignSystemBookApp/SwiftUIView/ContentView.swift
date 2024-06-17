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
                        destination: BasicButtonBook()
                    )
                    
                    Spacer().frame(height: 10)
                    
                    exampleSection(
                        title: "Gray Button",
                        colorTheme: "Gray",
                        figureTheme: "Basic",
                        destination: GrayButtonBook()
                    )
                    
                    Spacer().frame(height: 20)
                    
                    sectionHeader(title: "ToggleButton")
                    
                    exampleSection(
                        title: "CheckButton",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        destination: CheckButtonBook()
                    )
                    
                    Spacer().frame(height: 20)
                    
                    exampleSection(
                        title: "RadioButton",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        destination: RadioButtonBook()
                    )
                    
                    Spacer().frame(height: 20)
                    
                    sectionHeader(title: "TextField")
                    
                    exampleSection(
                        title: "Basic TextField",
                        colorTheme: "Basic",
                        figureTheme: "Basic",
                        destination: TextFieldBook()
                    )
                    
                    Spacer().frame(height: 20)
                    
                    sectionHeader(title: "Skeleton")
                    
                    exampleSection(
                        title: "Basic Skeleton",
                        colorTheme: "-",
                        figureTheme: "-",
                        destination: SkeletonBook()
                    )
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
    private func exampleSection<Destination: View>(
        title: String,
        colorTheme: String,
        figureTheme: String,
        destination: Destination
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
            Text("Color theme **\(colorTheme)** | Figure theme **\(figureTheme)**")
                .font(.system(size: 14))
                .foregroundStyle(.gray)
            NavigationLink(destination: destination) {
                Text("\(title) example")
            }
        }
    }
}

#Preview {
    ContentView()
}
