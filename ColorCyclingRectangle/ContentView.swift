//
//  ContentView.swift
//  ColorCyclingRectangle
//
//  Created by Carlos Vinicius on 28/09/22.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var gradientStartX = 0.5
    var gradientStartY = 0.0
        
    var gradientEndX = 0.5
    var gradientEndY = 1.0
    
    var amount = 0.0
    var steps = 50
    
    var body: some View {
        ZStack {
            ForEach(0..<steps, id: \.self) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: UnitPoint(x: gradientStartX, y: gradientStartY),
                            endPoint: UnitPoint(x: gradientEndX, y: gradientEndY)
                        ),
                        lineWidth: 2
                    )
            }
            .drawingGroup()
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
            var targetHue = Double(value) / Double(steps) + amount

            if targetHue > 1 {
                targetHue -= 1
            }

            return Color(hue: targetHue, saturation: brightness, brightness: 1)
        }
}

struct ContentView: View {
    @State private var colorCycle = 0.0
    @State var gradientStartX = 0.5
    @State var gradientStartY = 0.0
    @State var gradientEndX = 0.5
    @State var gradientEndY = 1.0

    var body: some View {
        VStack {
            ColorCyclingRectangle(gradientStartX: gradientStartX, gradientStartY: gradientStartY, gradientEndX: gradientEndX, gradientEndY: gradientEndY, amount: colorCycle)
                .frame(width: 350, height: 450)
            
            HStack {
                Text("Color")
                Slider(value: $colorCycle)
            }
            
            HStack {
                Text("Start X")
                Slider(value: $gradientStartX)
            }
            
            HStack {
                Text("Start Y")
                Slider(value: $gradientStartY)
            }
            
            HStack {
                Text("End X")
                Slider(value: $gradientEndX)
            }
            
            HStack {
                Text("End Y")
                Slider(value: $gradientEndY)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
