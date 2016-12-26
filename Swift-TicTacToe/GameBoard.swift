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
    }
    
    struct Player {
        static let Count = 2
        static let X = "X"
        static let O = "O"
    }
    
    struct PlayerSprite {
        static let X = "playerO"
        static let O = "playerX"
        static let Empty = "empty"
    }
}

/*protocol GridItem {
    
    
}*/

class GridItem {
    
    
}

class GameBoard {
    
    private func map2Dto1D(_ pos:(x: Int, y: Int)) -> Int {
        return pos.x + Game.Board.Width * pos.y;
    }
    
    private func map1Dto2D(_ index: Int) -> (x: Int, y: Int) {
        let x = index % Game.Board.Width;
        let y = index / Game.Board.Width;
        return (x, y)
    }
}

class GridItemView: UIView {

    let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: Game.PlayerSprite.O))
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .yellow
        image.isUserInteractionEnabled = true
        return image
    }()
    
    //var
    
    override init(frame : CGRect) {
        super.init(frame : frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    func initializeView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        backgroundColor = .white
        addSubview(imageView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
    }
    
    func imageTapped(gesture: UITapGestureRecognizer)
    {
        print("tapped")
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
