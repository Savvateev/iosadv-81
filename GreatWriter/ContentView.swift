import SwiftUI

// Ключ в UserDefaults. Храним в одном месте, чтобы не ошибиться в написании.
enum AppStorageKeys {
    static let titleOn = "titleOn"
}

struct ContentView: View {
    // Значение читается из памяти при запуске и записывается при каждом изменении
    @AppStorage(AppStorageKeys.titleOn) private var titleOn = true

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

            // $titleOn — Binding<Bool>, изменения из Settings сразу попадают в память
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
