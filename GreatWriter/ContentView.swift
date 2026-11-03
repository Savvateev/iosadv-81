//
//  ContentView.swift
//  GreatWriter
//
//  Created by Pavel Savvateev on 03.11.2026.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            InfoView()
                .tabItem {
                    Label("Info", systemImage: "books.vertical")
                }

            HelloView()
                .tabItem {
                    Label("Hello", systemImage: "hand.wave")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
