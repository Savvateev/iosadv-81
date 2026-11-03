//
//  AppAppearance.swift
//  GreatWriter
//
//  Created by Pavel Savvateev on 03.11.2026.
//


import SwiftUI

enum AppAppearance: String, CaseIterable, Identifiable {
    case system = "Системная"
    case light  = "Светлая"
    case dark   = "Тёмная"

    var id: String { rawValue }
}

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var appearance: AppAppearance = .system
    @State private var textSize: Double = 16

    var body: some View {
        NavigationView {
            Form {
                // Section 1: переключатель и текст
                Section {
                    Toggle("Уведомления", isOn: $notificationsEnabled)
                    Text("Оповещения о новых материалах базы знаний")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                // Section 2: выбор и ползунок
                Section("Внешний вид") {
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

#Preview {
    SettingsView()
}
