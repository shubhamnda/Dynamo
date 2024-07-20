

import SwiftUI


struct ContentView: View {
    
    @State var isOn: Bool = false
    @State  private var selectedColor: Color = .blue
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
                                    .cornerRadius(10).position(x: 150,y:2).frame(width: 300, height: 50 ).foregroundColor(selectedColor).bold().font(.system(size:30))
                                    .padding()
                Spacer()
               
                Toggle(isOn: $isOn) {
                    Text("Toggle \(isOn ? "On" : "Off")")
                        .foregroundColor(.white)
                }
                .toggleStyle(SlideToggleStyle())
                .scaleEffect(CGSize(width: 2, height: 2))
                .padding()
                .onChange(of: selectedColor) { newColor in let uiColor = UIColor(newColor)
                               if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false) {
                                   UserDefaults.standard.set(colorData, forKey: colorKey)
                               }
                    isOn = false
                           }
                .onChange(of: isOn) { newValue in
                    if newValue {
                        print("on")
                        print("\(selectedColor)")
                    } else {
                        print("off")
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
