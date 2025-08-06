//
//  CustomAlert.swift
//  tic-tac-toe
//
//  Created by Lauren Ducay on 8/6/25.
//

import SwiftUI

struct CustomAlert: View {
    let title: String
    let message: String
    let confirmTitle: String
    let cancelTitle: String
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.9)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text(title)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(Color.purple.opacity(0.5))
                    .shadow(color: Color.purple.opacity(0.6), radius: 30, x: 0, y: 0)
                
                Text(message)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(Color.purple.opacity(0.5))
                    .shadow(color: Color.purple.opacity(0.6), radius: 30, x: 0, y: 0)
                
                HStack(spacing: 20) {
                    Button(action: onCancel) {
                        Text(cancelTitle)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    
                    Button(action: onConfirm) {
                        Text(confirmTitle)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(20)
            .padding(.horizontal, 40)
            .shadow(radius: 10)
        }
        .transition(.scale)
        .animation(.easeInOut, value: UUID())
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(title: "This is an Alert", message: "Alert Message", confirmTitle: "You Sure?", cancelTitle: "Cancel", onConfirm: {}, onCancel: {})
    }
}
