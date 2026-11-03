import SwiftUI

enum AppAppearance: String, CaseIterable, Identifiable {
    case system = "Системная"
    case light  = "Светлая"
    case dark   = "Тёмная"

    var id: String { rawValue }
}

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var titleOn: Bool

    @State private var notificationsEnabled = true
    @State private var appearance: AppAppearance = .system
    @State private var textSize: Double = 16

    var body: some View {
        NavigationView {
            Form {
                // Section 1: состояние цветовой схемы и переключатель
                Section {
                    Text(colorScheme == .dark ? "Dark Theme enabled" : "Light Theme enabled")
                        .font(.headline)

                    Toggle("Уведомления", isOn: $notificationsEnabled)
                    Text("Оповещения о новых материалах базы знаний")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                // Section 2: заголовок списка, тема и размер текста
                Section("Внешний вид") {
                    Toggle("Заголовок списка", isOn: $titleOn)
                    if titleOn {
                        Text("Navigation title enabled")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }

                    Picker("Тема", selection: $appearance) {
                        ForEach(AppAppearance.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Размер текста: \(Int(textSize)) pt")
                        Slider(value: $textSize, in: 12...24, step: 1)
                    }

                    Text("Пример текста в выбранном размере")
                        .font(.system(size: textSize))
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview("Title on") {
    SettingsView(titleOn: .constant(true))
}

#Preview("Title off") {
    SettingsView(titleOn: .constant(false))
}
