//
//  DynamicIslandManager.swift
//  Dynamo Island
//
//  Created by Shubham Nanda on 20/07/24.
//

// DynamicIslandManager.swift
import SwiftUI
import WidgetKit

class DynamicIslandManager: ObservableObject {
    @Published var isDynamicIslandVisible: Bool = false

    init() {
        // Observe the scene phase to update Dynamic Island visibility
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppStateChange), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    @objc private func handleAppStateChange() {
        // Set Dynamic Island visibility to true when the app enters the foreground
        isDynamicIslandVisible = true
        updateDynamicIsland()
    }

    func updateDynamicIsland() {
        // Update Dynamic Island
        WidgetCenter.shared.reloadAllTimelines()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

