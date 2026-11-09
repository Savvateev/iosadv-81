import SwiftUI

struct InfoView: View {
    var titleOn: Bool

    private let kb = WorkKnowledgeBase()
    @State private var query = ""
    @State private var activeWork: Work?
    @State private var activeFilm: Adaptation?

    var body: some View {
        NavigationStack {
            List {
                // Экранизации — первыми
                let films = filteredAdaptations(kb.adaptations)
                if !films.isEmpty {
                    Section("Экранизации") {
                        ForEach(films) { film in
                            Button {
                                activeWork = nil
                                activeFilm = film
                            } label: {
                                AdaptationRow(film: film)
                            }
                            .buttonStyle(.plain)
                            .listRowBackground(
                                activeFilm?.id == film.id
                                    ? Color.accentColor.opacity(0.15)
                                    : Color.clear
                            )
                        }
                    }
                }

                // Произведения по жанрам — ниже
                ForEach(WorkGenre.allCases) { genre in
                    let items = filtered(kb.works(in: genre))
                    if !items.isEmpty {
                        Section(genre.rawValue) {
                            ForEach(items) { work in
                                Button {
                                    activeFilm = nil
                                    activeWork = work
                                } label: {
                                    InfoRow(work: work)
                                }
                                .buttonStyle(.plain)
                                .listRowBackground(
                                    activeWork?.id == work.id
                                        ? Color.accentColor.opacity(0.15)
                                        : Color.clear
                                )
                            }
                        }
                    }
                }
            }
            .navigationTitle(titleOn ? "В. П. Астафьев" : "")
            .searchable(text: $query, prompt: "Поиск по названию")
            .navigationDestination(item: $activeWork) { work in
                InfoDetails(work: work, adaptations: kb.adaptations(for: work.id))
            }
            .navigationDestination(item: $activeFilm) { film in
                AdaptationDetails(film: film)
            }
        }
    }

    private func filtered(_ works: [Work]) -> [Work] {
        guard !query.isEmpty else { return works }
        return works.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }

    private func filteredAdaptations(_ films: [Adaptation]) -> [Adaptation] {
        guard !query.isEmpty else { return films }
        return films.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }
}

struct AdaptationRow: View {
    let film: Adaptation

    var body: some View {
        HStack(spacing: 12) {
            Image(film.resolvedImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            VStack(alignment: .leading, spacing: 4) {
                Text(film.title)
                    .font(.headline)
                Text("\(film.year), реж. \(film.director)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    InfoView(titleOn: true)
}
