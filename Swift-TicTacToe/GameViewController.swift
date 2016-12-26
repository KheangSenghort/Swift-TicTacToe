//
//  GameViewController.swift
//  Swift-TicTacToe
//
//  Created by Lahiru Lakmal on 2016-12-20.
//  Copyright © 2016 SoundofCode. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var gridItemView_0: GridItemView!
    @IBOutlet weak var gridItemView_1: GridItemView!
    @IBOutlet weak var gridItemView_2: GridItemView!
    @IBOutlet weak var gridItemView_3: GridItemView!
    @IBOutlet weak var gridItemView_4: GridItemView!
    @IBOutlet weak var gridItemView_5: GridItemView!
    @IBOutlet weak var gridItemView_6: GridItemView!
    @IBOutlet weak var gridItemView_7: GridItemView!
    @IBOutlet weak var gridItemView_8: GridItemView!
    
    @IBOutlet weak var gameStatusLabel: UILabel!
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    private let statusPlayerText = "Player"
    private let statusActiveText = "Turn"
    private let statusDrawText = "Game Is A Draw!"
    private let statusWonText = "Won!"
    private let gameManager = GameManager()
    private var gridItemsViews = [GridItemView]()
    
    private func setupViews() {
        view.backgroundColor = .white
        
        gridItemsViews = [gridItemView_0, gridItemView_1, gridItemView_2,
                          gridItemView_3, gridItemView_4, gridItemView_5,
                          gridItemView_6, gridItemView_7, gridItemView_8]
        
        for (index, gridItemView) in gridItemsViews.enumerated() {
            gridItemView.index = index
            gridItemView.onViewTap = handleDidTapGridItem
        }
        
        gameManager.onGameStatusUpdate = gameStatusUpdated
        gameManager.startNewGame()
        updateGameScoreLabel()
    }
    
    private func handleDidTapGridItem(gesture: UITapGestureRecognizer) {
        if let itemView = gesture.view as? GridItemView {
            // store the player who made the move
            let currentPlayer = gameManager.currentPlayer
            if gameManager.makeMove(at: itemView.index) {
                itemView.currentPlayer = currentPlayer
            }
        }
    }
    
    private func gameStatusUpdated(_ status: Game.Status) {
        switch status {
        case .Active:
            gameStatusLabel.text = "\(statusPlayerText) \(gameManager.currentPlayer.rawValue) \(statusActiveText)"
        case .Draw:
            gameStatusLabel.text = "\(statusDrawText)"
            updateGameScoreLabel()
        case .Won:
            gameStatusLabel.text = "\(statusPlayerText) \(gameManager.currentPlayer.rawValue) \(statusWonText)"
            updateGameScoreLabel()
        }
    }
    
    private func updateGameScoreLabel() {
        let gameSession = gameManager.session
        let playerXScore = gameSession.wins[Game.Player.X] ?? 0
        let playerOScore = gameSession.wins[Game.Player.O] ?? 0
        let ties = gameSession.draws
        
        gameScoreLabel.text = "\(Game.Player.X): \(playerXScore)    \(Game.Player.O): \(playerOScore)   \("TIES"): \(ties)"
    }
    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        gameManager.startNewGame()
        _ = gridItemsViews.map { $0.reset() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
