import SwiftUI

struct InfoDetails: View {
    let work: Work
    let adaptations: [Adaptation]

    @StateObject private var player = AudioPlayer()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(work.resolvedImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 360)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                Text(work.title)
                    .font(.title)
                    .bold()

                Text(work.genre.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                audioSection

                if let years = work.yearsNote {
                    infoBlock("Годы", years)
                }
                if let cycle = work.cycle {
                    infoBlock("Цикл", cycle)
                }
                if let note = work.note {
                    infoBlock("Примечание", note)
                }

                if !work.awards.isEmpty {
                    sectionTitle("Награды и премии")
                    ForEach(work.awards, id: \.self) { award in
                        Text("• \(award.name), \(award.year)")
                    }
                }

                if !adaptations.isEmpty {
                    sectionTitle("Экранизации")
                    ForEach(adaptations, id: \.self) { film in
                        Text("• \(film.year), «\(film.title)», реж. \(film.director)")
                    }
                }
            }
            .padding()
        }
        .navigationTitle(work.title)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .onAppear { player.load(named: work.resolvedAudioName) }
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

                    Text(player.isPlaying ? "Идёт воспроизведение" : "Прослушать")
                        .foregroundStyle(.secondary)
                }
            } else {
                Label("Аудио для этого произведения не добавлено", systemImage: "speaker.slash")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: player.isPlaying)
    }

    private func infoBlock(_ label: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
        }
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .padding(.top, 8)
    }
}

#Preview {
    NavigationStack {
        InfoDetails(work: Work.seed[2], adaptations: [])
    }
}
