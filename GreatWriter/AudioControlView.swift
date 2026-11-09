
import SwiftUI

struct AudioControlView: View {
    @ObservedObject var player: AudioPlayer
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        HStack(spacing: 14) {
            Button {
                player.toggle()
            } label: {
                ZStack {
                    // Кольцо пульсирует, пока звучит трек
                    Circle()
                        .stroke(Color.accentColor.opacity(0.6), lineWidth: 3)
                        .frame(width: 56, height: 56)
                        .scaleEffect(player.isPlaying ? 1.35 : 1.0)
                        .opacity(player.isPlaying ? 0 : 1)
                        .animation(ringAnimation, value: player.isPlaying)

                    Image(systemName: player.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(.tint)
                        .scaleEffect(player.isPlaying ? 1.06 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: player.isPlaying)
                }
                .frame(width: 56, height: 56)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 6) {
                equalizer

                Text(player.isPlaying ? "Звучит саундтрек" : "Прослушать саундтрек")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: player.isPlaying)
    }

    /// Четыре полоски, которые «танцуют» при воспроизведении и опускаются на паузе
    private var equalizer: some View {
        HStack(alignment: .bottom, spacing: 3) {
            ForEach(0..<4, id: \.self) { index in
                Capsule()
                    .fill(Color.accentColor)
                    .frame(width: 4, height: 22)
                    .scaleEffect(y: player.isPlaying ? 1.0 : 0.3, anchor: .bottom)
                    .animation(barAnimation(index: index), value: player.isPlaying)
            }
        }
        .frame(height: 22)
    }

    // MARK: Анимации

    private var ringAnimation: Animation? {
        guard !reduceMotion else { return nil }
        return player.isPlaying
            ? .easeOut(duration: 1.1).repeatForever(autoreverses: false)
            : .easeOut(duration: 0.2)
    }

    private func barAnimation(index: Int) -> Animation? {
        guard !reduceMotion else { return nil }
        return player.isPlaying
            ? .easeInOut(duration: 0.45)
                .repeatForever(autoreverses: true)
                .delay(Double(index) * 0.12)
            : .easeOut(duration: 0.2)
    }
}

#Preview {
    AudioControlView(player: AudioPlayer())
        .padding()
}
