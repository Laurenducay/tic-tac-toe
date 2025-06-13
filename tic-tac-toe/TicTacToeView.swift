//
//  ContentView.swift
//  tic-tac-toe
//
//  Created by Lauren Ducay on 5/16/25.
//

import SwiftUI

struct TicTacToeView: View {
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 0) {
                Text("Score")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                scoreKeeper
                    .padding(.top)
                grid
                    .padding(.top)
                HStack {
                    RoundedRectangle(cornerRadius: 9)
                        .frame(width: 150, height: 50)
                        .foregroundColor(.blue.opacity(0.5))
                        .padding(.top)
                        .overlay {
                            Text("Restart")
                        }
                    RoundedRectangle(cornerRadius: 9)
                        .frame(width: 150, height: 50)
                        .foregroundColor(.blue.opacity(0.5))
                        .padding(.top)
                        .overlay {
                            Text("Pause")
                        }
                }

            }
            .navigationTitle(Text("Tic Tac Toe"))
        }
    }
    
    @ViewBuilder
    var grid: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 360, height: 360)
                .foregroundColor(.blue.opacity(0.5))
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 2, height: 330)
                .offset(x: 65)
                .foregroundColor(.blue)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 2, height: 330)
                .offset(x: -65)
                .foregroundColor(.blue)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 330, height: 2)
                .offset(x: 0, y: 60)
                .foregroundColor(.blue)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 330, height: 2)
                .offset(x: 0, y: -60)
                .foregroundColor(.blue)
        }
    }
    
    @ViewBuilder
    var scoreKeeper: some View {
        HStack {
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 140, height: 100)
                .offset(x: 185)
                .foregroundColor(.blue.opacity(0.2))
                .overlay(Text("X :")
                    .fontWeight(.bold)
                    .foregroundColor(.blue),
                         alignment: .leading)
                .font(.system(size: 30))
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 140, height: 100)
                .offset(x: -185)
                .foregroundColor(.blue.opacity(0.2))
                .overlay(Text("O :")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                         , alignment: .center)
                .font(.system(size: 30))
        }
    }
}

#Preview {
    TicTacToeView()
}
