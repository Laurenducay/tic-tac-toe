//
//  TicTacToeViewModel.swift
//  tic-tac-toe
//
//  Created by Lauren Ducay on 6/12/25.
//


import SwiftUI

struct designPatternX: Identifiable {
    let id = UUID()
    let size: CGFloat
    let rotation: Double
    let position: CGPoint
}

struct designPatternO: Identifiable {
    let id = UUID()
    let size: CGFloat
    let rotation: Double
    let position: CGPoint
}

class TicTacToeViewModel: ObservableObject {
    @Published var randomXs: [designPatternX] = []
    @Published var randomOs: [designPatternO] = []
    
    init() {
        randomXs = (0..<20).map { _ in
            designPatternX(
                size: CGFloat.random(in: 50...150),
                rotation: Double.random(in: 0...360),
                position: CGPoint(
                    x: CGFloat.random(in: 0...800),
                    y: CGFloat.random(in: 0...800)
                )
            )
        }
        randomOs = (0..<20).map { _ in
            designPatternO(
                size: CGFloat.random(in: 50...150),
                rotation: Double.random(in: 0...360),
                position: CGPoint(
                    x: CGFloat.random(in: 0...800),
                    y: CGFloat.random(in: 0...800)
                )
            )
        }
    }
}
