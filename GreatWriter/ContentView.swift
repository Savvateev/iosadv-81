import SwiftUI

enum AppStorageKeys {
    static let titleOn = "titleOn"
}

struct ContentView: View {
    @AppStorage(AppStorageKeys.titleOn) private var titleOn = true

    var body: some View {
        TabView {
            InfoView(titleOn: titleOn)
                .tabItem {
                    Label("Info", systemImage: "books.vertical")
                }

            GreetingView()
                .tabItem {
                    Label("Hello", systemImage: "text.bubble")
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
