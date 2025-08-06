//
//  ContentView.swift
//  tic-tac-toe
//
//  Created by Lauren Ducay on 5/16/25.
//

import SwiftUI

struct TicTacToeView: View {
    @StateObject var viewModel = TicTacToeViewModel()
    @State private var showRestartAlert = false
    @State private var showEndGameAlert = false
    @State private var navigate = false
    @State private var showWinnerAlert = false
    
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
                    NavigationLink(destination: homePageView(), isActive: $navigate) {
                        EmptyView()
                    }
                }
                if viewModel.showAlert {
                    CustomAlert(
                        title: "Game Over",
                        message: viewModel.alertMessage,
                        confirmTitle: "Play Again",
                        cancelTitle: "End Game",
                        onConfirm: {
                            viewModel.resetBoard()
                            viewModel.showAlert = false
                        },
                        onCancel: {
                            viewModel.showAlert = false
                        }
                        )
                }
                
                if showRestartAlert {
                    CustomAlert(
                        title: "Restart Game?",
                        message: "Are you sure you want to restart the game?",
                        confirmTitle: "Restart",
                        cancelTitle: "Cancel",
                        onConfirm: {
                            viewModel.resetBoard()
                            viewModel.resetScore()
                            showRestartAlert = false
                        },
                        onCancel: {
                            showRestartAlert = false
                        }
                    )
                    .animation(.easeInOut, value: showRestartAlert)
                }
                if showEndGameAlert {
                    CustomAlert(
                        title: "End Game?",
                        message: "Are you sure you want to end the game?",
                        confirmTitle: "End Game",
                        cancelTitle: "Cancel",
                        onConfirm: {
                            viewModel.resetScore()
                            navigate = true
                            showEndGameAlert = false
                        },
                        onCancel: {
                            showEndGameAlert = false
                        }
                    )
                    .animation(.easeInOut, value: showEndGameAlert)
                }
            }
            .onAppear {
                viewModel.generateOs()
                viewModel.generateXs()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Small delay to ensure views are rendered
                    viewModel.animateAll()
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationStyle(title: "Tic Tac Toe", trailingText: nil, trailingAction: {})
        }
    }
    
    
    
    @ViewBuilder private var grid: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9)
                .stroke(Color.white.opacity(0.6), lineWidth: 2)
                .frame(width: 360, height: 360)
                .foregroundColor(.white.opacity(0.4))
                .shadow(color: Color.purple.opacity(0.6), radius: 10, x: 0, y: 0)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 4, height: 330)
                .offset(x: 65)
                .foregroundColor(.white)
                .shadow(color: Color.white.opacity(0.9), radius: 10, x: 0, y: 0)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 4, height: 330)
                .offset(x: -65)
                .foregroundColor(.white)
                .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 330, height: 4)
                .offset(x: 0, y: 60)
                .foregroundColor(.white)
                .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 330, height: 4)
                .offset(x: 0, y: -60)
                .foregroundColor(.white)
                .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
            playGame
        }
    }
    
    @ViewBuilder private var scoreKeeper: some View {
        HStack {
            reusableRectangle
                .overlay(Text("X : \(viewModel.xScore)")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .foregroundColor(.white))
                .font(.system(size: 30))
            Spacer()
            reusableRectangle
                .overlay(Text("O : \(viewModel.oScore)")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .foregroundColor(.white))
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
            Button("Restart Game") {
                showRestartAlert = true
            }
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
        }
    }
    
    @ViewBuilder var endGameButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 160, height: 50)
                .foregroundColor(.white.opacity(0.4))
                .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
            Button("End Game") {
                showEndGameAlert = true
            }
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
        }
    }
    
    @ViewBuilder var reusableRectangle: some View {
        RoundedRectangle(cornerRadius: 9)
            .stroke(Color.white.opacity(0.6), lineWidth: 2)
            .frame(width: 160, height: 100)
            .foregroundColor(.white.opacity(0.4))
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
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

struct TicTacToeView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}
