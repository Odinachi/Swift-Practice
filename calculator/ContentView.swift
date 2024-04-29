//
//  ContentView.swift
//  calculator
//
//  Created by  Apple on 29/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    let buttons = [
           ["AC", "+/-", "%", "÷"],
           ["7", "8", "9", "×"],
           ["4", "5", "6", "-"],
           ["1", "2", "3", "+"],
           ["0", ".", "="],
       ]
    var body: some View {
        VStack {
            Text("000000000000")
                .fontWeight(.medium)
                .font(.system(size: 40)).frame(height: 300)
                .frame( maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottomTrailing  )
                .multilineTextAlignment(.trailing).padding(.bottom, 30)
            
            
            VStack(spacing: 10) {
                       ForEach(buttons.indices, id: \.self) { rowIndex in
                           HStack(spacing: 10) {
                               ForEach(buttons[rowIndex].indices, id: \.self) { columnIndex in
                                   let buttonTitle = buttons[rowIndex][columnIndex]
                                   Button(action: {
                                       // Handle button tap
                                       print("Tapped: \(buttonTitle)")
                                   }) {
                                       Text(buttonTitle)
                                           .font(.custom("DM Sans", size: 30)).fontWeight(.heavy).padding()
                                           .frame(width: 80, height: 80)
                                           .background(rowIndex == 0 ? Color.primary.opacity(0.7): .white.opacity(0.2))
                                           .foregroundColor(rowIndex == 0 ? .black : .white)
                                           .cornerRadius(50)
                                   }
                               }
                           }
                       }
                   }
                   .padding()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
