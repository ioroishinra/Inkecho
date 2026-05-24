import SwiftUI
import Core
import DesignSystem

public struct StudySessionView: View {
    @Environment(\.appTheme) private var theme
    @Bindable var vm: StudySessionViewModel
    @State private var showSettings = false

    public init(vm: StudySessionViewModel) { self.vm = vm }

    public var body: some View {
        ZStack {
            theme.bg.ignoresSafeArea()
            content
            if let msg = vm.toast {
                VStack { Spacer(); ToastView(msg).padding(.bottom, AppSpacing.xl) }
                    .transition(.opacity)
            }
        }
        .onAppear { vm.loadDeck() }
        .animation(.easeInOut(duration: AppAnimation.toastAppearanceDuration), value: vm.toast)
        .sheet(isPresented: $showSettings) { ThemeSettingsView() }
    }

    @ViewBuilder private var content: some View {
        if vm.isLoading {
            Text("読み込み中")
                .kyoukashoFont(size: 12).tracking(4)
                .foregroundStyle(theme.textGhost)
        } else {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    header.padding(.bottom, AppSpacing.md)
                    ProgressBar(progress: vm.progress)
                }
                .frame(maxWidth: 600)
                .padding(.horizontal, AppSpacing.xl)
                .frame(maxWidth: .infinity)

                Spacer().frame(height: AppSpacing.xl)

                if let card = vm.currentCard {
                    VStack(spacing: AppSpacing.sm) {
                        FlashCardView(isFlipped: vm.isFlipped, onTap: vm.flip) {
                            cardFront(card)
                        } back: {
                            cardBack(card)
                        }
                        .offset(x: slideOffset)
                        .animation(.easeInOut(duration: AppAnimation.cardFlipDuration), value: vm.slideDirection)
                        actionButtons
                        secondaryButtons
                    }
                    .frame(maxWidth: 600)
                    .padding(.horizontal, AppSpacing.xl)
                    .frame(maxWidth: .infinity)
                } else {
                    EmptyStateView(message: "全語彙を習得しました",
                                   buttonLabel: "もう一度", action: vm.shuffleAll)
                }
                Spacer()
            }
            .padding(.top, AppSpacing.xl)
        }
    }

    private var header: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("和語動詞")
                .kyoukashoFont(size: 13).tracking(5)
                .foregroundStyle(theme.textGhost)
            Spacer()
            Group {
                Text("\(vm.masteredCount)").foregroundStyle(theme.textFaint)
                + Text(" / \(vm.totalCount)").foregroundStyle(theme.textGhost)
                + Text("  習得").foregroundStyle(theme.textGhost)
            }
            .kyoukashoFont(size: 12)
            Button { showSettings = true } label: {
                Image(systemName: "gearshape")
                    .font(.system(size: 13))
                    .foregroundStyle(theme.textGhost)
            }
            .buttonStyle(.plain)
            .padding(.leading, AppSpacing.sm)
        }
    }

    private var slideOffset: CGFloat {
        switch vm.slideDirection {
        case .left:  return -AppAnimation.cardSlideOffset
        case .right: return  AppAnimation.cardSlideOffset
        case .none:  return    0
        }
    }

    private func cardFront(_ card: Word) -> some View {
        VStack(spacing: AppSpacing.md) {
            Text(card.kanji)
                .kyoukashoFont(size: 42, weight: .medium)
                .foregroundStyle(theme.text)
            Text(card.reading)
                .kyoukashoFont(size: 16).tracking(3)
                .foregroundStyle(theme.textDim)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func cardBack(_ card: Word) -> some View {
        VStack(spacing: AppSpacing.lg) {
            Text(card.meaning)
                .kaitiFont(size: 18)
                .foregroundStyle(theme.text)
                .multilineTextAlignment(.center)
            Divider().background(theme.border)
            Text(card.example)
                .kaitiFont(size: 13).tracking(1)
                .foregroundStyle(theme.textFaint)
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
