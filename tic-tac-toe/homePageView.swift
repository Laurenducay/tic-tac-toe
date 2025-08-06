//
//  homePageView.swift
//  tic-tac-toe
//
//  Created by Lauren Ducay on 6/12/25.
//

import SwiftUI

struct homePageView: View {
    @StateObject var viewModel = TicTacToeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                    LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea()
                AnimatedBackgroundView(
                    Os: viewModel.randomOs,
                    Xs: viewModel.randomXs,
                    onAppear: {
                        viewModel.animateAll()
                    }
                )
                VStack {
                    Spacer()
                    Text("""
                     Tic 
                     Tac
                     Toe
                    """
                    )
                    .font(.system(size: 75, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
                    .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 0)
                    .shadow(color: Color.purple.opacity(0.6), radius: 30, x: 0, y:0)
                    Spacer()
                    newGameButton
                }
            }
            .onAppear {
                viewModel.generateOs()
                viewModel.generateXs()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Small delay to ensure views are rendered
                    viewModel.animateAll()
                }
            }
            
        }
    }
    
    
    @ViewBuilder var newGameButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 50)
                .foregroundColor(.white.opacity(0.4))
                .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
            NavigationLink(destination: TicTacToeView()) {
                Text("New Game")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
            }
        }
    }
}

#Preview {
    homePageView()
}
