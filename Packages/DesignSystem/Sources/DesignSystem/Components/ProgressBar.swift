import SwiftUI

public struct ProgressBar: View {
    @Environment(\.appTheme) private var theme
    public let progress: Double

    public init(progress: Double) { self.progress = max(0, min(1, progress)) }

    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                theme.border.frame(maxWidth: .infinity)
                LinearGradient(
                    colors: [theme.accentDark, theme.accent],
                    startPoint: .leading, endPoint: .trailing
                )
                .frame(width: geo.size.width * progress)
                .animation(.easeInOut(duration: 0.6), value: progress)
            }
        }
        .frame(height: 1)
    }
}
