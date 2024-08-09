import SwiftUI
import ActivityKit

struct ContentView: View {
    @State private var activity: Activity<OrderStatusAttributes>? = nil
    @State var isOn: Bool = false
    @State private var selectedColor: Color = .blue
    private let colorKey = "selectedColor"

    init() {
        if let savedColorData = UserDefaults.standard.data(forKey: colorKey),
           let savedColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: savedColorData) {
            _selectedColor = State(initialValue: Color(savedColor))
        }
    }

    var body: some View {
        ZStack {
            Color.toggleBG.ignoresSafeArea()
            VStack {
                Text("Choose Color")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                    .padding()
                
                ColorSelectionView(selectedColor: $selectedColor)
                    .background(Color.toggleBG)
                    .cornerRadius(10)
                    .padding()
                
                Spacer()
                Text("OR").font(.largeTitle).bold().foregroundColor(.white)
                Spacer()
                
                ColorPicker("Custom Color", selection: $selectedColor)
                    .padding()
                    .background(Color.toggleBG)
                    .cornerRadius(10)
                    .position(x: 150, y: 2)
                    .frame(width: 300, height: 50)
                    .foregroundColor(selectedColor)
                    .bold()
                    .font(.system(size: 30))
                    .padding()
                
                Spacer()
                
                Toggle(isOn: $isOn) {
                    Text("Toggle \(isOn ? "On" : "Off")")
                        .foregroundColor(.white)
                }
                .toggleStyle(SlideToggleStyle())
                .scaleEffect(CGSize(width: 2, height: 2))
                .padding()
                .onChange(of: selectedColor) { newColor in
                    let uiColor = UIColor(newColor)
                    if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false) {
                        UserDefaults.standard.set(colorData, forKey: colorKey)
                    }
                    isOn = false
                }
                .onChange(of: isOn) { newValue in
                    Task {
                        if newValue {
                          
//                            await addLiveActivity()
                            print("on")
                            print("\(selectedColor)")
                        } else {
//                            await endActivity()
                        }
                    }
                }
            }
            .padding()
            
        }
        .onAppear {
            if let savedColorData = UserDefaults.standard.data(forKey: colorKey),
               let savedColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: savedColorData) {
                selectedColor = Color(savedColor)
            }
        }
    }

    func addLiveActivity() async {
        let orderAttributes = OrderStatusAttributes(name: "test")
        let initialContentState = OrderStatusAttributes.ContentState(value: 1)
        
        do {
            let newActivity = try Activity<OrderStatusAttributes>.request(
                attributes: orderAttributes,
                contentState: initialContentState
            )
            // Store the activity in state
            activity = newActivity
            print("Activity Added Successfully. id: \(activity?.id ?? "N/A")")
        } catch {
            print("Failed to add activity: \(error.localizedDescription)")
        }
    }

    func endActivity() async {
        guard let activity = activity else {
            print("No activity to end.")
            return
        }
        
        let finalContent = OrderStatusAttributes.ContentState(value: 2)
        let dismissalPolicy: ActivityUIDismissalPolicy = .default
        
        do {
            await activity.end(
                ActivityContent(state: finalContent, staleDate: nil),
                dismissalPolicy: dismissalPolicy
            )
         
            self.activity = nil
            print("Activity ended successfully.")
        }
    }
}
#Preview {
    ContentView()
}
