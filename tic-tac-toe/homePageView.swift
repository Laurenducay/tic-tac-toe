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
                Text("""
                     Tic 
                     Tac
                     Toe
                    """
                )
                .font(.system(size: 75, weight: .bold, design: .rounded))
                .position(x: 200, y: 350)
                .foregroundColor(.white)
                generateBackgroundDesign
                newGameButton
            }
            .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
        }
    }
    
    @ViewBuilder
    var newGameButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 50)
                .foregroundColor(.white.opacity(0.4))
            NavigationLink(destination: TicTacToeView()) {
                Text("New Game")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
        }
        .position(x: 200, y: 600)
    }
    
    @ViewBuilder
    var generateBackgroundDesign: some View {
        ForEach(viewModel.randomXs) { x in
            Text("X")
                .font(.system(size: x.size, weight: .bold, design: .rounded))
                .foregroundStyle(.white.opacity(0.1))
                .rotationEffect(Angle(degrees: x.rotation))
                .position(x: x.position.x, y: x.position.y)
        }
        ForEach(viewModel.randomOs) { o in
            Text("O")
                .font(.system(size: o.size, weight: .bold, design: .rounded))
                .foregroundStyle(.white.opacity(0.1))
                .rotationEffect(Angle(degrees: o.rotation))
                .position(x: o.position.x, y: o.position.y)
        }
    }
}

#Preview {
    homePageView()
}
