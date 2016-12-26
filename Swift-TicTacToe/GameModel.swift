//
//  GameModel.swift
//  Swift-TicTacToe
//
//  Created by Lahiru Lakmal on 2016-12-22.
//  Copyright © 2016 SoundofCode. All rights reserved.
//

import UIKit

struct Game {
    struct Board {
        static let Width = 3
        static let Height = 3
        static let Size = Width * Height
    }
    
    enum GridItem {
        case Free
        case Locked
    }
    
    enum Player : String {
        case X = "X"
        case O = "O"
        case E = "E"
        
        func spriteName() -> String {
            return self.rawValue
        }
        
        func flip() -> Player {
            switch self {
            case .O:
                return .X
            case .X:
                return .O
            default:
                return .E
            }
        }
    }
    
    enum Status {
        case Active
        case Won
        case Draw
    }
}

class GridItem {
    
    var status = Game.GridItem.Free
    var ownedPlayer = Game.Player.E
    
    func reset() {
        status = Game.GridItem.Free
    }
}

class GameBoard {
    
    private let gridItems: [GridItem] = {
        var items = [GridItem]()
        for _ in 0..<Game.Board.Size {
            items.append(GridItem())
        }
        return items
    }()
    
    // maps 2D grid position to linear position
    //
    func get1DPosition(from point:(x: Int, y: Int)) -> Int {
        return point.x + Game.Board.Width * point.y;
    }
    
    // maps linear position to 2D grid position
    //
    func get2DPosition(from index: Int) -> (x: Int, y: Int) {
        let x = index % Game.Board.Width;
        let y = index / Game.Board.Width;
        return (x, y)
    }
    
    func reset() {
        for gridItem in gridItems {
            gridItem.reset()
        }
    }
    
    // mark a grid item as locked, if a valid move is made with 2D position
    //
    func markGridItem(at pos:(x: Int, y: Int), with player: Game.Player) -> Bool {
        let index = get1DPosition(from: pos)
        return markGridItem(at: index, with: player)
    }
    
    // mark grid item as locked, if a valid move is made with 1D index
    //
    func markGridItem(at index: Int, with player: Game.Player) -> Bool {
        let gridItem = gridItems[index]
        
        if gridItem.status == Game.GridItem.Locked {
            return false
        }
        
        gridItem.status = Game.GridItem.Locked
        gridItem.ownedPlayer = player
        
        return true
    }
}

class GameSession {
    
    var wins = [Game.Player.O: 0, Game.Player.X: 0]
    var draws = 0
}

class Score {
    
    var column = [Int: Int]()
    var row = [Int: Int]()
    var diagonal = [Int: Int]()
    
    func reset () {
        column.removeAll()
        row.removeAll()
        diagonal.removeAll()
    }
}
