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
                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea(edges: .all)
                AnimatedBackgroundView(
                    Os: viewModel.randomOs,
                    Xs: viewModel.randomXs,
                    onAppear: {
                        viewModel.animateAll()
                    }
                )
                VStack{
                    grid
                        .padding(.bottom, 20)
                    scoreKeeper
                    footer
                        .padding(EdgeInsets(top: 100, leading: 20, bottom: 20, trailing: 20))
                }
            }
            .onAppear {
                viewModel.generateOs()
                viewModel.generateXs()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Small delay to ensure views are rendered
                    viewModel.animateAll()
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
                .shadow(color: Color.purple.opacity(0.6), radius: 10, x: 0, y: 0)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 2, height: 330)
                .offset(x: 65)
                .foregroundColor(.white)
                .shadow(color: Color.white.opacity(0.9), radius: 10, x: 0, y: 0)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 2, height: 330)
                .offset(x: -65)
                .foregroundColor(.white)
                .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 330, height: 2)
                .offset(x: 0, y: 60)
                .foregroundColor(.white)
                .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 330, height: 2)
                .offset(x: 0, y: -60)
                .foregroundColor(.white)
                .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
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
    
    @ViewBuilder var footer: some View {
        HStack(spacing: 0) {
            restartGameButton
            Spacer()
            endGameButton
        }
    }
    
    @ViewBuilder var restartGameButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 160, height: 50)
                .foregroundColor(.white.opacity(0.4))
                .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
            NavigationLink(destination: TicTacToeView()) {
                Text("Restart Game")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
            }
        }
    }
    
    @ViewBuilder var endGameButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 160, height: 50)
                .foregroundColor(.white.opacity(0.4))
                .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
            NavigationLink(destination: TicTacToeView()) {
                Text("End Game")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
            }
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
                if value == "X" {
                    Text(value)
                        .foregroundColor(.white)
                        .shadow(color: Color.purple.opacity(0.8), radius: 10, x: 0, y: 0)
                        .font(.system(size: 60, weight: .bold, design: .rounded))
                }
                else {
                    Text(value)
                        .foregroundColor(.white)
                        .shadow(color: Color.blue.opacity(0.8), radius: 10, x: 0, y: 0)
                        .font(.system(size: 60, weight: .bold, design: .rounded))

                }
            }
        }
    }
}

struct TicTacToeView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}
