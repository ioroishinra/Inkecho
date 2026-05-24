import SwiftUI
import Core
import DesignSystem

public struct StatsView: View {
    @Environment(\.appTheme) private var theme
    @Bindable var vm: StatsViewModel

    public init(vm: StatsViewModel) { self.vm = vm }

    public var body: some View {
        ZStack {
            theme.bg.ignoresSafeArea()
            VStack(spacing: AppSpacing.xl) {
                circularProgress
                statsGrid
            }
            .padding(AppSpacing.xl)
        }
        .navigationTitle("統計")
        .onAppear { vm.load() }
    }

    private var circularProgress: some View {
        ZStack {
            Circle().stroke(theme.border, lineWidth: 6)
            Circle()
                .trim(from: 0, to: vm.progress)
                .stroke(
                    LinearGradient(colors: [theme.accentDark, theme.accent],
                                   startPoint: .leading, endPoint: .trailing),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.8), value: vm.progress)
            VStack(spacing: 4) {
                Text("\(Int(vm.progress * 100))%")
                    .kyoukashoFont(size: 32).foregroundStyle(theme.text)
                Text("習得率").kyoukashoFont(size: 11).tracking(3)
                    .foregroundStyle(theme.textGhost)
            }
        }
        .frame(width: 180, height: 180)
    }

    private var statsGrid: some View {
        HStack(spacing: AppSpacing.md) {
            statCard("総語数",    value: vm.totalCount)
            statCard("習得済み", value: vm.masteredCount)
            statCard("未習得",   value: vm.unmasteredCount)
        }
    }

    private func statCard(_ label: String, value: Int) -> some View {
        VStack(spacing: AppSpacing.xs) {
            Text("\(value)").kyoukashoFont(size: 28).foregroundStyle(theme.text)
            Text(label).kyoukashoFont(size: 11).tracking(2).foregroundStyle(theme.textFaint)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppSpacing.md)
        .background(theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(theme.border, lineWidth: 1))
    }
}
