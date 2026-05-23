import SwiftUI

public struct ProgressBar: View {
    public let progress: Double   // 0…1

    public init(progress: Double) { self.progress = max(0, min(1, progress)) }

    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Color(white: 0.15).frame(maxWidth: .infinity)
                LinearGradient(
                    colors: [Color(red: 0.45, green: 0.32, blue: 0.14),
                             Color(red: 0.78, green: 0.62, blue: 0.38)],
                    startPoint: .leading, endPoint: .trailing
                )
                .frame(width: geo.size.width * progress)
                .animation(.easeInOut(duration: 0.6), value: progress)
            }
        }
        .frame(height: 1)
    }
}
