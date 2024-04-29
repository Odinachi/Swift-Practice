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
    
    @State private var lastInputIsOp = false
    
    
    
    let buttons = [
        ["C", "+/-", "%", "÷"],
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
                                if buttonTitle == "C" {
                                    
                                    input = ""
                                    operatorString = ""
                                    firstValue = ""
                                    lastInputIsOp = false
                                    
                                } else if buttonTitle == "=" {
                                    if !firstValue.isEmpty && !operatorString.isEmpty {
                                        
                                        lastInputIsOp = false
                                    }
                                    
                                } else if columnIndex == 3 {
                                    
                                    operatorString  = buttonTitle
                                    lastInputIsOp = true
                                    
                                } else if buttonTitle == "%" {
                                   
                                    if !input.isEmpty {
                                        
                                        input =   String(Double(input)!/100)
                                        lastInputIsOp = false
                                        firstValue = ""
                                    }
                                    
                                }  else {
                                    if lastInputIsOp {
                                        
                                        firstValue = input
                                        lastInputIsOp = false
                                        input = buttonTitle
                                        
                                    } else {
                                        input += buttonTitle
                                    }
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
    
    
    func formatNumber(_ number: Double?) -> String {
        if number  == nil {
            return ""
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.exponentSymbol = "e"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: number!)) ?? "\(String(describing: number))"
    }
}

#Preview {
    ContentView()
}
