import SwiftUI

public struct ThemeSettingsView: View {
    @Environment(\.appTheme) private var theme
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appTheme") private var themeName: String = AppTheme.darkInk.rawValue

    public init() {}

    public var body: some View {
        #if os(macOS)
        macOSBody
        #else
        iOSBody
        #endif
    }

    #if os(macOS)
    private var macOSBody: some View {
        Form {
            Picker("テーマ", selection: $themeName) {
                ForEach(AppTheme.allCases) { t in
                    Text(t.label).tag(t.rawValue)
                }
            }
            .pickerStyle(.radioGroup)
        }
        .padding(AppSpacing.xl)
        .frame(width: 280, height: 160)
        .background(theme.bg)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("完了") { dismiss() }
            }
        }
    }
    #else
    private var iOSBody: some View {
        NavigationStack {
            ZStack {
                theme.bg.ignoresSafeArea()
                VStack(spacing: AppSpacing.xl) {
                    ForEach(AppTheme.allCases) { t in themeRow(t) }
                    Spacer()
                }
                .padding(AppSpacing.xl)
            }
            .navigationTitle("テーマ")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(theme.colorScheme)
        .environment(\.appTheme, theme)
    }

    private func themeRow(_ t: AppTheme) -> some View {
        HStack {
            Circle()
                .fill(t.accent)
                .frame(width: 16, height: 16)
            Text(t.label)
                .kyoukashoFont(size: 15).tracking(2)
                .foregroundStyle(theme.text)
            Spacer()
            if themeName == t.rawValue {
                Image(systemName: "checkmark")
                    .foregroundStyle(theme.accent)
            }
        }
        .padding(AppSpacing.md)
        .background(theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .overlay(RoundedRectangle(cornerRadius: 4)
            .stroke(themeName == t.rawValue ? theme.accent : theme.border, lineWidth: 1))
        .onTapGesture { themeName = t.rawValue }
    }
    #endif
}
