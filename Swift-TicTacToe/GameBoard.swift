//
//  GameBoard.swift
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
        case Playing
        case Won
        case Draw
    }
}

class GridItem {
    
    var status = Game.GridItem.Free
    //var index = 0
    
    func reset() {
        status = Game.GridItem.Free
    }
}

class Score {
    
    private var column = [Int: Int]()
    private var row = [Int: Int]()
    private var diagonal_1 = [Int: Int]()
    private var diagonal_2 = [Int: Int]()
    
    func reset () {
        column.removeAll()
        row.removeAll()
        diagonal_1.removeAll()
        diagonal_2.removeAll()
    }
    
    func isWinningMove(position pos:(x: Int, y: Int)) -> Bool {
        column[pos.x] = (column[pos.x] ?? 0) + 1
        row[pos.y] = (row[pos.y] ?? 0) + 1
        debugPrint("\(column[pos.x]) - \(row[pos.y])")
        
        guard let col = column[pos.x], col < 3, let row = row[pos.y], row < 3 else {
            return true
        }
        
        return false
    }
}

class ScoreManager {
    
    private var markedCount = 0
    private var score = [Game.Player.O: Score(), Game.Player.X: Score()]
    
    func isWinningMove(player: Game.Player, position pos: (x: Int, y: Int)) -> Game.Status {
        markedCount += 1
        
        if (score[player]?.isWinningMove(position: pos))! {
            return Game.Status.Won
        }
        
        if markedCount > 8 {
            return Game.Status.Draw
        }
        
        return Game.Status.Playing
    }
    
    func reset() {
        markedCount = 0
        for scoreItem in score.values {
            scoreItem.reset()
        }
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
    
    private let scoreManager = ScoreManager()
    
    var onGameOver: (Game.Status)->() = { status in
        print(status)
    }
    
    private func map2Dto1D(_ pos:(x: Int, y: Int)) -> Int {
        return pos.x + Game.Board.Width * pos.y;
    }
    
    private func map1Dto2D(_ index: Int) -> (x: Int, y: Int) {
        let x = index % Game.Board.Width;
        let y = index / Game.Board.Width;
        return (x, y)
    }
    
    func reset() {
        for gridItem in gridItems {
            gridItem.reset()
        }
        scoreManager.reset()
    }
    
    func markGridItem(at pos:(x: Int, y: Int)) {
        
    }
    
    func markGridItem(at index: Int, with player: Game.Player) -> Bool {
        let gridItem = gridItems[index]
        if gridItem.status == Game.GridItem.Locked {
            return false
        }
        gridItem.status = Game.GridItem.Locked
        
        let position = map1Dto2D(index)
        let gameStatus = scoreManager.isWinningMove(player: player, position: position)
        onGameOver(gameStatus)
        
        return true
    }
}

class GridItemView: UIView {
    
    var index = 0
    var currentPlayer: Game.Player = Game.Player.E {
        didSet {
            imageView.image = UIImage(named: currentPlayer.rawValue)
        }
    }

    private let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: Game.Player.E.rawValue))
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .yellow
        image.isUserInteractionEnabled = true
        return image
    }()
    
    override init(frame : CGRect) {
        super.init(frame : frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    private func initializeView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        addGestureRecognizer(tapGestureRecognizer)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        backgroundColor = .white
        addSubview(imageView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
    }
    
    @objc private func viewDidTap(gesture: UITapGestureRecognizer) {
        onViewTap(gesture)
    }
    
    // callback for ontap (instead of a delegate method)
    var onViewTap: (UITapGestureRecognizer)->() = { gesture in
        debugPrint("onViewTap")
    }
    
    func reset() {
        currentPlayer = Game.Player.E
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
