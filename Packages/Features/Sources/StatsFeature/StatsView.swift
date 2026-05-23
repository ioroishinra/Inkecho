import SwiftUI
import Core
import DesignSystem

public struct StatsView: View {
    @Bindable var vm: StatsViewModel

    public init(vm: StatsViewModel) { self.vm = vm }

    public var body: some View {
        ZStack {
            Color(red: 0.059, green: 0.051, blue: 0.043).ignoresSafeArea()
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
            Circle()
                .stroke(Color(white: 0.15), lineWidth: 6)
            Circle()
                .trim(from: 0, to: vm.progress)
                .stroke(
                    LinearGradient(colors: [Color(red: 0.45, green: 0.32, blue: 0.14),
                                            Color(red: 0.78, green: 0.62, blue: 0.38)],
                                   startPoint: .leading, endPoint: .trailing),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.8), value: vm.progress)
            VStack(spacing: 4) {
                Text("\(Int(vm.progress * 100))%")
                    .kyoukashoFont(size: 32)
                    .foregroundStyle(Color(white: 0.85))
                Text("習得率").kyoukashoFont(size: 11).tracking(3)
                    .foregroundStyle(Color(white: 0.35))
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
            Text("\(value)")
                .kyoukashoFont(size: 28)
                .foregroundStyle(Color(white: 0.80))
            Text(label).kyoukashoFont(size: 11).tracking(2)
                .foregroundStyle(Color(white: 0.38))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppSpacing.md)
        .background(Color(white: 0.07))
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .overlay(RoundedRectangle(cornerRadius: 4)
            .stroke(Color(white: 0.14), lineWidth: 1))
    }
}
