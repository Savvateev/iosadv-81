import SwiftUI

struct ContentView: View {
    @State private var titleOn = true

    var body: some View {
        TabView {
            InfoView(titleOn: titleOn)
                .tabItem {
                    Label("Info", systemImage: "books.vertical")
                }

            HelloView()
                .tabItem {
                    Label("Hello", systemImage: "hand.wave")
                }

            SettingsView(titleOn: $titleOn)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
