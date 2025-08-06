//
//  AnimatedBackgroundView.swift
//  tic-tac-toe
//
//  Created by Lauren Ducay on 8/6/25.
//


import SwiftUI

struct AnimatedBackgroundView: View {
    var Os: [designPatternO]
    var Xs: [designPatternX]
    var onAppear: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            ForEach(Xs) { x in
                AnimatedXs(x: x)
            }
            
            ForEach(Os) { o in
                AnimatedOs(o: o)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                onAppear?()
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
