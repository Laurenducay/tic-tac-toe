//
//  TicTacToeViewModel.swift
//  tic-tac-toe
//
//  Created by Lauren Ducay on 6/12/25.
//


import SwiftUI

class designPatternX: Identifiable, ObservableObject {
    let id = UUID()
    let size: CGFloat
    @Published var rotation: Double
    let animationDuration: Double
    @Published var positionOffset: CGSize
    
    init(
        size: CGFloat = 100,
        rotation: Double = 0,
        animationDuration: Double = 5,
        position: CGPoint) {
            self.size = size
            self.rotation = rotation
            self.animationDuration = animationDuration
            self.positionOffset = CGSize(width: position.x - UIScreen.main.bounds.width/2,
                                         height: position.y - UIScreen.main.bounds.height/2)
        }
}

class designPatternO: Identifiable, ObservableObject {
    let id = UUID()
    let size: CGFloat
    @Published var rotation: Double
    let animationDuration: Double
    @Published var positionOffset: CGSize
    
    init(
        size: CGFloat = 100,
        rotation: Double = 0,
        animationDuration: Double = 5,
        position: CGPoint) {
            self.size = size
            self.rotation = rotation
            self.animationDuration = animationDuration
            self.positionOffset = CGSize(width: position.x - UIScreen.main.bounds.width/2,
                                   height: position.y - UIScreen.main.bounds.height/2)
    }
}

class TicTacToeViewModel: ObservableObject {
    @Published var isInGame = true
    @Published var gameEnded = false
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
    
    @Published var xScore: Int = 0
    @Published var oScore: Int = 0
    
    func generateXs() {
        for _ in 0..<5 {
            let randomXPosition = CGPoint(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                )
            let size = CGFloat.random(in: 40...120)
            let duration = Double.random(in: 6...12)
            let rotation = Double.random(in: 0...360)
            
            let newX = designPatternX(size: size, rotation: rotation, animationDuration: duration, position: randomXPosition)
            randomXs.append(newX)
        }
    }
    
    func generateOs() {
        for _ in 0..<5 {
            let randomOPosition = CGPoint(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                )
            let size = CGFloat.random(in: 40...120)
            let duration = Double.random(in: 6...12)
            let rotation = Double.random(in: 0...360)
            
            let newO = designPatternO(size: size, rotation: rotation, animationDuration: duration, position: randomOPosition)
            randomOs.append(newO)
        }
    }
    
    func animateOs(id: UUID) {
        if let index = randomOs.firstIndex(where: { $0.id == id }) {
            let duration = randomOs[index].animationDuration
            withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: true)) {
                randomOs[index].positionOffset.height -= 50
                randomOs[index].rotation += 180
            }
        }
    }
    
    func animateXs(id: UUID) {
        if let index = randomXs.firstIndex(where: { $0.id == id }) {
            let duration = randomXs[index].animationDuration
            withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: true)) {
                randomXs[index].positionOffset.height -= 50
                randomXs[index].rotation += 180
            }
        }
    }
    
    func animateAll() {
        for x in randomXs {
            withAnimation(.easeInOut(duration: x.animationDuration).repeatForever(autoreverses: true)) {
                x.positionOffset.height -= 50
                x.rotation += 180
            }
        }

        for o in randomOs {
            withAnimation(.easeInOut(duration: o.animationDuration).repeatForever(autoreverses: true)) {
                o.positionOffset.height -= 50
                o.rotation += 180
            }
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
    
    func updateScore(for player: String) {
        if player == "X" {
            xScore += 1
        } else if player == "O" {
            oScore += 1
        }
    }
    
    func resetScore() {
        xScore = 0
        oScore = 0
    }
    
    func playGame(row: Int, column: Int) {
        DispatchQueue.main.async {
            if self.board[row][column] == "" {
                self.board[row][column] = self.currentPlayer
                
                if self.checkWin(for: self.currentPlayer) {
                    self.alertMessage = "\(self.currentPlayer) wins!"
                    self.showAlert = true
                    self.gameEnded = true
                    self.updateScore(for: self.currentPlayer)
                } else if self.board.joined().allSatisfy({$0 != ""}){
                    self.alertMessage = "It's a draw!"
                    self.showAlert = true
                    self.gameEnded = true
                } else {
                    self.currentPlayer = self.currentPlayer == "X" ? "O" : "X"
                }
            }
        }
    }
}
