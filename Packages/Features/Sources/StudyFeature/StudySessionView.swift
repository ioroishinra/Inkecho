import SwiftUI
import Core
import DesignSystem

public struct StudySessionView: View {
    @Bindable var vm: StudySessionViewModel

    public init(vm: StudySessionViewModel) { self.vm = vm }

    public var body: some View {
        ZStack {
            Color(red: 0.059, green: 0.051, blue: 0.043).ignoresSafeArea()
            content
            if let msg = vm.toast {
                VStack {
                    Spacer()
                    ToastView(msg).padding(.bottom, AppSpacing.xl)
                }
                .transition(.opacity)
            }
        }
        .onAppear { vm.loadDeck() }
        .animation(.easeInOut(duration: 0.2), value: vm.toast)
    }

    @ViewBuilder private var content: some View {
        if vm.isLoading {
            Text("読み込み中")
                .kyoukashoFont(size: 12)
                .tracking(4)
                .foregroundStyle(Color(white: 0.35))
        } else {
            VStack(spacing: 0) {
                header.padding(.horizontal, AppSpacing.xl).padding(.bottom, AppSpacing.md)
                ProgressBar(progress: vm.progress).padding(.horizontal, AppSpacing.xl)
                Spacer().frame(height: AppSpacing.xl)
                if let card = vm.currentCard {
                    cardArea(card).padding(.horizontal, AppSpacing.xl)
                } else {
                    EmptyStateView(
                        message: "全語彙を習得しました",
                        buttonLabel: "もう一度",
                        action: vm.shuffleAll
                    )
                }
                Spacer()
            }
            .padding(.top, AppSpacing.xl)
        }
    }

    private var header: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("和語動詞")
                .kyoukashoFont(size: 13)
                .tracking(5)
                .foregroundStyle(Color(white: 0.35))
            Spacer()
            Group {
                Text("\(vm.masteredCount)").foregroundStyle(Color(white: 0.55))
                + Text(" / \(vm.totalCount)").foregroundStyle(Color(white: 0.28))
                + Text("  習得").foregroundStyle(Color(white: 0.30))
            }
            .kyoukashoFont(size: 12)
        }
    }

    private func cardArea(_ card: Word) -> some View {
        VStack(spacing: AppSpacing.sm) {
            FlashCardView(isFlipped: vm.isFlipped, onTap: vm.flip) {
                cardFront(card)
            } back: {
                cardBack(card)
            }
            .offset(x: slideOffset)
            .animation(.easeInOut(duration: 0.25), value: vm.slideDirection)

            actionButtons
            secondaryButtons
        }
    }

    private var slideOffset: CGFloat {
        switch vm.slideDirection {
        case .left:  return -300
        case .right: return  300
        case .none:  return    0
        }
    }

    private func cardFront(_ card: Word) -> some View {
        VStack(spacing: AppSpacing.md) {
            Text(card.kanji)
                .kyoukashoFont(size: 42, weight: .medium)
                .foregroundStyle(Color(white: 0.88))
            Text(card.reading)
                .kyoukashoFont(size: 16)
                .tracking(3)
                .foregroundStyle(Color(white: 0.45))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func cardBack(_ card: Word) -> some View {
        VStack(spacing: AppSpacing.lg) {
            Text(card.meaning)
                .kyoukashoFont(size: 18)
                .foregroundStyle(Color(white: 0.82))
                .multilineTextAlignment(.center)
            Divider().background(Color(white: 0.20))
            Text(card.example)
                .kyoukashoFont(size: 13)
                .tracking(1)
                .foregroundStyle(Color(white: 0.38))
                .multilineTextAlignment(.center)
        }
        .padding(AppSpacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @ViewBuilder private var actionButtons: some View {
        HStack(spacing: AppSpacing.sm) {
            if !vm.isFlipped {
                ActionButton("スキップ", action: vm.skip)
            } else {
                ActionButton("もう一度", action: vm.skip)
                ActionButton("覚えた ✓", style: .accent, action: vm.master)
            }
        }
    }

    private var secondaryButtons: some View {
        HStack(spacing: AppSpacing.sm) {
            ActionButton("全語シャッフル", action: vm.shuffleAll)
            ActionButton("未習得のみ",     action: vm.shuffleUnmastered)
        }
        .opacity(0.7)
    }
}
