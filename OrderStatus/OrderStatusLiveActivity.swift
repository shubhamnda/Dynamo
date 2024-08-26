import ActivityKit
import WidgetKit
import SwiftUI

struct OrderStatusAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var value: Int
    }

    var name: String
}

struct OrderStatusLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: OrderStatusAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                // Your lock screen content
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Button("tap") {
                        print("tapped")}
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("center")
                    
                }
               
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T")
            } minimal: {
                Text("Minimal")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(dynamicTintColor)
        }
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var dynamicTintColor: Color {
        return colorScheme == .dark ? .red: .white
    }
}

extension OrderStatusAttributes {
    fileprivate static var preview: OrderStatusAttributes {
        OrderStatusAttributes(name: "World")
    }
}

extension OrderStatusAttributes.ContentState {
    fileprivate static var smiley: OrderStatusAttributes.ContentState {
        OrderStatusAttributes.ContentState(value: 0)
    }
}

#Preview("Notification", as: .content, using: OrderStatusAttributes.preview) {
    OrderStatusLiveActivity()
} contentStates: {
    OrderStatusAttributes.ContentState.smiley
}

#Preview("Expanded", as: .dynamicIsland(.expanded), using: OrderStatusAttributes.preview) {
    OrderStatusLiveActivity()
} contentStates: {
    OrderStatusAttributes.ContentState.smiley
}

#Preview("Compact", as: .dynamicIsland(.compact), using: OrderStatusAttributes.preview) {
    OrderStatusLiveActivity()
} contentStates: {
    OrderStatusAttributes.ContentState.smiley
}
