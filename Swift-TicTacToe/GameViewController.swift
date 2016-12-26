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
    
    var currentPlayer = Game.Player.O
    var gridItemsViews = [GridItemView]()
    let gameBoard = GameBoard()
    
    func setupViews() {
        view.backgroundColor = .white
        
        gridItemsViews = [gridItemView_0, gridItemView_1, gridItemView_2,
                          gridItemView_3, gridItemView_4, gridItemView_5,
                          gridItemView_6, gridItemView_7, gridItemView_8]
        
        for (index, gridItemView) in gridItemsViews.enumerated() {
            gridItemView.index = index
            gridItemView.onViewTap = handleDidTapGridItem
        }
        
        gameBoard.reset()
    }
    
    func handleDidTapGridItem(gesture: UITapGestureRecognizer) {
        if let itemView = gesture.view as? GridItemView {
            //print("new tapped \(itemView.index)")
            if gameBoard.markGridItem(at: itemView.index, with: currentPlayer) {
                itemView.currentPlayer = currentPlayer
                currentPlayer = currentPlayer.flip()
            }
        }
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        gameBoard.reset()
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
