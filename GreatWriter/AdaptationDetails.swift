
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
        Group {
            if player.hasTrack {
                AudioControlView(player: player)
            } else {
                Label("Саундтрек не добавлен", systemImage: "speaker.slash")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AdaptationDetails(film: Adaptation.seed[2])
    }
}
