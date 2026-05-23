import SwiftUI

public enum AppTab: Hashable { case study, mastered, stats }

@Observable
@MainActor
public final class AppRouter {
    public var selectedTab: AppTab = .study
    public init() {}
}
