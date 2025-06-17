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
                
                generateBackgroundDesign
                
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
    }
    
    @ViewBuilder
    var generateBackgroundDesign: some View {
        ZStack {
            ForEach(viewModel.randomXs) { x in
                AnimatedXs(x: x)
            }
            
            ForEach(viewModel.randomOs) { o in
                AnimatedOs(o: o)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                viewModel.animateAll()
            }
        }
    }
}

struct AnimatedOs: View {
    @ObservedObject var o: designPatternO
    
    var body: some View {
        Text("O")
            .font(.system(size: o.size, weight: .bold, design: .rounded))
            .foregroundStyle(.white.opacity(0.1))
            .rotationEffect(Angle(degrees: o.rotation))
            .offset(o.positionOffset)
    }
}

struct AnimatedXs: View {
    @ObservedObject var x: designPatternX
    
    var body: some View {
        Text("X")
            .font(.system(size: x.size, weight: .bold, design: .rounded))
            .foregroundStyle(.white.opacity(0.1))
            .rotationEffect(Angle(degrees: x.rotation))
            .offset(x.positionOffset)
    }
}

#Preview {
    homePageView()
}
