import SwiftUI
import Core
import DesignSystem

public struct MasteredListView: View {
    @Bindable var vm: MasteredListViewModel

    public init(vm: MasteredListViewModel) { self.vm = vm }

    public var body: some View {
        ZStack {
            Color(red: 0.059, green: 0.051, blue: 0.043).ignoresSafeArea()
            Group {
                if vm.words.isEmpty {
                    Text("習得した語彙はまだありません")
                        .kyoukashoFont(size: 13)
                        .tracking(3)
                        .foregroundStyle(Color(white: 0.35))
                } else {
                    List(vm.words) { word in
                        HStack(alignment: .firstTextBaseline, spacing: AppSpacing.md) {
                            Text(word.kanji)
                                .kyoukashoFont(size: 18)
                                .foregroundStyle(Color(white: 0.82))
                            VStack(alignment: .leading, spacing: 2) {
                                Text(word.reading)
                                    .kyoukashoFont(size: 11)
                                    .tracking(2)
                                    .foregroundStyle(Color(white: 0.40))
                                Text(word.meaning)
                                    .kyoukashoFont(size: 12)
                                    .foregroundStyle(Color(white: 0.50))
                            }
                        }
                        .listRowBackground(Color(white: 0.07))
                        .listRowSeparatorTint(Color(white: 0.15))
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .navigationTitle("習得済み")
        .onAppear { vm.load() }
    }
}
