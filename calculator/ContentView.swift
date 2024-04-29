//
//  ContentView.swift
//  calculator
//
//  Created by  Apple on 29/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var offset: CGSize = .zero
    @State private var isRightSwipeDetected = false
    
    @State private var input = ""
    
    @State private var firstValue = ""
    
    @State private var operatorString = ""
    
  
    
    let buttons = [
           ["AC", "+/-", "%", "÷"],
           ["7", "8", "9", "×"],
           ["4", "5", "6", "-"],
           ["1", "2", "3", "+"],
           ["0", ".", "="],
       ]
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .lastTextBaseline,content:{
                Spacer()
                Text(input)
                    .fontWeight(.medium)
                    .font(.system(size: 80))
                    .lineLimit(1)
            }).frame(height: 250)  .gesture(
                DragGesture()
                    .onChanged { gesture in
                        
                            self.offset = gesture.translation
                        
                            if gesture.translation.width > 50 { 
                                
                                self.isRightSwipeDetected = true
                            }
                            else {
                                
                                self.isRightSwipeDetected = false
                            }
                        
                    }
                    .onEnded { gesture in
                      
                            
                            self.offset = .zero
                            
                            if self.isRightSwipeDetected {
                                
                            input = String(input.dropLast())
                                
                            self.isRightSwipeDetected = false
                                
                            }
                        
                    }
            )
        
            VStack(spacing: 15) {
                       ForEach(buttons.indices, id: \.self) { rowIndex in
                           HStack(spacing: 15) {
                               ForEach(buttons[rowIndex].indices, id: \.self) { columnIndex in
                                   let buttonTitle = buttons[rowIndex][columnIndex]
                                   Button(action: {
                                       if buttonTitle == "AC" {
                                           input = ""
                                       } else if buttonTitle == "=" {
                                           
                                       } else if buttonTitle == "%" {

                                           if !input.isEmpty {
                                             input =   String(Double(input)!/100)
                                           }
                                       }  else {
                                           input += buttonTitle
                                       }
                                       print(input)
                                      
                                   }) {
                                       Text(buttonTitle)
                                           .font(.custom("DM Sans", size: 30)).fontWeight(.black).padding()
                                           .frame(width:buttonTitle == "0" ? 170:  80, height: 80)
                                           .background(columnIndex == 3 || buttonTitle == "=" ? .orange:  rowIndex == 0 ? .primary.opacity(0.7): .primary.opacity(0.2))
                                           .foregroundColor(columnIndex == 3 || buttonTitle == "=" ? .white :rowIndex == 0 ? .black : .white)
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
