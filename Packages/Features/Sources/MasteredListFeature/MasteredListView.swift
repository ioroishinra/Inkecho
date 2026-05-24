import SwiftUI
import Core
import DesignSystem

public struct MasteredListView: View {
    @Environment(\.appTheme) private var theme
    @Bindable var vm: MasteredListViewModel

    public init(vm: MasteredListViewModel) { self.vm = vm }

    public var body: some View {
        ZStack {
            theme.bg.ignoresSafeArea()
            if vm.words.isEmpty {
                Text("習得した語彙はまだありません")
                    .kyoukashoFont(size: 13).tracking(3)
                    .foregroundStyle(theme.textGhost)
            } else {
                List(vm.words) { word in
                    HStack(alignment: .firstTextBaseline, spacing: AppSpacing.md) {
                        Text(word.kanji)
                            .kyoukashoFont(size: 18)
                            .foregroundStyle(theme.text)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(word.reading)
                                .kyoukashoFont(size: 11).tracking(2)
                                .foregroundStyle(theme.textDim)
                            Text(word.meaning)
                                .kyoukashoFont(size: 12)
                                .foregroundStyle(theme.textFaint)
                        }
                    }
                    .listRowBackground(theme.surface)
                    .listRowSeparatorTint(theme.border)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("習得済み")
        .onAppear { vm.load() }
    }
}
