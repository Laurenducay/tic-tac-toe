//
//  ContentView.swift
//  tic-tac-toe
//
//  Created by Lauren Ducay on 5/16/25.
//

import SwiftUI

struct TicTacToeView: View {
    @StateObject var viewModel = TicTacToeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.8), .purple.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(edges: .all)
                VStack{
                    grid
                        .padding(.bottom, 20)
                    scoreKeeper
                }
            }
            .navigationStyle(title: "Tic Tac Toe", trailingText: nil, trailingAction: {})
        }
    }
    
    
    
    @ViewBuilder private var grid: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 360, height: 360)
                .foregroundColor(.white.opacity(0.4))
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 2, height: 330)
                .offset(x: 65)
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 2, height: 330)
                .offset(x: -65)
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 330, height: 2)
                .offset(x: 0, y: 60)
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 330, height: 2)
                .offset(x: 0, y: -60)
                .foregroundColor(.white)
            playGame
        }
    }
    
    @ViewBuilder private var scoreKeeper: some View {
        HStack {
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 140, height: 100)
                .offset(x: 185)
                .foregroundColor(.white.opacity(0.4))
                .overlay(Text("X :")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white),
                         alignment: .leading)
                .font(.system(size: 30))
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 140, height: 100)
                .offset(x: -185)
                .foregroundColor(.white.opacity(0.4))
                .overlay(Text("O :")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white),
                         alignment: .center)
                .font(.system(size: 30))
        }
    }
    
    @ViewBuilder private var playGame: some View {
        VStack(spacing: 20) {
            ForEach(0..<3, id: \.self) { row in
                HStack(spacing: 20) {
                    ForEach(0..<3, id: \.self) { col in
                        CellView(value: viewModel.board[row][col]) {
                            viewModel.playGame(row: row, column: col)
                        }
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.alertMessage),
                  dismissButton: .default(Text("Play Again?")) {
                viewModel.resetBoard()
            }
            )
        }
    }
    
    struct CellView: View {
        let value: String
        let action: () -> Void
        
        var body: some View {
            ZStack {
                Color.clear
                    .frame(width: 100, height: 100)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        action()
                    }
                Text(value)
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
        }
    }
}

struct TicTacToeView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}
