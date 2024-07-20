//
//  ColorSelectionView.swift
//  Dynamo Island
//
//  Created by Shubham Nanda on 20/07/24.
//

import SwiftUI

struct ColorSelectionView: View {
    @Binding var selectedColor: Color
    let neonPink = Color(red: 1.0, green: 0.43, blue: 0.78)
    let neonBlue = Color(red: 0.12, green: 0.32, blue: 1.0)
    let colors: [Color] = [
        .red, .orange, .yellow, .green, .blue, .purple,
        .pink, .brown, .cyan, .mint, .neonGreen, .neonCyan
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(colors, id: \.self) { color in
                ColorBox(color: color, isSelected: color == selectedColor)
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
        .padding()
    }
}

struct ColorBox: View {
    let color: Color
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            color
                .frame(width: 50, height: 50)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color.white : Color.clear, lineWidth: 3)
                )
        }
    }
}

#Preview {
    ColorSelectionView(selectedColor: .constant(.blue))
}
