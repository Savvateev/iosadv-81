//
//  AdaptationDetails.swift
//  GreatWriter
//
//  Created by Pavel Savvateev on 09.11.2026.
//


import SwiftUI

struct AdaptationDetails: View {
    let film: Adaptation

    @StateObject private var player = AudioPlayer()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(film.resolvedImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 360)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                Text(film.title)
                    .font(.title)
                    .bold()

                Text("\(film.year), реж. \(film.director)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                audioSection

                if let note = film.note {
                    Text(note)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle(film.title)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .onAppear {
            if let name = film.audioName { player.load(named: name) }
        }
        .onDisappear { player.stop() }
    }

    private var audioSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            if player.hasTrack {
                HStack(spacing: 12) {
                    Button {
                        player.toggle()
                    } label: {
                        Image(systemName: player.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 44))
                            .scaleEffect(player.isPlaying ? 1.08 : 1.0)
                            .foregroundStyle(.tint)
                    }
                    .buttonStyle(.plain)

                    Text(player.isPlaying ? "Звучит саундтрек" : "Прослушать саундтрек")
                        .foregroundStyle(.secondary)
                }
            } else {
                Label("Саундтрек не добавлен", systemImage: "speaker.slash")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: player.isPlaying)
    }
}

#Preview {
    NavigationStack {
        AdaptationDetails(film: Adaptation.seed[2])
    }
}
