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
    let offset: CGFloat
    let animation: CGFloat
    let onAppear: Bool
}

struct designPatternO: Identifiable {
    let id = UUID()
    let size: CGFloat
    let rotation: Double
    let position: CGPoint
    let offset: CGFloat
    let animation: CGFloat
    let onAppear: Bool
}

class TicTacToeViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var randomXs: [designPatternX] = []
    @Published var randomOs: [designPatternO] = []
    @Published var board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @Published var currentPlayer: String = "X"
    @Published var winPatterns: [[(Int, Int)]] = [
        // Rows
        [(0, 0), (0, 1), (0, 2)],
        [(1, 0), (1, 1), (1, 2)],
        [(2, 0), (2, 1), (2, 2)],
        // Columns
        [(0, 0), (1, 0), (2, 0)],
        [(0, 1), (1, 1), (2, 1)],
        [(0, 2), (1, 2), (2, 2)],
        // Diagonals
        [(0, 0), (1, 1), (2, 2)],
        [(0, 2), (1, 1), (2, 0)]
    ]
    
    init() {
        randomXs = (0..<20).map { _ in
            designPatternX(
                size: CGFloat.random(in: 50...150),
                rotation: Double.random(in: 0...360),
                position: CGPoint(
                    x: CGFloat.random(in: 0...800),
                    y: CGFloat.random(in: 0...800)
                ),
                offset: CGFloat.random(in: 0...100),
                animation: CGFloat.random(in: 1...5),
                onAppear: true
                
            )
        }
        randomOs = (0..<20).map { _ in
            designPatternO(
                size: CGFloat.random(in: 50...150),
                rotation: Double.random(in: 0...360),
                position: CGPoint(
                    x: CGFloat.random(in: 0...800),
                    y: CGFloat.random(in: 0...800)
                ),
                offset: CGFloat.random(in: 0...100),
                animation: CGFloat.random(in: 1...5),
                onAppear: true
            )
        }
    }
    
    func resetBoard() {
        board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        currentPlayer = "X"
    }
    
    func checkWin(for player: String) -> Bool {
        return winPatterns.contains { pattern in
            pattern.allSatisfy { (row, col) in
                board[row][col] == player
            }
        }
    }
    
    func playGame(row: Int, column: Int) {
        if board[row][column] == "" {
            board[row][column] = currentPlayer
            
            if checkWin(for: currentPlayer) {
                alertMessage = "\(currentPlayer) wins!"
                showAlert = true
            } else if board.joined().allSatisfy({$0 != ""}){
                alertMessage = "It's a draw!"
                showAlert = true
            } else {
                currentPlayer = currentPlayer == "X" ? "O" : "X"
            }
        }
    }
}
